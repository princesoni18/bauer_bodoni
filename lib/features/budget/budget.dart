 
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BudgetPage extends StatefulWidget {

  const BudgetPage({super.key});

 @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  
  double _totalBudget = 1000000; // Default 10 lakhs
  final TextEditingController _budgetController = TextEditingController();
  final Map<String, double> _budgetCategories = {
    'Venue': 0.35,
    'Catering': 0.25,
    'Photography': 0.10,
    'Decoration': 0.15,
    'Clothing': 0.08,
    'Miscellaneous': 0.07,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Calculator'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Budget Input
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Wedding Budget',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _budgetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '₹ ',
                      hintText: 'Enter your total budget',
                      suffixText: 'INR',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _totalBudget = double.tryParse(value) ?? _totalBudget;
                      });
                    },
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3),
            
            const SizedBox(height: 24),
            
            // Budget Breakdown
            const Text(
              'Budget Breakdown',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Category Cards
            ..._budgetCategories.entries.map((entry) {
              final amount = _totalBudget * entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(entry.key).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getCategoryIcon(entry.key),
                        color: _getCategoryColor(entry.key),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${(entry.value * 100).toInt()}% of budget',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${_formatAmount(amount)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: _getCategoryColor(entry.key),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(
                duration: 600.ms,
                delay: (100 * _budgetCategories.keys.toList().indexOf(entry.key)).ms,
              ).slideX(begin: 0.3);
            }).toList(),
            
            const SizedBox(height: 24),
            
            // Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Total Budget',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${_formatAmount(_totalBudget)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Plan wisely for your perfect day!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 800.ms, delay: 600.ms).scale(begin: const Offset(0.8, 0.8)),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Venue':
        return Colors.blue;
      case 'Catering':
        return Colors.green;
      case 'Photography':
        return Colors.purple;
      case 'Decoration':
        return Colors.pink;
      case 'Clothing':
        return Colors.orange;
      case 'Miscellaneous':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Venue':
        return Icons.location_city;
      case 'Catering':
        return Icons.restaurant;
      case 'Photography':
        return Icons.camera_alt;
      case 'Decoration':
        return Icons.palette;
      case 'Clothing':
        return Icons.checkroom;
      case 'Miscellaneous':
        return Icons.more_horiz;
      default:
        return Icons.category;
    }
  }

  String _formatAmount(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(1)} Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)} L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)} K';
    }
    return amount.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }
}