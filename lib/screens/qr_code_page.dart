import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart'; // Assurez-vous d'importer le ThemeProvider
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatelessWidget {
  final String qrData; // Données pour générer le QR code

  QRCodePage({required this.qrData});

  @override
  Widget build(BuildContext context) {
    // Récupérer le thème actuel via le ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context); // Accéder à ThemeProvider
    bool isDarkMode = themeProvider.isDarkMode;

    // Définir les couleurs selon le thème
    Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color subTextColor = isDarkMode ? Colors.grey.shade300 : Colors.grey.shade600;
    Color buttonColor = isDarkMode ? Colors.black : Colors.white;
    Color buttonTextColor = isDarkMode ? Colors.white : Colors.black;
    Color qrBackgroundColor = isDarkMode ? Colors.black : Colors.white;
    Color qrForegroundColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          // Bouton pour basculer entre les modes clair et sombre
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: textColor),
            onPressed: () {
              themeProvider.toggleTheme(); // Changer le mode de thème
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Votre billet est prêt!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Scannez ce QR code pour accéder à votre événement.",
              style: TextStyle(
                fontSize: 16,
                color: subTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 250.0,
              backgroundColor: qrBackgroundColor, // Fond du QR code (noir en mode sombre)
              foregroundColor: qrForegroundColor,  // Contenu du QR code (blanc en mode sombre)
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); // Retourne à l'écran précédent
                  },
                  icon: Icon(Icons.arrow_back, color: buttonTextColor),
                  label: Text("Retour", style: TextStyle(color: buttonTextColor)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Paiement Réussi"),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Merci pour votre paiement!\n"
                                "Votre réservation a été confirmée.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              Icon(Icons.celebration,
                                  size: 50, color: Colors.amber),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); 
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/home')); 
                              },
                              child: Text("Voir les événements", style: TextStyle(color: buttonTextColor)),
                              style: TextButton.styleFrom(
                                foregroundColor: buttonTextColor,
                                textStyle: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.check_circle, color: buttonTextColor),
                  label: Text("Valider le paiement", style: TextStyle(color: buttonTextColor)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
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
