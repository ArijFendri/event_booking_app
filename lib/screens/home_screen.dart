import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'events_list_screen.dart';
import 'profile_screen.dart';
import 'booking_history_screen.dart';
import '../providers/auth_provider.dart';
import '../providers/event_provider.dart';  // Importer EventProvider
import '../services/notification_service.dart'; // Importer NotificationService

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    EventsListScreen(),  // Liste des événements
    BookingHistoryScreen(), // Historique des réservations
    ProfileScreen(), // Profil utilisateur
  ];

  @override
  void initState() {
    super.initState();
    _checkNewEvents();
  }

  // Vérifier les nouveaux événements
  Future<void> _checkNewEvents() async {
    await Provider.of<EventProvider>(context, listen: false).loadEvents(); // Charger les événements
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
     
      floatingActionButton: authProvider.isAuthenticated
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 
                ],
              ),
            )
          : null, 
    );
  }
}
