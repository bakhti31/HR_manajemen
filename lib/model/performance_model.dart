// performance_model.dart

class Performance {
  final int id;
  final int employeeId;
  final String performance;

  Performance({
    required this.id,
    required this.employeeId,
    required this.performance,
  });

  factory Performance.fromJson(Map<String, dynamic> json) {
    return Performance(
      id: json['id'],
      employeeId: json['employee_id'],
      performance: json['rating'],
    );
  }
}
