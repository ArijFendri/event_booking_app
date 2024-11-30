import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart'; // Assurez-vous d'importer le AuthProvider

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context); // Récupérer l'AuthProvider

    return Scaffold(
      appBar: AppBar(title: Text('Profil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100, color: Colors.black),
            SizedBox(height: 20),
            // Afficher les informations de l'utilisateur connecté
            Text(
              'Bienvenue, ${authProvider.userName ?? 'Utilisateur'}!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${authProvider.userName ?? 'Non défini'}', 
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               
              },
              child: Text('Modifier le profil'),
            ),
            ElevatedButton(
              onPressed: () {
                // Déconnexion
                authProvider.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
