import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'router.locator.dart';
import 'router.router.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF8A2BE2), // Deep purple
        scaffoldBackgroundColor: Colors.white, // High contrast background
        appBarTheme: const AppBarTheme(
          color: Colors.white, // White AppBar background
          elevation: 4,
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black87,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black87,
            fontSize: 14,
          ),
          displayLarge: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFF8A2BE2), // Deep purple for headings
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal, // Teal for FAB background
          foregroundColor: Colors.white, // White for FAB icon
        ),
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      home: const SplashScreen(),
    );
  }
}
