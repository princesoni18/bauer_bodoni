import 'package:bodoni/features/checklist/domain/entitites/checklist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class ChecklistItemCard extends StatelessWidget {
  final ChecklistItem item;
  final VoidCallback onToggle;

  const ChecklistItemCard({
    super.key,
    required this.item,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: GestureDetector(
          onTap: onToggle,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: item.isCompleted
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                width: 2,
              ),
              color: item.isCompleted
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
            ),
            child: item.isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : null,
          ),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration: item.isCompleted ? TextDecoration.lineThrough : null,
            color: item.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: Text(
          item.description,
          style: TextStyle(
            color: item.isCompleted ? Colors.grey : Colors.grey[600],
          ),
        ),
        trailing: item.isCompleted
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}