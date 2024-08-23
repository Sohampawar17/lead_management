
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../router.router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLoggedIn = false;

  Future<void> _performAsyncOperations() async {
    final SharedPreferences prefs = await _prefs;

    if (prefs.getString("api_secret") != null &&
        prefs.getString("api_key") != null) {
      isLoggedIn = true;
      final token = await getTocken();
      Logger().i(token);
    }
    await Future.delayed(const Duration(seconds: 3));
  }

  double opacity = 1.0; // Initial opacity for fade-out animation

  @override
  void initState() {
    super.initState();
    _performAsyncOperations().then((_) {
      if (isLoggedIn) {
        Navigator.popAndPushNamed(context, Routes.bottomNavigationScreen);
      } else {
        Navigator.popAndPushNamed(context, Routes.loginScreen);
      }
    });

    // Start the fade-out animation after 2 seconds (adjust timing as needed)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        opacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF87CEFA), Color(0xFF8A2BE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Diamond logo
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.diamond,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              const SizedBox(height: 20),
              // Lead Management text
              const Text(
                'Lead Management',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
