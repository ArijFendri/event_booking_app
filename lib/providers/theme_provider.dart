import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Méthode pour changer le thème
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Informer l'UI du changement de thème
  }

  // Méthode pour initialiser le thème (vous pouvez ajouter une logique pour le mémoriser)
  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
