class TechnicianProfile {
  final String name;
  final String phone;
  final bool online;
  final bool topPro;
  final double monthlyRate;
  final double perServiceRate;
  final int completedCount;
  final List<String> skills;
  final String availabilityDays;
  final String availabilityHours;

  const TechnicianProfile({
    required this.name,
    required this.phone,
    required this.online,
    required this.topPro,
    required this.monthlyRate,
    required this.perServiceRate,
    required this.completedCount,
    required this.skills,
    required this.availabilityDays,
    required this.availabilityHours,
  });

  String get skillSummary => skills.join(', ');

  // TODO: replace with data from your technician management API.
  static const List<TechnicianProfile> demoDirectory = [
    TechnicianProfile(
      name: 'Sok Dara',
      phone: '010314240',
      online: true,
      topPro: true,
      monthlyRate: 150,
      perServiceRate: 5,
      completedCount: 240,
      skills: ['AC Repair', 'Washing Machine Repair', 'Electrician', 'Refrigerator Maintenance'],
      availabilityDays: 'Monday - Saturday',
      availabilityHours: '8:00 AM - 6:00 PM',
    ),
    TechnicianProfile(
      name: 'Sokun Therayuk',
      phone: '010314240',
      online: true,
      topPro: false,
      monthlyRate: 120,
      perServiceRate: 4,
      completedCount: 180,
      skills: ['AC Repair', 'TV Repair'],
      availabilityDays: 'Monday - Friday',
      availabilityHours: '9:00 AM - 5:00 PM',
    ),
    TechnicianProfile(
      name: 'Dara Vong',
      phone: '098765432',
      online: false,
      topPro: false,
      monthlyRate: 100,
      perServiceRate: 4,
      completedCount: 96,
      skills: ['TV Repair', 'Cooking Range'],
      availabilityDays: 'Tuesday - Sunday',
      availabilityHours: '10:00 AM - 7:00 PM',
    ),
    TechnicianProfile(
      name: 'Mao Sophal',
      phone: '012456789',
      online: true,
      topPro: false,
      monthlyRate: 110,
      perServiceRate: 4,
      completedCount: 132,
      skills: ['Painter', 'Home Cleaning'],
      availabilityDays: 'Monday - Saturday',
      availabilityHours: '8:00 AM - 5:00 PM',
    ),
    TechnicianProfile(
      name: 'Chan Vuthy',
      phone: '016987654',
      online: false,
      topPro: false,
      monthlyRate: 90,
      perServiceRate: 3,
      completedCount: 58,
      skills: ['Plumber Repair'],
      availabilityDays: 'Monday - Friday',
      availabilityHours: '8:00 AM - 4:00 PM',
    ),
  ];
}
