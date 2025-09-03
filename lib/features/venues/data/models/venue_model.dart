class Venue {
  final String id;
  final String name;
  final String location;
  final String priceRange;
  final int minPrice;
  final int maxPrice;
  final int capacity;
  final String description;
  final List<String> amenities;
  final String imageUrl;

  Venue({
    required this.id,
    required this.name,
    required this.location,
    required this.priceRange,
    required this.minPrice,
    required this.maxPrice,
    required this.capacity,
    required this.description,
    required this.amenities,
    required this.imageUrl,
  });
}

class VenueFilter {
  final int? minBudget;
  final int? maxBudget;
  final int? minCapacity;
  final int? maxCapacity;

  VenueFilter({
    this.minBudget,
    this.maxBudget,
    this.minCapacity,
    this.maxCapacity,
  });

  VenueFilter copyWith({
    int? minBudget,
    int? maxBudget,
    int? minCapacity,
    int? maxCapacity,
  }) {
    return VenueFilter(
      minBudget: minBudget ?? this.minBudget,
      maxBudget: maxBudget ?? this.maxBudget,
      minCapacity: minCapacity ?? this.minCapacity,
      maxCapacity: maxCapacity ?? this.maxCapacity,
    );
  }
}