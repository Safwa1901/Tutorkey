class Schedule {
  final String id;
  final bool slot1;
  final bool slot2;
  final bool slot3;

  Schedule({
    required this.id,         // Make id required
    this.slot1 = false,      // Default value for slot1
    this.slot2 = false,      // Default value for slot2
    this.slot3 = false,      // Default value for slot3
  });
}

class Day {
  final String mon;
  final String tue;
  final String wed;
  final String thu;
  final String fri;
  final String sat;
  final String sun;

  Day({
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
  });
}
