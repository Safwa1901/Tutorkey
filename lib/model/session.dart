class Session {
  final String id;
  final String tutorId;
  final String tutorName;
  final String tuteeId;
  final String tuteeName;
  final String subject;
  final String date;
  final String day;
  final String venue;
  final int slot;
  final String status;
  final bool rate;
  final bool mark;

  Session({
    required this.id,
    required this.tutorId,
    required this.tutorName,
    required this.tuteeId,
    required this.tuteeName,
    required this.subject,
    required this.date,
    required this.day,
    required this.venue,
    required this.slot,
    required this.status,
    required this.rate,
    required this.mark,
  });
}
