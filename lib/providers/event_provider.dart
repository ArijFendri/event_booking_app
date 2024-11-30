import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/event.dart';
import '../services/notification_service.dart'; // Importer le service de notifications

class EventProvider with ChangeNotifier {
  List<Event> _events = [];
  List<Event> _previousEvents = []; // Liste des événements précédemment récupérés

  List<Event> get events => [..._events];

  Future<void> loadEvents() async {
    final url = Uri.parse('https://6744e241b4e2e04abea3f4bc.mockapi.io/events'); 
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        final List<Event> newEvents = data.map((event) => Event.fromJson(event)).toList();

        // Vérifier les nouveaux événements
        for (var newEvent in newEvents) {
          if (_previousEvents.every((event) => event.id != newEvent.id)) {
            // Si un nouvel événement est trouvé, afficher une notification
            await NotificationService.showNotification(
              newEvent.id,
              'Nouvel événement : ${newEvent.title}',
              '${newEvent.title} aura lieu à ${newEvent.location} le ${newEvent.date}.',
            );
          }
        }

        // Mettre à jour les listes
        _events = newEvents;
        _previousEvents = [...newEvents]; // Mettre à jour les événements précédents
        notifyListeners();
      } else {
        throw Exception('Échec du chargement des événements.');
      }
    } catch (error) {
      print('Erreur : $error');
    }
  }
}
