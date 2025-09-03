
import 'package:bodoni/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bodoni/features/budget/budget.dart';
import 'package:bodoni/features/checklist/presentation/pages/checklist_page.dart';
import 'package:bodoni/features/guests/guests.dart';
import 'package:bodoni/features/venues/bloc/venue_bloc.dart';
import 'package:bodoni/features/venues/venues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
      context.read<VenueBloc>().add(LoadVenues());
  }
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const ChecklistPage(),
    const VenueListingScreen(),
    const BudgetPage(),
    const GuestsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist),
              label: 'Checklist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Venues',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Budget',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Guests',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Planner'),
        actions: [
          IconButton(
            onPressed: () {
              // Show logout dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);

                        context.read<AuthBloc>().add(AuthLogoutRequested());
                        // Add logout logic here
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '💕 Welcome to Your Wedding Journey!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Let\'s make your special day perfect',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3),
            
            const SizedBox(height: 24),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _QuickActionCard(
                  icon: Icons.checklist,
                  title: 'Checklist',
                  subtitle: 'Track your tasks',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const ChecklistPage(),
                      ),
                    );
                  },
                ),
                _QuickActionCard(
                  icon: Icons.location_on,
                  title: 'Venues',
                  subtitle: 'Find perfect venues',
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const VenueListingScreen(),
                      ),
                    );
                  },
                ),
                _QuickActionCard(
                  icon: Icons.account_balance_wallet,
                  title: 'Budget',
                  subtitle: 'Manage expenses',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const BudgetPage(),
                      ),
                    );
                  },
                ),
                _QuickActionCard(
                  icon: Icons.people,
                  title: 'Guests',
                  subtitle: 'Manage guest list',
                  color: Colors.purple,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const GuestsPage(),
                      ),
                    );
                  },
                ),
              ],
            ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}