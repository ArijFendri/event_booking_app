import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/booking_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Écouter les changements dans les contrôleurs pour valider le formulaire
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Méthode pour valider le formulaire
  void _validateForm() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _isButtonEnabled = email.isNotEmpty && password.length >= 6;
    });
  }

  // Méthode pour se connecter
  Future<void> _login() async {
    if (!_isButtonEnabled || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid credentials or user does not exist'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Utilisation de MediaQuery pour obtenir les dimensions de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Titre
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: screenWidth * 0.08, // Taille adaptative
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Image ou icône (optionnelle, peut être ajustée selon vos besoins)
                Icon(
                  Icons.lock_outline,
                  size: screenWidth * 0.2,
                  color: Colors.black,
                ),

                SizedBox(height: screenHeight * 0.05),
                // Conteneur du formulaire
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      // Champ E-mail
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                          hintText: 'E-mail',
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                      Divider(color: Colors.black26),
                      // Champ Mot de passe
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.black),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Bouton de connexion
                _isLoading
                    ? CircularProgressIndicator(color: Colors.black)
                    : ElevatedButton(
                        onPressed: _isButtonEnabled ? _login : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.2,
                            vertical: screenHeight * 0.02,
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: Colors.white,
                          ),
                        ),
                      ),
                SizedBox(height: screenHeight * 0.02),
                // Lien d'inscription
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    "Don't have an account? Sign up here",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
