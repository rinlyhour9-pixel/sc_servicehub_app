class CustomerProfile {
  final String name;
  final String phone;
  final String id;

  const CustomerProfile({
    required this.name,
    required this.phone,
    required this.id,
  });

  String get initials => name.trim().isEmpty
      ? '?'
      : name.trim().split(RegExp(r'\s+')).map((w) => w[0]).take(2).join().toUpperCase();
}
