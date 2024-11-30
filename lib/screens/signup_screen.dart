import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/booking_provider.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Fonction pour Sign Up
  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      bool success = await authProvider.signup(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        final loginSuccess = await authProvider.login(
          _emailController.text,
          _passwordController.text,
        );

        if (loginSuccess) {
          final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to login after sign up')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir la taille de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Titre "Sign Up"
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08, // Taille adaptative
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Champ "First Name"
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Colors.black87),
                      hintText: 'Enter your first name',
                      hintStyle: TextStyle(color: Colors.black54),
                      prefixIcon: Icon(Icons.person, color: Colors.black54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      } else if (!RegExp(r'^[A-Z]').hasMatch(value)) {
                        return 'First name must start with an uppercase letter';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Champ "Last Name"
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Colors.black87),
                      hintText: 'Enter your last name',
                      hintStyle: TextStyle(color: Colors.black54),
                      prefixIcon: Icon(Icons.person_outline, color: Colors.black54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Champ "Email"
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black87),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.black54),
                      prefixIcon: Icon(Icons.email, color: Colors.black54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Champ "Password"
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black87),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.black54),
                      prefixIcon: Icon(Icons.lock, color: Colors.black54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$').hasMatch(value)) {
                        return 'Password must contain at least 6 characters, including letters and numbers';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Bouton Sign Up
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Sign Up', style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.white)),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Lien vers Login
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
