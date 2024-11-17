class HealthRecord {
  final DateTime date;
  final String scan;
  final String diagnosis;
  final String treatment;

  HealthRecord({
    required this.date,
    required this.scan,
    required this.diagnosis,
    required this.treatment,
  });
}
