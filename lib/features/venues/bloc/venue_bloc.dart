
import 'package:bodoni/features/venues/data/models/venue_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'venue_bloc_event.dart';
part 'venue_bloc_state.dart';

class VenueBloc extends Bloc<VenueEvent, VenueState> {
  VenueBloc() : super(VenueInitial()) {
    on<LoadVenues>(_onLoadVenues);
    on<FilterVenues>(_onFilterVenues);
    on<ClearFilters>(_onClearFilters);
  }

  final List<Venue> _dummyVenues = [
    Venue(
      id: '1',
      name: 'Royal Palace Banquet',
      location: 'Mumbai, Maharashtra',
      priceRange: '₹80,000 - ₹1,50,000',
      minPrice: 80000,
      maxPrice: 150000,
      capacity: 300,
      description: 'Luxurious palace-style venue with royal architecture',
      amenities: ['AC Hall', 'Parking', 'Catering', 'Decoration'],
      imageUrl: 'https://via.placeholder.com/300x200?text=Royal+Palace',
    ),
    Venue(
      id: '2',
      name: 'Garden View Resort',
      location: 'Goa',
      priceRange: '₹1,20,000 - ₹2,00,000',
      minPrice: 120000,
      maxPrice: 200000,
      capacity: 200,
      description: 'Beautiful garden setting with ocean views',
      amenities: ['Garden', 'Beach Access', 'Accommodation', 'Spa'],
      imageUrl: 'https://via.placeholder.com/300x200?text=Garden+Resort',
    ),
    Venue(
      id: '3',
      name: 'Heritage Haveli',
      location: 'Jaipur, Rajasthan',
      priceRange: '₹60,000 - ₹1,20,000',
      minPrice: 60000,
      maxPrice: 120000,
      capacity: 150,
      description: 'Traditional Rajasthani haveli with cultural ambiance',
      amenities: ['Traditional Decor', 'Folk Music', 'Catering', 'Photography'],
      imageUrl: 'https://via.placeholder.com/300x200?text=Heritage+Haveli',
    ),
    Venue(
      id: '4',
      name: 'Metropolitan Grand',
      location: 'Delhi NCR',
      priceRange: '₹2,00,000 - ₹3,50,000',
      minPrice: 200000,
      maxPrice: 350000,
      capacity: 500,
      description: 'Modern luxury hotel with state-of-the-art facilities',
      amenities: ['5-Star Service', 'Valet Parking', 'Multiple Halls', 'Bridal Suite'],
      imageUrl: 'https://via.placeholder.com/300x200?text=Metropolitan+Grand',
    ),
    Venue(
      id: '5',
      name: 'Lakeside Villa',
      location: 'Udaipur, Rajasthan',
      priceRange: '₹1,50,000 - ₹2,50,000',
      minPrice: 150000,
      maxPrice: 250000,
      capacity: 180,
      description: 'Romantic lakeside venue with stunning sunset views',
      amenities: ['Lake View', 'Boat Rides', 'Outdoor Setup', 'Photography'],
      imageUrl: 'https://via.placeholder.com/300x200?text=Lakeside+Villa',
    ),
    Venue(
      id: '6',
      name: 'City Convention Center',
      location: 'Bangalore, Karnataka',
      priceRange: '₹40,000 - ₹80,000',
      minPrice: 40000,
      maxPrice: 80000,
      capacity: 400,
      description: 'Spacious convention center ideal for large gatherings',
      amenities: ['Large Space', 'AV Equipment', 'Catering', 'Parking'],
      imageUrl: 'https://via.placeholder.com/300x200?text=Convention+Center',
    ),
    Venue(
      id: '7',
      name: 'Beach Paradise Resort',
      location: 'Kerala',
      priceRange: '₹1,00,000 - ₹1,80,000',
      minPrice: 100000,
      maxPrice: 180000,
      capacity: 120,
      description: 'Beachfront resort with tropical paradise vibes',
      amenities: ['Beach Access', 'Coconut Grove', 'Seafood Catering', 'Water Sports'],
      imageUrl: 'https://via.placeholder.com/300x200?text=Beach+Paradise',
    ),
    Venue(
      id: '8',
      name: 'Mountain Retreat',
      location: 'Shimla, Himachal Pradesh',
      priceRange: '₹70,000 - ₹1,30,000',
      minPrice: 70000,
      maxPrice: 130000,
      capacity: 100,
      description: 'Serene mountain venue surrounded by pine forests',
      amenities: ['Mountain View', 'Bonfire Setup', 'Adventure Activities', 'Cozy Interiors'],
      imageUrl: 'https://via.placeholder.com/300x200?text=Mountain+Retreat',
    ),
  ];

  void _onLoadVenues(LoadVenues event, Emitter<VenueState> emit) {
    emit(VenueLoading());
    try {
      emit(VenueLoaded(
        venues: _dummyVenues,
        filteredVenues: _dummyVenues,
        currentFilter: VenueFilter(),
      ));
    } catch (e) {
      emit(VenueError('Failed to load venues'));
    }
  }

  void _onFilterVenues(FilterVenues event, Emitter<VenueState> emit) {
    if (state is VenueLoaded) {
      final currentState = state as VenueLoaded;

      print("Current Filter: ${event.filter.minBudget} ${event.filter.maxBudget}");

      final filteredVenues = _applyFilters(currentState.venues, event.filter);
      print("filter applied");
      emit(VenueLoaded(
        venues: currentState.venues,
        filteredVenues: filteredVenues,
        currentFilter: event.filter,
      ));
    }
  }

  void _onClearFilters(ClearFilters event, Emitter<VenueState> emit) {
    if (state is VenueLoaded) {
      final currentState = state as VenueLoaded;
      emit(VenueLoaded(
        venues: currentState.venues,
        filteredVenues: currentState.venues,
        currentFilter: VenueFilter(),
      ));
    }
  }

  List<Venue> _applyFilters(List<Venue> venues, VenueFilter filter) {
    return venues.where((venue) {
      bool budgetMatch = true;
      bool capacityMatch = true;

      if (filter.minBudget != null) {
        budgetMatch = budgetMatch && venue.maxPrice >= filter.minBudget!;
      }
      if (filter.maxBudget != null) {
        budgetMatch = budgetMatch && venue.minPrice <= filter.maxBudget!;
      }
      if (filter.minCapacity != null) {
        capacityMatch = capacityMatch && venue.capacity >= filter.minCapacity!;
      }
      if (filter.maxCapacity != null) {
        capacityMatch = capacityMatch && venue.capacity <= filter.maxCapacity!;
      }

      return budgetMatch && capacityMatch;
    }).toList();
  }}