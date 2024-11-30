import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isAuthenticated = false;
  String? _userName;
  String? _currentUserId;

  final _storage = const FlutterSecureStorage();
  final String _apiUrl = 'https://6744e241b4e2e04abea3f4bc.mockapi.io/user';

  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;
  String? get userName => _userName;
  String? get currentUserId => _currentUserId;

  // Connexion utilisateur
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);
        final user = users.firstWhere(
          (user) => user['email'] == email && user['password'] == password,
          orElse: () => null,
        );

         Future<void> initializeAuth() async {
    // Simuler une vérification d'authentification (exemple avec SharedPreferences)
    await Future.delayed(Duration(seconds: 2)); // Simulation du chargement
    _isAuthenticated = false; // Changer pour true si l'utilisateur est connecté
    notifyListeners();
  }

        if (user != null) {
          _token = user['token'];
          _isAuthenticated = true;
          _userName = '${user['firstName']} ${user['lastName']}';
          _currentUserId = user['id'];

          await _saveToken(_token!);
          notifyListeners();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('Erreur lors de la connexion : $e');
      return false;
    }
  }

  // Inscription utilisateur
  Future<bool> signup(String firstName, String lastName, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return true; // L'utilisateur est créé avec succès
      } else {
        return false;
      }
    } catch (e) {
      print('Erreur lors de l\'inscription : $e');
      return false;
    }
  }

  // Déconnexion
  Future<void> logout() async {
    _token = null;
    _isAuthenticated = false;
    _userName = null;
    _currentUserId = null;

    await _removeToken();
    notifyListeners();
  }

  // Sauvegarder le token dans le stockage sécurisé
  Future<void> _saveToken(String token) async {
    await _storage.write(key: 'user_token', value: token);
  }

  // Charger le token depuis le stockage sécurisé
  Future<void> _loadToken() async {
    _token = await _storage.read(key: 'user_token');
    if (_token != null) {
      _isAuthenticated = true;
    }
  }

  // Supprimer le token du stockage sécurisé
  Future<void> _removeToken() async {
    await _storage.delete(key: 'user_token');
  }

  // Initialisation de l'état d'authentification
  Future<void> initializeAuth() async {
    await _loadToken();
    notifyListeners();
  }
}
