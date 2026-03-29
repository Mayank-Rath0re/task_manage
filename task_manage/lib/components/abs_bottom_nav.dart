import 'package:flutter/material.dart';

class AbsBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AbsBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.grid_view_rounded,
                label: 'DASH',
                index: 0,
                colorScheme: colorScheme,
              ),
              _buildNavItem(
                icon: Icons.format_list_bulleted,
                label: 'TASKS',
                index: 1,
                colorScheme: colorScheme,
              ),
              _buildNavItem(
                icon: Icons.bolt_outlined,
                label: 'FOCUS',
                index: 2,
                colorScheme: colorScheme,
              ),
              _buildNavItem(
                icon: Icons.settings_outlined,
                label: 'SETTINGS',
                index: 3,
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required ColorScheme colorScheme,
  }) {
    final isActive = currentIndex == index;

    // Using the dark red/orange from your design for the active state
    const activeColor = Color(0xFFB3261E);
    const activeBgColor = Color(0xFFF8ECEA);
    final inactiveColor = Colors.grey.shade500;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: activeBgColor,
                borderRadius: BorderRadius.circular(20),
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? activeColor : inactiveColor, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : inactiveColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
