import 'package:flutter/material.dart';
import '../models/booking.dart'; // Assure-toi que tu as un modèle Booking

class BookingCard extends StatelessWidget {
  final Booking booking; // Réservation à afficher

  // Constructeur du widget qui prend un objet Booking
  BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10), // Espacement autour de la carte
      elevation: 5, // Ombre pour la carte
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Coins arrondis
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Réservation ID: ${booking.id}', // Affichage de l'ID de réservation
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10), // Espacement entre les éléments
            Text('Date de réservation: ${booking.bookingDate.toLocal()}'),
            SizedBox(height: 10),
            Text('Événement ID: ${booking.eventId}'),
            SizedBox(height: 10),
            Text('Nombre de billets: ${booking.ticketCount}'),
            SizedBox(height: 10),
            Text('Utilisateur ID: ${booking.userId}'),
          ],
        ),
      ),
    );
  }
}
