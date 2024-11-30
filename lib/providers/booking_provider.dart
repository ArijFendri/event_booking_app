import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

class BookingProvider with ChangeNotifier {
  final BookingService _bookingService = BookingService(); 
  List<Booking> _bookings = []; 

  List<Booking> get bookings => _bookings; 

  // Ajouter une réservation
  Future<Booking> addBooking(Booking booking) async {
    final newBooking = await _bookingService.createBooking(booking); 
    _bookings.add(newBooking); 
    notifyListeners(); 
    return newBooking; 
  }

  // Récupérer les réservations pour un utilisateur spécifique
  Future<void> fetchBookings(String userId) async {
     try {
      final bookings = await _bookingService.getBookingsForUser(userId);
      _bookings = bookings; // Mettre à jour la liste des réservations
      notifyListeners();
    } catch (e) {
      print('Erreur lors du chargement des réservations : $e');
    }
  }

  // Effacer les réservations
  void clearBookings() {
    _bookings = [];
    notifyListeners();
  }
}
