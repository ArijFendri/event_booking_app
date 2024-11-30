import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/theme_provider.dart';
import '../screens/payment_form_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  int ticketCount = 1; 

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    double totalPrice = ticketCount * event.price; // Calcul du prix total

    // Récupérer l'instance du ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Définir les couleurs selon le thème actuel
    bool isDarkMode = themeProvider.isDarkMode;
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color subTextColor = isDarkMode ? Colors.grey.shade300 : Colors.grey.shade600;
    Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    Color buttonColor = isDarkMode ? Colors.white : Colors.black;
    Color buttonTextColor = isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor, 
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          event.title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: textColor,
            ),
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Arrière-plan dégradé
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [backgroundColor, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Contenu de l'écran
          Column(
            children: [
              
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30), // Coins arrondis en bas
                    ),
                    child: Image.network(
                      event.image,
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_image.jpg',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 350,
                        );
                      },
                    ),
                  ),
                 
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  // Bouton retour
                  Positioned(
                    top: 40,
                    left: 20,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: textColor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
              // Détails de l'événement
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre et prix
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              event.title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "\$${event.price.toStringAsFixed(2)} / ticket",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: subTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      // Nombre de tickets
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tickets:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Row(
                            children: [
                              // Bouton pour réduire les tickets
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (ticketCount > 1) ticketCount--;
                                  });
                                },
                                icon: Icon(Icons.remove, color: subTextColor),
                              ),
                              Text(
                                "$ticketCount",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              // Bouton pour augmenter les tickets
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ticketCount++;
                                  });
                                },
                                icon: Icon(Icons.add, color: subTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      // Localisation
                      Row(
                        children: [
                          Icon(Icons.location_on, color: subTextColor, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              event.location,
                              style: TextStyle(
                                fontSize: 16,
                                color: subTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Date
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: subTextColor, size: 20),
                          SizedBox(width: 10),
                          Text(
                            event.date,
                            style: TextStyle(
                              fontSize: 16,
                              color: subTextColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      // Bouton Acheter
                      Center(
                        child: ElevatedButton(
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
    backgroundColor: buttonColor,
    foregroundColor: buttonTextColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentFormScreen(
          eventTitle: event.title,
          totalPrice: totalPrice,
        ),
      ),
    );
  },
  child: Text(
    "Proceed to Payment (\$${totalPrice.toStringAsFixed(2)})",
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
),

                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
