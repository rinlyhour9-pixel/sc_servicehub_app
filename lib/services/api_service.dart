import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../models/booking_model.dart';
import '../models/user_role.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ApiUser {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final UserRole role;

  const ApiUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
  });

  factory ApiUser.fromJson(Map<String, dynamic> json) {
    final role = switch (json['role']) {
      'admin' => UserRole.admin,
      'technician' => UserRole.technician,
      _ => UserRole.client,
    };
    return ApiUser(
      id: int.parse(json['id'].toString()),
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString(),
      role: role,
    );
  }
}

class ApiServiceItem {
  final int id;
  final String name;
  final String? description;
  final int? durationMinutes;

  const ApiServiceItem({
    required this.id,
    required this.name,
    this.description,
    this.durationMinutes,
  });

  factory ApiServiceItem.fromJson(Map<String, dynamic> json) => ApiServiceItem(
        id: int.parse(json['id'].toString()),
        name: json['name']?.toString() ?? '',
        description: json['description']?.toString(),
        durationMinutes: int.tryParse(json['duration_minutes'].toString()),
      );
}

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  static const _configuredBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const _storage = FlutterSecureStorage();
  static final http.Client _client = http.Client();

  ApiUser? currentUser;
  String? _token;

  Uri get _baseUri {
    if (_configuredBaseUrl.isNotEmpty) {
      return Uri.parse(_configuredBaseUrl.endsWith('/')
          ? _configuredBaseUrl
          : '$_configuredBaseUrl/');
    }
    final host = !kIsWeb && defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2'
        : 'localhost';
    return Uri.parse('http://$host:8000/api/');
  }

  Future<ApiUser?> restoreSession() async {
    try {
      _token = await _storage.read(key: 'api_token');
    } on Exception {
      _token = null;
      currentUser = null;
      return null;
    }
    if (_token == null || _token!.isEmpty) return null;
    try {
      final response = await _request('GET', 'me');
      currentUser = ApiUser.fromJson(_map(response['user']));
      return currentUser;
    } on ApiException catch (error) {
      if (error.statusCode == 401) await clearSession();
      return null;
    } on Exception {
      return null;
    }
  }

  Future<ApiUser> login(
      {required String email, required String password}) async {
    final response = await _request('POST', 'auth/login',
        body: {
          'email': email.trim(),
          'password': password,
          'device_name': 'soft-creative-app',
        },
        authenticated: false);
    await _saveSession(response);
    return currentUser!;
  }

  Future<ApiUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await _request('POST', 'auth/register',
        body: {
          'name': name.trim(),
          'email': email.trim(),
          'phone': phone.trim(),
          'password': password,
          'password_confirmation': password,
          'device_name': 'soft-creative-app',
        },
        authenticated: false);
    await _saveSession(response);
    return currentUser!;
  }

  Future<void> forgotPassword(String email) async {
    await _request(
      'POST',
      'auth/forgot-password',
      body: {'email': email.trim()},
      authenticated: false,
    );
  }

  Future<void> logout() async {
    final oldToken = _token;
    await clearSession();
    if (oldToken == null) return;
    try {
      await _request('POST', 'auth/logout', bearerToken: oldToken);
    } on ApiException {
      // The local session is already cleared; revocation can be retried server-side.
    }
  }

  Future<void> clearSession() async {
    _token = null;
    currentUser = null;
    await _storage.delete(key: 'api_token');
  }

  Future<List<ApiServiceItem>> services() async {
    final response = await _request('GET', 'services', authenticated: false);
    return _list(response['data'])
        .map((item) => ApiServiceItem.fromJson(_map(item)))
        .toList();
  }

  Future<List<DateTime>> availability({
    required int serviceId,
    required DateTime date,
  }) async {
    final day = '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
    final response = await _request(
      'GET',
      'services/$serviceId/availability?date=$day',
      authenticated: false,
    );
    return _list(response['slots'])
        .map((slot) => DateTime.tryParse(slot.toString()))
        .whereType<DateTime>()
        .map((slot) => slot.toLocal())
        .toList();
  }

  Future<Booking> createBooking({
    required int serviceId,
    required DateTime scheduledAt,
    required String address,
    required String description,
    List<XFile> photos = const [],
  }) async {
    final fields = <String, String>{
      'service_id': serviceId.toString(),
      'scheduled_at': scheduledAt.toUtc().toIso8601String(),
      'address': address,
      if (description.trim().isNotEmpty) 'description': description.trim(),
    };
    final response = photos.isEmpty
        ? await _request('POST', 'bookings', body: fields)
        : await _multipartRequest('bookings', fields, photos);
    return Booking.fromApiJson(_map(response['data']));
  }

  Future<List<Booking>> bookings() async {
    final response = await _request('GET', 'bookings');
    return _list(response['data'])
        .map((item) => Booking.fromApiJson(_map(item)))
        .toList();
  }

  Future<Map<String, dynamic>> profile() async => _request('GET', 'me');

  Future<List<Map<String, dynamic>>> notifications() async {
    final response = await _request('GET', 'notifications');
    final payload = response['data'];
    final items = payload is Map ? payload['data'] : payload;
    return _list(items).map((item) => _map(item)).toList();
  }

  Future<void> markNotificationRead(String id) async {
    await _request('PATCH', 'notifications/$id/read');
  }

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
    bool authenticated = true,
    String? bearerToken,
  }) async {
    final uri = _baseUri.resolve(path);
    final headers = <String, String>{'Accept': 'application/json'};
    if (body != null) headers['Content-Type'] = 'application/json';
    final token = bearerToken ?? _token;
    if (authenticated && token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    http.Response response;
    try {
      final request = http.Request(method, uri)..headers.addAll(headers);
      if (body != null) request.body = jsonEncode(body);
      final streamed = await _client.send(request).timeout(
            const Duration(seconds: 20),
          );
      response = await http.Response.fromStream(streamed).timeout(
        const Duration(seconds: 20),
      );
    } on Exception catch (error) {
      if (error is ApiException) rethrow;
      throw const ApiException(
          'Could not reach the service. Check the API URL and your connection.');
    }

    final decoded =
        response.body.isEmpty ? <String, dynamic>{} : _decode(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(_errorMessage(decoded, response.statusCode),
          statusCode: response.statusCode);
    }
    return decoded;
  }

  Future<Map<String, dynamic>> _multipartRequest(
    String path,
    Map<String, String> fields,
    List<XFile> files,
  ) async {
    final request = http.MultipartRequest('POST', _baseUri.resolve(path))
      ..headers['Accept'] = 'application/json'
      ..fields.addAll(fields);
    final token = _token;
    if (token != null) request.headers['Authorization'] = 'Bearer $token';
    http.Response response;
    try {
      for (final file in files.take(8)) {
        request.files.add(http.MultipartFile.fromBytes(
          'photos[]',
          await file.readAsBytes(),
          filename: file.name,
        ));
      }
      response = await http.Response.fromStream(
              await _client.send(request).timeout(const Duration(seconds: 30)))
          .timeout(const Duration(seconds: 30));
    } on Exception {
      throw const ApiException(
          'Could not reach the service. Check the API URL and your connection.');
    }
    final decoded =
        response.body.isEmpty ? <String, dynamic>{} : _decode(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(_errorMessage(decoded, response.statusCode),
          statusCode: response.statusCode);
    }
    return decoded;
  }

  Future<void> _saveSession(Map<String, dynamic> response) async {
    final token = response['token']?.toString();
    if (token == null || token.isEmpty) {
      throw const ApiException('The server did not return an access token.');
    }
    _token = token;
    currentUser = ApiUser.fromJson(_map(response['user']));
    try {
      await _storage.write(key: 'api_token', value: token);
    } on Exception {
      _token = null;
      currentUser = null;
      throw const ApiException('Could not safely save the sign-in session.');
    }
  }

  static Map<String, dynamic> _decode(String body) {
    try {
      return _map(jsonDecode(body));
    } on FormatException {
      throw const ApiException('The server returned an invalid response.');
    }
  }

  static String _errorMessage(Map<String, dynamic> body, int status) {
    final errors = body['errors'];
    if (errors is Map && errors.isNotEmpty) {
      final first = errors.values.first;
      if (first is List && first.isNotEmpty) return first.first.toString();
    }
    final message = body['message']?.toString();
    if (message != null && message.isNotEmpty) return message;
    return 'Request failed ($status).';
  }

  static Map<String, dynamic> _map(dynamic value) =>
      value is Map<String, dynamic> ? value : <String, dynamic>{};

  static List<dynamic> _list(dynamic value) =>
      value is List ? value : const <dynamic>[];
}
