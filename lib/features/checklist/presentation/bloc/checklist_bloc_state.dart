
part of 'checklist_bloc.dart';

class ChecklistInitial extends ChecklistState {}

class ChecklistLoading extends ChecklistState {}

class ChecklistLoaded extends ChecklistState {
  final List<ChecklistItem> items;

  const ChecklistLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class ChecklistError extends ChecklistState {
  final String message;

  const ChecklistError(this.message);

  @override
  List<Object> get props => [message];
}