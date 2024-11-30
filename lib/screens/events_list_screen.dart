import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../widgets/event_card.dart';
import '../providers/theme_provider.dart';  
import '../providers/auth_provider.dart'; 
import '../providers/cart_provider.dart'; // Importer CartProvider

class EventsListScreen extends StatefulWidget {
  @override
  _EventsListScreenState createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Provider.of<EventProvider>(context, listen: false).loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context); 
    final authProvider = Provider.of<AuthProvider>(context); 
    final cartProvider = Provider.of<CartProvider>(context); 
    final events = eventProvider.events;

    // Filtrer les événements en fonction de la barre de recherche
    final filteredEvents = events.where((event) {
      return event.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Définir les couleurs en fonction du thème
    Color textColor = themeProvider.isDarkMode ? Colors.white : Colors.black;
    Color subTextColor = themeProvider.isDarkMode ? Colors.grey.shade400 : Colors.black87;

    // Définir les couleurs pour la barre de recherche
    Color searchBarColor = themeProvider.isDarkMode
        ? Colors.white.withOpacity(0.2)  // Mode sombre : fond légèrement transparent
        : Colors.white;  // Mode clair : fond blanc opaque

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.white,  
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode
                ? [Colors.black, Colors.grey.shade900]  // Sombre
                : [Colors.white, Colors.white],  // Clair
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // AppBar Personnalisée
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: ListTile(
                title: Text(
                  'Welcome back!',
                  style: TextStyle(color: textColor, fontSize: 18),
                ),
                subtitle: Text(
                  authProvider.isAuthenticated ? authProvider.userName ?? 'User' : 'Guest',  // Afficher le nom de l'utilisateur ou "Guest"
                  style: TextStyle(
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: Stack(
                    clipBehavior: Clip.none, // Permet au badge de dépasser
                    children: [
                      Icon(Icons.shopping_cart, color: textColor),
                      if (cartProvider.totalItems > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              cartProvider.totalItems.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/cart'); // Navigation vers CartScreen
                  },
                ),
              ),
            ),

            // Barre de recherche
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  hintStyle: TextStyle(color: themeProvider.isDarkMode ? Colors.white70 : Colors.black45),
                  filled: true,
                  fillColor: searchBarColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                ),
              ),
            ),

            // Liste des événements
            Expanded(
              child: eventProvider.events.isEmpty
                  ? Center(
                      child: eventProvider.events.isEmpty
                          ? Text(
                              "No events available!",
                              style: TextStyle(color: textColor),
                            )
                          : CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: filteredEvents.length,
                      itemBuilder: (context, index) {
                        return EventCard(event: filteredEvents[index]); // Utilisation de EventCard
                      },
                    ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,  // Changer la couleur de l'AppBar
        actions: [
          // Bouton pour basculer entre mode sombre et clair
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              themeProvider.toggleTheme();  // Changer le thème au clic
            },
          ),
          // Bouton de déconnexion
          IconButton(
            icon: Icon(Icons.exit_to_app, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              authProvider.logout();  
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
