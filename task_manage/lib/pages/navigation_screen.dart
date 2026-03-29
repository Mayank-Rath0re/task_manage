import 'package:flutter/material.dart';
import 'package:task_manage/components/abs_bottom_nav.dart';
import 'dashboard_page.dart'; // Your previous files
import 'tasks_page.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // List of pages to show based on the selected tab
  final List<Widget> _pages = [
    const DashboardPage(),
    const TasksPage(),
    const Center(child: Text('Focus Page Coming Soon')), // Placeholder
    const Center(child: Text('Settings Page Coming Soon')), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body uses an IndexedStack to keep the state of the pages alive
      // when you switch between them, rather than rebuilding them from scratch.
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AbsBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
