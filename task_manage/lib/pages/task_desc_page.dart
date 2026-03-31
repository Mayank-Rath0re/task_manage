import 'package:flutter/material.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: const Color(
        0xFFF4F5F7,
      ), // Light grayish-white background
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTags(colorScheme),
            const SizedBox(height: 16),
            _buildTitle(colorScheme),
            const SizedBox(height: 16),
            _buildMetaData(),
            const SizedBox(height: 24),
            _buildTaskDescription(),
            const SizedBox(height: 32),
            _buildSubtasksSection(colorScheme),
            const SizedBox(height: 32),
            _buildBottomActionCard(colorScheme),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // --- TAGS (High Priority, Development) ---
  Widget _buildTags(ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.secondary, // Using Theme Blue
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            'HIGH PRIORITY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'DEVELOPMENT',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  // --- TITLE (With italicized colored text) ---
  Widget _buildTitle(ColorScheme colorScheme) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.w900,
          color: Colors.black87,
          height: 1.1,
          letterSpacing: -0.5,
        ),
        children: [
          const TextSpan(text: 'Rebrand the\n'),
          TextSpan(
            text: 'Kinetic ',
            style: TextStyle(
              color: colorScheme.primary, // Using Theme Orange
              fontStyle: FontStyle.italic,
            ),
          ),
          const TextSpan(text: 'Design\nSystem'),
        ],
      ),
    );
  }

  // --- METADATA (Date & Time) ---
  Widget _buildMetaData() {
    return Row(
      children: [
        const Icon(
          Icons.calendar_today_outlined,
          size: 16,
          color: Colors.blueGrey,
        ),
        const SizedBox(width: 6),
        const Text(
          'Due: Oct 24,\n2023',
          style: TextStyle(color: Colors.black87, fontSize: 13),
        ),
        const SizedBox(width: 24),
        const Icon(Icons.access_time, size: 16, color: Colors.redAccent),
        const SizedBox(width: 6),
        const Text(
          '4:00 PM\nEST',
          style: TextStyle(color: Colors.black87, fontSize: 13),
        ),
      ],
    );
  }

  // --- TASK DESCRIPTION CARD ---
  Widget _buildTaskDescription() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Task Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'The current brand identity feels too static and corporate. We need to transition towards a "Kinetic Canvas" aesthetic. This involves removing all 1px borders, increasing white space by 40%, and implementing tonal layering. Focus on the core components first: buttons, cards, and navigation clusters.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // --- SUBTASKS SECTION ---
  Widget _buildSubtasksSection(ColorScheme colorScheme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtasks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.secondary, // Using Theme Blue
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '2/5 Done',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSubtaskItem('Audit existing 1px border usage', true, colorScheme),
        _buildSubtaskItem(
          'Define new tonal elevation scale',
          true,
          colorScheme,
        ),
        _buildSubtaskItem(
          'Design "Pulse" chips for status updates',
          false,
          colorScheme,
        ),
        _buildSubtaskItem(
          'Implement 135-degree primary gradients',
          false,
          colorScheme,
        ),
        _buildSubtaskItem(
          'Test contrast on dark-mode surfaces',
          false,
          colorScheme,
        ),
      ],
    );
  }

  Widget _buildSubtaskItem(String title, bool isDone, ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isDone
                ? colorScheme.tertiary
                : Colors.grey.shade400, // Using Theme Green for done
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isDone ? Colors.grey.shade500 : Colors.black87,
                decoration: isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- BOTTOM META CARD (Assignee, Project, Actions) ---
  Widget _buildBottomActionCard(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // Slightly darker grey card
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Assignee
          const Text(
            'ASSIGNEE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=33',
                ), // Placeholder avatar
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sarah Jenkins',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Lead Product Designer',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Project
          const Text(
            'PROJECT',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                '2024 Design Refresh',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Visual Reference
          const Text(
            'VISUAL REFERENCE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?q=80&w=600&auto=format&fit=crop',
                ), // Placeholder layout image
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.zoom_in, color: Colors.black87),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Container(
            width: double.infinity,
            height: 54,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  const Color(0xFFFFA07A),
                ], // Theme Primary Orange to lighter orange
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(27),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
              child: const Text(
                'COMPLETE TASK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
              child: Text(
                'REQUEST REVIEW',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
