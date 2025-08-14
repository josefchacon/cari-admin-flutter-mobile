import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService.signInAnonymously();
  runApp(CariAdminApp());
}

class CariAdminApp extends StatefulWidget {
  @override
  _CariAdminAppState createState() => _CariAdminAppState();
}

class _CariAdminAppState extends State<CariAdminApp> {
  bool _isLoggedIn = false;

  void _handleLogin() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cari Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _isLoggedIn 
          ? DashboardScreen(onLogout: _handleLogout)
          : LoginScreen(onLogin: _handleLogin),
      debugShowCheckedModeBanner: false,
    );
  }
}