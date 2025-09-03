 
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GuestsPage extends StatefulWidget {
  const GuestsPage({super.key});

  @override
  State<GuestsPage> createState() => _GuestsPageState();
}

class _GuestsPageState extends State<GuestsPage> {
  final List<Guest> _guests = [
    Guest(name: 'John Doe', email: 'john@email.com', rsvpStatus: RSVPStatus.confirmed),
    Guest(name: 'Jane Smith', email: 'jane@email.com', rsvpStatus: RSVPStatus.pending),
    Guest(name: 'Bob Johnson', email: 'bob@email.com', rsvpStatus: RSVPStatus.declined),
    Guest(name: 'Alice Brown', email: 'alice@email.com', rsvpStatus: RSVPStatus.confirmed),
  ];

  @override
  Widget build(BuildContext context) {
    final confirmedCount = _guests.where((g) => g.rsvpStatus == RSVPStatus.confirmed).length;
    final pendingCount = _guests.where((g) => g.rsvpStatus == RSVPStatus.pending).length;
    final declinedCount = _guests.where((g) => g.rsvpStatus == RSVPStatus.declined).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest List'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          // Stats Header
          Container(
            margin: const EdgeInsets.all(16),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  title: 'Confirmed',
                  count: confirmedCount,
                  color: Colors.green,
                  icon: Icons.check_circle,
                ),
                _StatItem(
                  title: 'Pending',
                  count: pendingCount,
                  color: Colors.orange,
                  icon: Icons.schedule,
                ),
                _StatItem(
                  title: 'Declined',
                  count: declinedCount,
                  color: Colors.red,
                  icon: Icons.cancel,
                ),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3),
          
          // Guest List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _guests.length,
              itemBuilder: (context, index) {
                final guest = _guests[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(guest.rsvpStatus).withOpacity(0.2),
                      child: Text(
                        guest.name.split(' ').map((n) => n[0]).take(2).join(),
                        style: TextStyle(
                          color: _getStatusColor(guest.rsvpStatus),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      guest.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(guest.email),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(guest.rsvpStatus).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        guest.rsvpStatus.name.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(guest.rsvpStatus),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(
                  duration: 600.ms,
                  delay: (index * 100).ms,
                ).slideX(begin: 0.3);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddGuestDialog(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.person_add, color: Colors.white),
      ).animate().scale(duration: 400.ms, delay: 800.ms),
    );
  }

  Color _getStatusColor(RSVPStatus status) {
    switch (status) {
      case RSVPStatus.confirmed:
        return Colors.green;
      case RSVPStatus.pending:
        return Colors.orange;
      case RSVPStatus.declined:
        return Colors.red;
    }
  }

  void _showAddGuestDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Guest'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Guest Name',
                hintText: 'Enter full name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter email address',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                setState(() {
                  _guests.add(
                    Guest(
                      name: nameController.text,
                      email: emailController.text,
                      rsvpStatus: RSVPStatus.pending,
                    ),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add Guest'),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;

  const _StatItem({
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class Guest {
  final String name;
  final String email;
  final RSVPStatus rsvpStatus;

  Guest({
    required this.name,
    required this.email,
    required this.rsvpStatus,
  });
}

enum RSVPStatus { confirmed, pending, declined }



