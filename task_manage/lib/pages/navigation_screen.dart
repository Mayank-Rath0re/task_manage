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
    const Center(child: Text('Settings Page Coming Soon')), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      // The body uses an IndexedStack to keep the state of the pages alive
      // when you switch between them, rather than rebuilding them from scratch.
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: const SizedBox(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.grid_view_rounded, color: colorScheme.primary, size: 24),
            const SizedBox(width: 8),
            const Text(
              'TaskFlow',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: const [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=11',
            ), // Placeholder avatar
          ),
          SizedBox(width: 20),
        ],
      ),
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
