// performance_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manajemen_sdm/model/performance_model.dart';

class PerformanceController {
  final String baseUrl = 'http://192.168.1.250';
  Future<void> inputPerformance(String employeeId, String rating) async {
    final response = await http.post(
      Uri.parse('$baseUrl/'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'employee_id': employeeId,
        'month': DateTime.now().month.toString(),
        'year': DateTime.now().year.toString(),
        'rating': rating
      },
    );
    debugPrint(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to input performance');
    }
  }

  Future<List<Performance>> getEmployeePerformance(String employeeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/?performance=1&employeeId=$employeeId'),
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Performance.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load performance data');
    }
  }
}
