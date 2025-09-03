import 'package:bodoni/features/checklist/presentation/widgets/add_checklist_dialog.dart';
import 'package:bodoni/features/checklist/presentation/widgets/checklist_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../bloc/checklist_bloc.dart';


class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Checklist'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<ChecklistBloc, ChecklistState>(
        builder: (context, state) {
          if (state is ChecklistInitial) {
            context.read<ChecklistBloc>().add(ChecklistLoadRequested());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChecklistLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChecklistError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ChecklistBloc>().add(ChecklistLoadRequested());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ChecklistLoaded) {
            final completedItems = state.items.where((item) => item.isCompleted).length;
            final totalItems = state.items.length;
            final progress = totalItems > 0 ? completedItems / totalItems : 0.0;

            return Column(
              children: [
                // Progress Header
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Progress: $completedItems/$totalItems',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(progress * 100).toInt()}% Complete',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3),

                // Checklist Items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return ChecklistItemCard(
                        item: item,
                        onToggle: () {
                          context.read<ChecklistBloc>().add(
                            ChecklistItemToggled(item),
                          );
                        },
                      ).animate().fadeIn(
                        duration: 600.ms,
                        delay: (index * 100).ms,
                      ).slideX(begin: 0.3);
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddChecklistDialog(),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ).animate().scale(duration: 400.ms, delay: 800.ms),
    );
  }
}
