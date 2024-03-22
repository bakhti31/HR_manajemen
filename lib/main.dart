// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'HR Management System',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HR Management System'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to Employee List page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => EmployeeListPage()),
//                 );
//               },
//               child: const Text('Employee List'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to Performance Report page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => PerformanceReportPage()),
//                 );
//               },
//               child: const Text('Performance Report'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EmployeeListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Employee List'),
//       ),
//       body: ListView.builder(
//         itemCount: 10, // Replace with actual number of employees
//         itemBuilder: (context, index) {
//           // Replace with Employee data from database
//           return ListTile(
//             title: Text('Employee ${index + 1}'),
//             onTap: () {
//               // Navigate to Employee Detail page
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         EmployeeDetailPage(employeeId: index + 1)),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class EmployeeDetailPage extends StatelessWidget {
//   final int employeeId;

//   EmployeeDetailPage({required this.employeeId});

//   @override
//   Widget build(BuildContext context) {
//     // Fetch employee data from database based on employeeId
//     // Replace with actual data retrieval logic
//     String employeeName = 'Employee $employeeId';
//     String employeePosition = 'Position';
//     String employeePerformance = 'Performance';

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Employee Detail'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Name: $employeeName'),
//             Text('Position: $employeePosition'),
//             Text('Performance: $employeePerformance'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PerformanceReportPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Performance Report'),
//       ),
//       body: const Center(
//         child: Text('Performance Report Page'),
//       ),
//     );
//   }
// }
// main.dart
// main.dart
// main.dart

// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:manajemen_sdm/view/register_employee_view.dart';
import 'package:manajemen_sdm/view/attendance_view.dart';
import 'package:manajemen_sdm/view/performance_view.dart';
import 'package:manajemen_sdm/view/input_performance_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management App',
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: TabNavigation(),
    );
  }
}

class TabNavigation extends StatefulWidget {
  const TabNavigation({super.key});

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    RegisterEmployeeView(),
    AttendanceView(),
    PerformanceView(),
    InputPerformanceView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Management'),
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Register',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Performance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Performance Input',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
