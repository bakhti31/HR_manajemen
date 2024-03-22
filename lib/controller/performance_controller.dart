// performance_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manajemen_sdm/model/performance_model.dart';

class PerformanceController {
  final String baseUrl = 'http://192.168.1.250:3000';
  Future<void> inputPerformance(int employeeId, String rating) async {
    final response = await http.post(
      Uri.parse('$baseUrl/performance'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'employee_id': employeeId,
        'month': DateTime.now().month,
        'year': DateTime.now().year,
        'rating': rating
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to input performance');
    }
  }

  Future<List<Performance>> getEmployeePerformance(int employeeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/performance/$employeeId'),
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Performance.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load performance data');
    }
  }
}
