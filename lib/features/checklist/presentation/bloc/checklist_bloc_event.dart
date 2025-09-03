
part of 'checklist_bloc.dart';

abstract class ChecklistEvent extends Equatable {
  const ChecklistEvent();

  @override
  List<Object> get props => [];
}

class ChecklistLoadRequested extends ChecklistEvent {}

class ChecklistItemToggled extends ChecklistEvent {
  final ChecklistItem item;

  const ChecklistItemToggled(this.item);

  @override
  List<Object> get props => [item];
}

class ChecklistItemAdded extends ChecklistEvent {
  final String title;
  final String description;

  const ChecklistItemAdded({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

// States
abstract class ChecklistState extends Equatable {
  const ChecklistState();

  @override
  List<Object> get props => [];
}