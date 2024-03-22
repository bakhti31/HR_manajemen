// employee_controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manajemen_sdm/model/employee_model.dart';

class EmployeeController {
  final String baseUrl = 'http://127.0.0.1:3000';

  Future<int> registerEmployee(String name, String position) async {
    final response = await http.post(
      Uri.http("192.168.1.250:3000", "register"),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
      body: json.encode({'name': name, 'position': position}),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['id'];
    } else {
      throw Exception('Failed to register employee ${(response.statusCode)}');
    }
  }

  Future<List<Employee>> getEmployees() async {
    final response = await http.get(Uri.parse('$baseUrl/employees'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Employee.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }
}
