import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/booking.dart';

class BookingService {
  // URLs pour les environnements local (JSON Server) et MockAPI
  final String _baseUrlLocal = 'http://10.0.2.2:3000/bookings';  // URL JSON Server pour les réservations
  final String _baseUrlMockAPI = 'https://6744e241b4e2e04abea3f4bc.mockapi.io/users';  // URL MockAPI pour les utilisateurs

  // Utilise l'URL appropriée en fonction de l'environnement
  String get _baseUrl {
    bool isLocal = true; // Passe à false pour utiliser MockAPI (utilisateurs uniquement)
    return isLocal ? _baseUrlLocal : _baseUrlMockAPI;
  }

  /// Récupérer les réservations d'un utilisateur spécifique
  Future<List<Booking>> getBookingsForUser(String userId) async {
    try {
      // Pour les réservations, on utilise toujours l'URL de JSON Server (local)
      final url = '$_baseUrl?userId=$userId'; // Filtre par userId
      print('Making request to URL: $url');

      final response = await http.get(Uri.parse(url));

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Vérification : Filtrer les réservations selon l'userId
        return data.map((item) => Booking.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load bookings: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      throw e;
    }
  }

  /// Créer une réservation
  Future<Booking> createBooking(Booking booking) async {
    try {
      // Pour créer une réservation, on utilise toujours l'URL de JSON Server (local)
      final response = await http.post(
        Uri.parse(_baseUrlLocal),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(booking.toJson()),
      );

      print('Response Status (createBooking): ${response.statusCode}');
      print('Response Body (createBooking): ${response.body}');

      if (response.statusCode == 201) {
        return Booking.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create booking');
      }
    } catch (e) {
      print('Error creating booking: $e');
      throw e;
    }
  }
}
