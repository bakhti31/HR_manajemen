// performance_view.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:manajemen_sdm/controller/performance_controller.dart';
import 'package:manajemen_sdm/model/performance_model.dart';
import 'package:manajemen_sdm/controller/employee_controller.dart';
import 'package:manajemen_sdm/model/employee_model.dart';

class PerformanceView extends StatefulWidget {
  const PerformanceView({super.key});

  @override
  _PerformanceViewState createState() => _PerformanceViewState();
}

class _PerformanceViewState extends State<PerformanceView> {
  final PerformanceController _controller = PerformanceController();
  late Future<List<Performance>> _futurePerformance;
  final EmployeeController _employeeController = EmployeeController();
  late Future<List<Employee>> _futureEmployees;
  int employeeId = 1;
  @override
  void initState() {
    super.initState();
    _futurePerformance =
        _controller.getEmployeePerformance(employeeId.toString());
    _futureEmployees = _employeeController.getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Performance'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Employee>>(
              future: _futureEmployees,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].name),
                        onTap: () {
                          setState(() {
                            employeeId = index;
                            _futurePerformance = _controller
                                .getEmployeePerformance(employeeId.toString());
                          });
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Performance>>(
              future: _futurePerformance,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            'Performance: ${snapshot.data![index].performance.toString()}'),
                        subtitle: Text(
                            "Employee Id: ${snapshot.data![index].employeeId} "),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
