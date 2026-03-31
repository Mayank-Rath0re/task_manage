import 'package:flutter/material.dart';

enum TaskStatus { pending, inProgress, done }

class AbsTaskWidget extends StatefulWidget {
  final String title;
  final String description;
  final String date;

  // New Functional Parameters
  final TaskStatus initialStatus;
  final String? blockedByTask;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final ValueChanged<TaskStatus>? onStatusChanged;

  const AbsTaskWidget({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    this.initialStatus = TaskStatus.pending,
    this.blockedByTask,
    this.onEdit,
    this.onDelete,
    this.onStatusChanged,
  });

  @override
  State<AbsTaskWidget> createState() => _AbsTaskWidgetState();
}

class _AbsTaskWidgetState extends State<AbsTaskWidget> {
  late TaskStatus _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.initialStatus;
  }

  // Handles updating the UI and notifying the parent widget
  void _updateStatus(TaskStatus newStatus) {
    setState(() {
      _currentStatus = newStatus;
    });
    if (widget.onStatusChanged != null) {
      widget.onStatusChanged!(newStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Dynamic colors based on current status
    String badgeText;
    Color badgeColor;
    Color badgeTextColor;

    switch (_currentStatus) {
      case TaskStatus.pending:
        badgeText = 'PENDING';
        badgeColor = Colors.grey.shade200;
        badgeTextColor = Colors.grey.shade700;
        break;
      case TaskStatus.inProgress:
        badgeText = 'IN PROGRESS';
        badgeColor = colorScheme.tertiary; // Theme Green
        badgeTextColor = Colors.black87;
        break;
      case TaskStatus.done:
        badgeText = 'DONE';
        badgeColor = colorScheme.primary; // Theme Orange
        badgeTextColor = Colors.white;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        // Subtle red border if the task is blocked
        border:
            widget.blockedByTask != null && _currentStatus != TaskStatus.done
            ? Border.all(color: Colors.red.shade200, width: 1.5)
            : Border.all(color: Colors.transparent, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- TITLE & DESCRIPTION ---
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              // Fade text and add strikethrough if done
              color: _currentStatus == TaskStatus.done
                  ? Colors.grey.shade500
                  : Colors.black87,
              decoration: _currentStatus == TaskStatus.done
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // --- BLOCKED BY TAB ---
          if (widget.blockedByTask != null &&
              _currentStatus != TaskStatus.done) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade100),
              ),
              child: Row(
                children: [
                  Icon(Icons.block, size: 16, color: Colors.red.shade400),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red.shade900,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Blocked by: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: widget.blockedByTask),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          Divider(color: Colors.grey.shade200, height: 1),
          const SizedBox(height: 16),

          // --- FOOTER ---
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: Colors.grey.shade500,
              ),
              const SizedBox(width: 8),
              Text(
                widget.date,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
              const Spacer(),
              PopupMenuButton<TaskStatus>(
                initialValue: _currentStatus,
                onSelected: _updateStatus,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                offset: const Offset(0, 30),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        badgeText,
                        style: TextStyle(
                          color: badgeTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 14,
                        color: badgeTextColor,
                      ),
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: TaskStatus.pending,
                    child: Text('Pending'),
                  ),
                  const PopupMenuItem(
                    value: TaskStatus.inProgress,
                    child: Text('In Progress'),
                  ),
                  const PopupMenuItem(
                    value: TaskStatus.done,
                    child: Text('Done'),
                  ),
                ],
              ),
              const SizedBox(width: 4),

              // Edit / Delete Options Menu
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit' && widget.onEdit != null) {
                    widget.onEdit!();
                  } else if (value == 'delete' && widget.onDelete != null) {
                    widget.onDelete!();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                icon: Icon(Icons.more_vert, color: Colors.grey.shade400),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(width: 8),
                        const Text('Edit Task'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Delete',
                          style: TextStyle(color: Colors.red.shade400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
