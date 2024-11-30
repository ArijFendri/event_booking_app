import 'package:flutter/material.dart';
import '../models/event.dart';

class CartProvider with ChangeNotifier {
  // Liste privée des événements dans le panier
  final List<Event> _cartItems = [];

  // Accesseur pour obtenir la liste des articles du panier
  List<Event> get cartItems => _cartItems;

  // Ajouter un événement au panier
  void addItem(Event event, int ticketCount) {
    // Ajouter un événement au panier
    _cartItems.add(event);
    notifyListeners(); // Notifier les widgets dépendants
  }

  // Supprimer un événement du panier
  void removeItem(Event event) {
    _cartItems.remove(event); // Retire l'événement de la liste
    notifyListeners(); // Notifie les widgets dépendants
  }

  // Vider le panier (utilisé après le paiement)
  void clearCart() {
    _cartItems.clear();
    notifyListeners(); // Notifie les widgets que le panier est vide
  }

  // Nombre total d'articles dans le panier
  int get totalItems => _cartItems.length;

  // Calculer le prix total des articles dans le panier
  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + item.price);
  }
}
