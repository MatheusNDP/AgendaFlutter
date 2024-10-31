import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'screens/login_screen.dart';
import 'screens/contact_list_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();
  final sessionToken = await storage.read(key: 'session_token');

  runApp(MyApp(sessionToken: sessionToken));
}

class MyApp extends StatelessWidget {
  final String? sessionToken;

  MyApp({required this.sessionToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda Flutter',
      theme: ThemeData(
        primaryColor: const Color(0xFFF0B90B),
        hintColor: const Color(0xFFF0B90B),
        scaffoldBackgroundColor: const Color(0xFF12161C),
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFF848E9C),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF12161C),
          elevation: 4,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFFF0B90B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFF0B90B),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF12161C),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: sessionToken != null ? ContactListScreen() : LoginScreen(),
    );
  }
}
