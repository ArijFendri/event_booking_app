import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/event.dart';
import 'payment_form_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    // Dimensions de l'écran pour rendre l'application responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: cartItems.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        final event = cartItems[index];
                        return Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Image de l'événement
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    event.image,
                                    width: screenWidth * 0.2,
                                    height: screenWidth * 0.2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                // Informations sur l'événement
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title,
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "\$${event.price.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Bouton pour supprimer l'événement
                                IconButton(
                                  icon: Icon(Icons.remove_shopping_cart,
                                      color: Colors.redAccent),
                                  onPressed: () {
                                    cartProvider.removeItem(event);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Total et bouton de paiement
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.05,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0, -2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            final totalPrice = cartProvider.totalPrice;
                            final eventTitle = cartItems.first.title;

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PaymentFormScreen(
                                  eventTitle: eventTitle,
                                  totalPrice: totalPrice,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: Text(
                            "Checkout (\$${cartProvider.totalPrice.toStringAsFixed(2)})",
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
