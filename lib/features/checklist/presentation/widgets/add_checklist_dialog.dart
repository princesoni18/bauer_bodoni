import 'package:bodoni/features/checklist/data/models/checklist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/checklist_bloc.dart';


class AddChecklistDialog extends StatefulWidget {
  final void Function(ChecklistItemModel)? onAdd;

  const AddChecklistDialog({Key? key, this.onAdd}) : super(key: key);

  @override
  State<AddChecklistDialog> createState() => _AddChecklistDialogState();
}


class _AddChecklistDialogState extends State<AddChecklistDialog> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Checklist Item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) => value == null || value.isEmpty ? 'Enter a title' : null,
              onSaved: (value) => _title = value ?? '',
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) => value == null || value.isEmpty ? 'Enter a description' : null,
              onSaved: (value) => _description = value ?? '',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();
              final item = ChecklistItemModel(
                id: UniqueKey().toString(),
                title: _title,
                description: _description,
                isCompleted: false,
                createdAt: DateTime.now(),
              );
              widget.onAdd?.call(item);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

