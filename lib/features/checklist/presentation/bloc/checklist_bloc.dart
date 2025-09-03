import 'package:bodoni/features/checklist/domain/entitites/checklist_item.dart';
import 'package:bodoni/features/checklist/domain/usecases/get_checklist_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checklist_bloc_state.dart';
part 'checklist_bloc_event.dart';
class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  final GetChecklistUseCase getChecklistUseCase;

  ChecklistBloc(this.getChecklistUseCase) : super(ChecklistInitial()) {
    on<ChecklistLoadRequested>(_onLoadRequested);
    on<ChecklistItemToggled>(_onItemToggled);
    on<ChecklistItemAdded>(_onItemAdded);
  }

  Future<void> _onLoadRequested(
    ChecklistLoadRequested event,
    Emitter<ChecklistState> emit,
  ) async {
    emit(ChecklistLoading());
    final result = await getChecklistUseCase();
    result.fold(
      (failure) => emit(ChecklistError(failure.message)),
      (items) => emit(ChecklistLoaded(items)),
    );
  }

  Future<void> _onItemToggled(
    ChecklistItemToggled event,
    Emitter<ChecklistState> emit,
  ) async {
    if (state is ChecklistLoaded) {
      final currentItems = (state as ChecklistLoaded).items;
      final updatedItems = currentItems.map((item) {
        if (item.id == event.item.id) {
          return item.copyWith(
            isCompleted: !item.isCompleted,
            completedAt: !item.isCompleted ? DateTime.now() : null,
          );
        }
        return item;
      }).toList();
      emit(ChecklistLoaded(updatedItems));
    }
  }

  Future<void> _onItemAdded(
    ChecklistItemAdded event,
    Emitter<ChecklistState> emit,
  ) async {
    if (state is ChecklistLoaded) {
      final currentItems = (state as ChecklistLoaded).items;
      final newItem = ChecklistItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: event.title,
        description: event.description,
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      final updatedItems = [...currentItems, newItem];
      emit(ChecklistLoaded(updatedItems));
    }
  }
}