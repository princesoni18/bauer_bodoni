
part of "venue_bloc.dart";

abstract class VenueState {}

class VenueInitial extends VenueState {}

class VenueLoading extends VenueState {}

class VenueLoaded extends VenueState {
  final List<Venue> venues;
  final List<Venue> filteredVenues;
  final VenueFilter currentFilter;

  VenueLoaded({
    required this.venues,
    required this.filteredVenues,
    required this.currentFilter,
  });
}

class VenueError extends VenueState {
  final String message;
  VenueError(this.message);
}