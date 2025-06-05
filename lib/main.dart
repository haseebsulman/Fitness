import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this line
import 'recover.dart';
import 'home.dart';
import 'age.dart';
import 'search_screen.dart';
import 'notification_screen.dart';
import 'chatting.dart';
import 'settings_screen.dart';
import 'signup.dart';
import 'login.dart';
import 'starter.dart';
import 'splash.dart';
import 'feedback_screen.dart';
// import 'edit_options_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before Firebase init
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/starter': (context) => const StarterScreen(),
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/age': (context) => const AgeScreen(),
        '/search': (context) => const SearchScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/chat': (context) => const ChatScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/recover': (context) => const RecoverPasswordScreen(),
        '/feedback': (context) => const FeedbackScreen(),
        // '/edit-options': (context) => const EditOptionsScreen(),
      },
    );
  }
}
