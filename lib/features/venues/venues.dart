import 'package:bodoni/core/theme/theme.dart';
import 'package:bodoni/features/venues/bloc/venue_bloc.dart';
import 'package:bodoni/features/venues/data/models/venue_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VenueListingScreen extends StatefulWidget {
  const VenueListingScreen({super.key});

  @override
  State<VenueListingScreen> createState() => _VenueListingScreenState();
}

class _VenueListingScreenState extends State<VenueListingScreen> {
@override
void initState() {
  super.initState();

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Venues'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: BlocBuilder<VenueBloc, VenueState>(
        builder: (context, state) {
          if (state is VenueLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          }

          if (state is VenueError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }

          if (state is VenueLoaded) {
            return Column(
              children: [
                _buildFilterChips(context, state),
                Expanded(
                  child: state.filteredVenues.isEmpty
                      ? _buildEmptyState()
                      : _buildVenueList(state.filteredVenues),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, VenueLoaded state) {
    final hasActiveFilters = state.currentFilter.minBudget != null ||
        state.currentFilter.maxBudget != null ||
        state.currentFilter.minCapacity != null ||
        state.currentFilter.maxCapacity != null;

    if (!hasActiveFilters) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Filters:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {
                  context.read<VenueBloc>().add(ClearFilters());
                },
                child: const Text('Clear All'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              if (state.currentFilter.minBudget != null ||
                  state.currentFilter.maxBudget != null)
                Chip(
                  label: Text(
                    'Budget: ₹${state.currentFilter.minBudget ?? 0} - ₹${state.currentFilter.maxBudget ?? 500}',
                  ),
                  backgroundColor: AppTheme.secondaryColor,
                ),
              if (state.currentFilter.minCapacity != null ||
                  state.currentFilter.maxCapacity != null)
                Chip(
                  label: Text(
                    'Capacity: ${state.currentFilter.minCapacity ?? 0} - ${state.currentFilter.maxCapacity ?? 1000}',
                  ),
                  backgroundColor: AppTheme.secondaryColor,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No venues found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVenueList(List<Venue> venues) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: venues.length,
      itemBuilder: (context, index) {
        final venue = venues[index];
        return _buildVenueCard(venue);
      },
    );
  }

  Widget _buildVenueCard(Venue venue) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.3),
                    AppTheme.accentColor.withOpacity(0.3),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.location_city,
                  size: 48,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  venue.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      venue.location,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  venue.description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price Range',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            venue.priceRange,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Capacity',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${venue.capacity} guests',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: venue.amenities.map((amenity) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        amenity,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle venue selection
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Selected ${venue.name}'),
                      //     backgroundColor: AppTheme.primaryColor,
                      //   ),
                      // );
                    },
                    child: const Text('View Details'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final bloc = context.read<VenueBloc>();
    final currentState = bloc.state as VenueLoaded;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: FilterBottomSheet(currentFilter: currentState.currentFilter),
      ),
    );
  }
}

// Filter Bottom Sheet
class FilterBottomSheet extends StatefulWidget {
  final VenueFilter currentFilter;

  const FilterBottomSheet({super.key, required this.currentFilter});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late RangeValues _budgetRange;
  late RangeValues _capacityRange;

  @override
  void initState() {
    super.initState();
      _budgetRange = RangeValues(
        (widget.currentFilter.minBudget ?? 40).toDouble(),
        (widget.currentFilter.maxBudget ?? 350).toDouble(),
      );
    _capacityRange = RangeValues(
      (widget.currentFilter.minCapacity ?? 100).toDouble(),
      (widget.currentFilter.maxCapacity ?? 500).toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Venues',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Budget Range (₹ in thousands)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            RangeSlider(
              values: _budgetRange,
              min: 40,
              max: 350,
              divisions: 31,
              activeColor: AppTheme.primaryColor,
              inactiveColor: AppTheme.secondaryColor,
              labels: RangeLabels(
                '₹${_budgetRange.start.round()}k',
                '₹${_budgetRange.end.round()}k',
              ),
              onChanged: (values) {
                setState(() {
                  _budgetRange = values;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Capacity Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            RangeSlider(
              values: _capacityRange,
              min: 100,
              max: 500,
              divisions: 20,
              activeColor: AppTheme.primaryColor,
              inactiveColor: AppTheme.secondaryColor,
              labels: RangeLabels(
                '${_capacityRange.start.round()}',
                '${_capacityRange.end.round()}',
              ),
              onChanged: (values) {
                setState(() {
                  _capacityRange = values;
                });
              },
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<VenueBloc>().add(ClearFilters());
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(color: AppTheme.primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final filter = VenueFilter(
                        minBudget: _budgetRange.start.round()*1000,
                        maxBudget: _budgetRange.end.round()*1000,
                        minCapacity: _capacityRange.start.round(),
                        maxCapacity: _capacityRange.end.round(),
                      );
                      context.read<VenueBloc>().add(FilterVenues(filter));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}