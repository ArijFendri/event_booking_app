import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String _keyToken = 'user_token';

  // Sauvegarder le token dans le stockage local
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  // Récupérer le token depuis le stockage local
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  // Supprimer le token du stockage local
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
  }
}
