// attendance_controller.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AttendanceController {
  final String baseUrl = 'http://192.168.1.250';

  Future<void> markAttendance(int employeeId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/index.php'),
      headers: {
        "Accept": "application/x-ww-form-urlencoded",
      },
      body: {
        'employee_id': employeeId.toString(),
        'date': DateTime.now().toString()
      }, // Change employee_id as needed
    );
    debugPrint(response.body);
    if (response.statusCode != 200) {
      debugPrint(response.body);
      throw Exception('Failed to mark attendance');
    }
  }
}
