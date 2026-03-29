import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7), // Neutral background
      appBar: _buildAppBar(colorScheme),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(colorScheme),
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildFilterChips(),
            const SizedBox(height: 32),
            _buildWorkSection(colorScheme),
            const SizedBox(height: 32),
            _buildUrgentSection(colorScheme),
            const SizedBox(height: 32),
            _buildPersonalSection(colorScheme),
            const SizedBox(height: 80), // Padding for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: colorScheme.primary, // Theme Orange
        foregroundColor: Colors.white,
        elevation: 4,
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // --- APP BAR ---
  AppBar _buildAppBar(ColorScheme colorScheme) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Icon(Icons.grid_view_rounded, color: Colors.grey.shade700, size: 24),
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
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  // --- HEADER ---
  Widget _buildHeader(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OVERVIEW',
          style: TextStyle(
            color: colorScheme.secondary, // Theme Blue
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Daily Progress',
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w900,
            color: Colors.black87,
            letterSpacing: -1.0,
          ),
        ),
      ],
    );
  }

  // --- SEARCH BAR ---
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search tasks...',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  // --- FILTER CHIPS ---
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip('All Tasks', isActive: true),
          const SizedBox(width: 10),
          _buildChip('Pending', isActive: false),
          const SizedBox(width: 10),
          _buildChip('Done', isActive: false),
          const SizedBox(width: 10),
          _buildChip('Overdue', isActive: false),
        ],
      ),
    );
  }

  Widget _buildChip(String label, {required bool isActive}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF9E2A0E)
            : Colors.grey.shade200, // Dark burnt orange for active
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  // --- WORK SECTION ---
  Widget _buildWorkSection(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Work',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '4',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'View all',
              style: TextStyle(
                color: Color(0xFFB3261E),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildWorkCard(
          colorScheme: colorScheme,
          icon: Icons.code,
          iconColor: colorScheme.secondary,
          iconBgColor: colorScheme.secondary.withOpacity(0.1),
          badgeText: 'IN PROGRESS',
          badgeColor: colorScheme.tertiary, // Theme Green
          badgeTextColor: Colors.black87,
          title: 'Redesign Landing Page',
          description: 'Review the latest Figma components for the Q3 release.',
          date: 'Oct 24, 2023',
          showAvatars: true,
        ),
        const SizedBox(height: 16),
        _buildWorkCard(
          colorScheme: colorScheme,
          icon: Icons.campaign,
          iconColor: colorScheme.primary,
          iconBgColor: colorScheme.primary.withOpacity(0.1),
          badgeText: 'PENDING',
          badgeColor: Colors.grey.shade300,
          badgeTextColor: Colors.black54,
          title: 'Marketing Strategy Sync',
          description: 'Discuss ad spend for the upcoming holiday campaign.',
          date: 'Oct 25, 2023',
          showAvatars: false,
        ),
      ],
    );
  }

  Widget _buildWorkCard({
    required ColorScheme colorScheme,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
    required String title,
    required String description,
    required String date,
    required bool showAvatars,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: badgeTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    date,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
              if (showAvatars)
                SizedBox(
                  width: 50,
                  height: 24,
                  child: Stack(
                    children: const [
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=33',
                          ),
                        ),
                      ),
                      Positioned(
                        right: 18,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=12',
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Icon(Icons.more_horiz, color: Colors.grey.shade400),
            ],
          ),
        ],
      ),
    );
  }

  // --- URGENT SECTION ---
  Widget _buildUrgentSection(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Urgent',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC02026),
              ),
            ), // Dark Red Text
            Icon(Icons.bolt, color: Color(0xFFC02026)),
          ],
        ),
        const SizedBox(height: 16),
        // Orange Gradient Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFD64411),
                colorScheme.primary,
              ], // Dark orange to Theme primary
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: Text(
                      'Server Migration\nCritical Path',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Icon(Icons.error_outline, color: Colors.white, size: 28),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.access_time_filled,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Due in 2 hours',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Overdue Edge-Border Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              left: BorderSide(color: Color(0xFFC02026), width: 4),
            ), // Red left border
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Client Presentation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Finalize slides for the board meeting at 3 PM.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFC02026),
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Overdue',
                        style: TextStyle(
                          color: Color(0xFFC02026),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- PERSONAL SECTION ---
  Widget _buildPersonalSection(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Personal',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 20, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildPersonalItem(
          icon: Icons.fitness_center,
          iconColor: Colors.white,
          iconBgColor: colorScheme.primary, // Orange
          title: 'Evening Workout',
          subtitle: 'Gym • 6:00 PM',
          trailingIcon: Icons.check_circle,
          trailingColor: Colors.grey.shade500,
        ),
        const SizedBox(height: 12),
        _buildPersonalItem(
          icon: Icons.shopping_cart,
          iconColor: colorScheme.secondary, // Blue
          iconBgColor: colorScheme.secondary.withOpacity(0.2),
          title: 'Grocery Shopping',
          subtitle: 'List: Almond milk, Eggs...',
          trailingIcon: Icons.radio_button_unchecked,
          trailingColor: Colors.grey.shade400,
        ),
        const SizedBox(height: 12),
        _buildPersonalItem(
          icon: Icons.book,
          iconColor: Colors.green.shade800,
          iconBgColor: colorScheme.tertiary.withOpacity(0.3), // Light Green
          title: 'Read 20 Pages',
          subtitle: 'Current: "The Creative Act"',
          trailingIcon: null, // Left null to show overlapping FAB in UI
          trailingColor: Colors.transparent,
        ),
      ],
    );
  }

  Widget _buildPersonalItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required IconData? trailingIcon,
    required Color trailingColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          if (trailingIcon != null)
            Icon(trailingIcon, color: trailingColor, size: 24),
        ],
      ),
    );
  }
}
