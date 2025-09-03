part of "venue_bloc.dart";
abstract class VenueEvent {}

class LoadVenues extends VenueEvent {}

class FilterVenues extends VenueEvent {
  final VenueFilter filter;
  FilterVenues(this.filter);
}

class ClearFilters extends VenueEvent {}