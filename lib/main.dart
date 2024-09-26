import 'package:flutter/material.dart';
import 'screens/contact_list_screen.dart';

void main() {
  runApp(AgendaApp());
}

class AgendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda',
      theme: ThemeData(
        primaryColor: Color(0xFF1b2838),  
        hintColor: Color(0xFF66c0f4),  
        scaffoldBackgroundColor: Color(0xFF171a21),  
        brightness: Brightness.dark,  
        fontFamily: 'Roboto',  
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 22, 
            fontWeight: FontWeight.w600, 
            color: Colors.white,  
          ),
          bodyMedium: TextStyle(
            fontSize: 16, 
            color: Color(0xFFc7d5e0),  
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1b2838),  
          elevation: 4,  
          iconTheme: IconThemeData(color: Colors.white),  
          titleTextStyle: TextStyle(
            color: Colors.white,  
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF66c0f4),  
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),  
          textTheme: ButtonTextTheme.primary,  
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF66c0f4), 
          foregroundColor: Colors.white,  
        ),
        cardTheme: CardTheme(
          color: Color(0xFF1b2838),  
          elevation: 4,  
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),  
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  
        ),
      ),
      home: ContactListScreen(),
    );
  }
}
