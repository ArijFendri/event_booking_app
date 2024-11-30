import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class PaymentScreen extends StatelessWidget {
  final String eventTitle; 
  final int ticketCount; 
  final double totalPrice; 

  PaymentScreen({
    required this.eventTitle,
    required this.ticketCount,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    // Récupérer l'état actuel du thème
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    // Définir les couleurs selon le thème
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color subTextColor = isDarkMode ? Colors.grey.shade300 : Colors.grey.shade600;
    Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    Color buttonColor = isDarkMode ? Colors.black : Colors.white;
    Color buttonTextColor = isDarkMode ? Colors.white : Colors.black;

    // Obtenez la taille de l'écran pour rendre le design responsive
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Event: $eventTitle",
              style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Tickets: $ticketCount",
              style: TextStyle(fontSize: screenWidth * 0.05, color: subTextColor),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Total: \$${totalPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.04),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.3),
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: textColor),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Paiement réussi!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop(); 
                },
                child: Text(
                  "Proceed to Payment",
                  style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: buttonTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
