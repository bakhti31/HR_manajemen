// // attendance_view.dart

// import 'package:flutter/material.dart';
// import 'package:manajemen_sdm/controller/attendance_controller.dart';

// class AttendanceView extends StatefulWidget {
//   @override
//   _AttendanceViewState createState() => _AttendanceViewState();
// }

// class _AttendanceViewState extends State<AttendanceView> {
//   final AttendanceController _controller = AttendanceController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             try {
//               await _controller.markAttendance();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Attendance marked successfully'),
//                 ),
//               );
//             } catch (e) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Failed to mark attendance: $e'),
//                 ),
//               );
//             }
//           },
//           child: Text('Mark Attendance'),
//         ),
//       ),
//     );
//   }
// }
// attendance_view.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:manajemen_sdm/controller/attendance_controller.dart';
import 'package:manajemen_sdm/controller/employee_controller.dart';
import 'package:manajemen_sdm/model/employee_model.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  _AttendanceViewState createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  final AttendanceController _attendanceController = AttendanceController();
  final EmployeeController _employeeController = EmployeeController();
  late Future<List<Employee>> _futureEmployees;

  @override
  void initState() {
    super.initState();
    _futureEmployees = _employeeController.getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: FutureBuilder<List<Employee>>(
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
                    _markAttendance((snapshot.data![index].id));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _markAttendance(int employeeId) async {
    try {
      await _attendanceController.markAttendance(employeeId);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Attendance marked successfully'),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to mark attendance: $e'),
        ),
      );
    }
  }
}
