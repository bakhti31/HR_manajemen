// attendance_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class AttendanceController {
  final String baseUrl = 'http://sdm-management.infinityfreeapp.com';

  Future<void> markAttendance(int employeeId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'employee_id': employeeId,
        'date': DateTime.now().toString()
      }), // Change employee_id as needed
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to mark attendance');
    }
  }
}
