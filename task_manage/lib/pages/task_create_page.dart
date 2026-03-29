import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  String _selectedPriority = 'URGENT';
  String _selectedCategory = 'Work';

  // State for dynamic subtasks
  final List<TextEditingController> _subtaskControllers = [
    TextEditingController(), // Start with one empty subtask
  ];

  @override
  void dispose() {
    for (var controller in _subtaskControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addSubtask() {
    setState(() {
      _subtaskControllers.add(TextEditingController());
    });
  }

  void _removeSubtask(int index) {
    setState(() {
      _subtaskControllers[index].dispose();
      _subtaskControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // A subtle off-white background to let white cards pop
    final bgColor = const Color(0xFFF4F5F8);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'New Task',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/100?img=5',
              ), // Placeholder avatar
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            Text(
              'KINETIC WORKFLOW',
              style: TextStyle(
                color: colorScheme.secondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                  height: 1.1,
                ),
                children: [
                  const TextSpan(text: 'What are we\n'),
                  TextSpan(
                    text: 'crushing\n',
                    style: TextStyle(color: colorScheme.primary),
                  ),
                  const TextSpan(text: 'today?'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // --- TASK TITLE ---
            _buildSectionHeader('TASK TITLE'),
            _buildTextField(hint: 'Review quarterly performance.'),
            const SizedBox(height: 24),

            // --- DESCRIPTION ---
            _buildSectionHeader('DESCRIPTION'),
            _buildTextField(
              hint: 'Add some context or specific\ngoals for this task...',
              maxLines: 4,
            ),
            const SizedBox(height: 24),

            // --- SUBTASKS (NEW FEATURE) ---
            _buildSectionHeader('SUBTASKS'),
            _buildSubtasksSection(colorScheme),
            const SizedBox(height: 24),

            // --- DUE DATE CARD ---
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('DUE DATE'),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: colorScheme.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Tomorrow, Oct 24',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- PRIORITY CARD ---
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('PRIORITY'),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildPriorityPill('URGENT', colorScheme),
                      _buildPriorityPill('ROUTINE', colorScheme),
                      _buildPriorityPill('BACKLOG', colorScheme),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- CATEGORY ---
            _buildSectionHeader('CATEGORY'),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildCategoryChip('Work', colorScheme.primary),
                _buildCategoryChip('Product', colorScheme.secondary),
                _buildCategoryChip('Personal', colorScheme.tertiary),
                _buildNewCategoryChip(),
              ],
            ),
            const SizedBox(height: 48),

            // --- SUBMIT BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 4,
                  shadowColor: colorScheme.primary.withOpacity(0.4),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CREATE TASK',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.bolt, size: 24),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- FOOTER HINT ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hit ', style: TextStyle(color: Colors.grey.shade600)),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Cmd + Enter',
                    style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                  ),
                ),
                Text(
                  ' to quickly save',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
        filled: true,
        fillColor: Colors
            .grey
            .shade200, // Matches the light grey inputs from the image
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildSubtasksSection(ColorScheme colorScheme) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _subtaskControllers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: _subtaskControllers[index],
                decoration: InputDecoration(
                  hintText: 'Add a subtask...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.circle_outlined,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  suffixIcon: _subtaskControllers.length > 1
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                          onPressed: () => _removeSubtask(index),
                        )
                      : null,
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: _addSubtask,
            icon: Icon(Icons.add, color: colorScheme.secondary, size: 18),
            label: Text(
              'Add another step',
              style: TextStyle(
                color: colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWhiteCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildPriorityPill(String label, ColorScheme colorScheme) {
    final isSelected = _selectedPriority == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedPriority = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.secondary : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, Color dotColor) {
    final isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? dotColor.withOpacity(0.5) : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewCategoryChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ), // In a real app, use a dotted border package
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, size: 16, color: Colors.grey.shade500),
          const SizedBox(width: 4),
          Text(
            'New',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
