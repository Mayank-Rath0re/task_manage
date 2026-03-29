import 'package:flutter/material.dart';
import 'package:task_manage/pages/task_create_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: const Color(
        0xFFF4F5F7,
      ), // Light grayish-white background
      appBar: _buildAppBar(colorScheme),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateText(),
            const SizedBox(height: 8),
            _buildGreeting(colorScheme),
            const SizedBox(height: 16),
            _buildStreakBadge(colorScheme),
            const SizedBox(height: 32),
            _buildDailyEnergyCard(colorScheme),
            const SizedBox(height: 32),
            _buildTopPrioritiesHeader(colorScheme),
            const SizedBox(height: 16),
            _buildPriorityList(colorScheme),
            const SizedBox(height: 32),
            _buildDeepWorkBanner(colorScheme),
            const SizedBox(height: 80), // Padding for FAB overlap
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewTaskPage()),
          );
        },
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        child: const Icon(Icons.add, size: 28),
      ),
      // Positioning the FAB slightly above the bottom nav
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
    );
  }

  // --- HEADER SECTION ---
  Widget _buildDateText() {
    return Text(
      'WEDNESDAY, MAY 24',
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildGreeting(ColorScheme colorScheme) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.w900,
          color: Colors.black87,
          height: 1.05,
          letterSpacing: -1.0,
        ),
        children: [
          const TextSpan(text: 'Ready to\n'),
          TextSpan(
            text: 'conquer',
            style: TextStyle(
              color: colorScheme.primary, // Theme Orange
              fontStyle: FontStyle.italic,
            ),
          ),
          const TextSpan(text: ',\nAlex?'),
        ],
      ),
    );
  }

  Widget _buildStreakBadge(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.secondary, // Theme Blue
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.bolt, color: Colors.white, size: 18),
          SizedBox(width: 4),
          Text(
            '12 DAY STREAK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // --- DAILY ENERGY CARD ---
  Widget _buildDailyEnergyCard(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background decorative circle (top right)
          Positioned(
            right: -40,
            top: -40,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: colorScheme.primary.withValues(alpha: 0.05),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily Energy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: CircularProgressIndicator(
                        value: 0.75,
                        strokeWidth: 16,
                        backgroundColor: Colors.grey.shade100,
                        color: colorScheme.primary,
                        strokeCap: StrokeCap
                            .round, // Rounded edges on the progress bar
                      ),
                    ),
                    Column(
                      children: const [
                        Text(
                          '75%',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'COMPLETE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _buildEnergyStatBox(
                      'DONE',
                      '09',
                      colorScheme.tertiary,
                    ),
                  ), // Theme Green for done
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildEnergyStatBox(
                      'LEFT',
                      '03',
                      colorScheme.primary,
                    ),
                  ), // Theme Orange for left
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnergyStatBox(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  // --- PRIORITIES SECTION ---
  Widget _buildTopPrioritiesHeader(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Top Priorities',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          'VIEW ALL',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: colorScheme.secondary,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildPriorityList(ColorScheme colorScheme) {
    return Column(
      children: [
        _buildPriorityCard(
          title: 'Hero Section Design',
          subtitle: 'Due in 2 hours • Client Project',
          icon: Icons.design_services,
          iconBgColor: colorScheme.secondary.withOpacity(0.1),
          iconColor: colorScheme.secondary,
          badgeText: 'URGENT',
          badgeColor: const Color(0xFFB3261E), // Dark Red
        ),
        const SizedBox(height: 12),
        _buildPriorityCard(
          title: 'Mindfulness Session',
          subtitle: 'Scheduled for 4:00 PM • Personal',
          icon: Icons.psychology,
          iconBgColor: colorScheme.tertiary.withOpacity(0.15),
          iconColor: Colors.green.shade800,
          badgeText: 'FOCUSED',
          badgeColor: colorScheme.secondary,
        ),
        const SizedBox(height: 12),
        _buildPriorityCard(
          title: 'Team Update Email',
          subtitle: 'End of day • Internal',
          icon: Icons.mail_outline,
          iconBgColor: Colors.grey.shade200,
          iconColor: Colors.grey.shade700,
          badgeText: 'LATER',
          badgeColor: Colors.grey.shade300,
          badgeTextColor: Colors.black54,
        ),
      ],
    );
  }

  Widget _buildPriorityCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String badgeText,
    required Color badgeColor,
    Color badgeTextColor = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
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
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(12),
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
    );
  }

  // --- DEEP WORK BANNER ---
  Widget _buildDeepWorkBanner(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF383838),
            Color(0xFF1E242B),
          ], // Dark Grey to Dark Navy
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          const Text(
            'Deep Work\nawaits. Silence the\nworld.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Activate Focus Mode to\nblock all notifications and\nenter the flow state.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  const Color(0xFFFFA07A),
                ], // Orange gradient
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.bolt, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'ENTER FOCUS\nMODE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
