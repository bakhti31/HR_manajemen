// input_performance_view.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:manajemen_sdm/controller/performance_controller.dart';
import 'package:manajemen_sdm/controller/employee_controller.dart';
import 'package:manajemen_sdm/model/employee_model.dart';

class InputPerformanceView extends StatefulWidget {
  const InputPerformanceView({super.key});

  @override
  _InputPerformanceViewState createState() => _InputPerformanceViewState();
}

class _InputPerformanceViewState extends State<InputPerformanceView> {
  final PerformanceController _controller = PerformanceController();
  final TextEditingController _ratingController = TextEditingController();
  final EmployeeController _employeeController = EmployeeController();
  late Future<List<Employee>> _futureEmployees;
  int employeeId = 0;

  @override
  void initState() {
    super.initState();
    _futureEmployees = _employeeController.getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Performance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                              employeeId = snapshot.data![index].id;
                            });
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            TextField(
              controller: _ratingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Rating'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final String rating = _ratingController.text;
                  await _controller.inputPerformance(employeeId, rating);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Performance input successful'),
                    ),
                  );
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to input performance: $e'),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
