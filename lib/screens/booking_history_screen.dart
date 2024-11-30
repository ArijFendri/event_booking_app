import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/booking_card.dart';  // Assure-toi d'importer le widget BookingCard

class BookingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context);

    // Vérifie si un utilisateur est connecté
    final currentUserId = authProvider.currentUserId;

    // Recharge les réservations chaque fois que l'utilisateur change
    if (currentUserId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bookingProvider.fetchBookings(currentUserId);
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Historique des réservations')),
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          if (currentUserId == null) {
            return Center(child: Text("Connectez-vous pour voir l'historique."));
          }

          if (bookingProvider.bookings.isEmpty) {
            return Center(child: Text("Aucune réservation trouvée."));
          }

          // Affichage des réservations sous forme de cartes
          return ListView.builder(
            itemCount: bookingProvider.bookings.length,
            itemBuilder: (context, index) {
              final booking = bookingProvider.bookings[index];
              return BookingCard(booking: booking); // Remplace ListTile par BookingCard
            },
          );
        },
      ),
    );
  }
}
