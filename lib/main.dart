
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/event_provider.dart'; 
import 'providers/cart_provider.dart'; 
import 'providers/theme_provider.dart'; 
import 'providers/auth_provider.dart'; 
import 'screens/cart_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'providers/booking_provider.dart';
import 'services/notification_service.dart'; 


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init(); // Initialisation des notifications

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), 
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Initialisation de l'authentification pour vérifier si un utilisateur est déjà connecté
    authProvider.initializeAuth();

    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          title: 'Event Booking App',
          theme: themeProvider.isDarkMode ? darkTheme : lightTheme, 
          debugShowCheckedModeBanner: false,
          initialRoute: '/', 
          routes: {
            '/login': (context) => LoginScreen(),
            '/signup': (context) => SignUpScreen(),
            '/home': (context) => HomeScreen(),
            '/': (context) => SplashScreen(), 
            '/cart': (context) => CartScreen(),
            '/event-details': (context) => EventDetailsScreen(),
     
          },
        );
      },
    );
  }
}

// Thème clair
final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.grey,
  fontFamily: 'Inter',  
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

// Thème sombre
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.grey,
  fontFamily: 'Inter',  
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
