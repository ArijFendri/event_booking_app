import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'qr_code_page.dart';
import '../providers/theme_provider.dart'; 
class PaymentFormScreen extends StatefulWidget {
  final String eventTitle;
  final double totalPrice;

  PaymentFormScreen({required this.eventTitle, required this.totalPrice});

  @override
  _PaymentFormScreenState createState() => _PaymentFormScreenState();
}

class _PaymentFormScreenState extends State<PaymentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String cardNumber = '';
  String paymentType = 'Visa';

  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran pour un design responsive
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Accéder au ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white, // Thème sombre/clair
        title: Text(
          "Payment for ${widget.eventTitle}",
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        elevation: 0.5, // Légère ombre pour l'AppBar
      ),
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[200], // Fond gris sombre ou clair
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.9, // La carte occupe 90% de la largeur
              maxHeight: screenHeight * 0.8, // Ajustée en hauteur si nécessaire
            ),
            child: Card(
              elevation: 5, // Légère ombre
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Taille ajustée au contenu
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Champ Full Name
                      TextFormField(
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: isDarkMode ? Colors.white70 : Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: isDarkMode ? Colors.white : Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                        onSaved: (value) => fullName = value!,
                      ),
                      SizedBox(height: screenHeight * 0.02), // Espacement responsive
                      // Champ Card Number
                      TextFormField(
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          labelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: isDarkMode ? Colors.white70 : Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: isDarkMode ? Colors.white : Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.length != 16) {
                            return 'Please enter a valid 16-digit card number';
                          }
                          return null;
                        },
                        onSaved: (value) => cardNumber = value!,
                      ),
                      SizedBox(height: screenHeight * 0.02), // Espacement responsive
                      // Champ Payment Type
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Payment Type',
                          labelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: isDarkMode ? Colors.white70 : Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: isDarkMode ? Colors.white : Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value: paymentType,
                        items: ['Visa', 'MasterCard', 'American Express']
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            paymentType = value!;
                          });
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02), // Espacement responsive
                      // Montant total
                      Text(
                        "Total Amount: \$${widget.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.045, // Taille de texte responsive
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      // Bouton Submit
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              final qrData = '''
                              Event: ${widget.eventTitle}
                              Name: $fullName
                              Payment: \$${widget.totalPrice.toStringAsFixed(2)}
                              '''; 

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QRCodePage(qrData: qrData),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkMode ? Colors.black : Colors.blueAccent, // Changer couleur selon mode
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                              horizontal: screenWidth * 0.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Submit Payment",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.045,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
