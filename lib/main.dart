import 'package:equipment/screens/home.dart';
import 'package:equipment/shared/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MLPH Equipment',
      theme: ThemeData(
        primarySwatch: Palette.cyan,
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(212, 255, 255, 255) ,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
            ),
            backgroundColor: const Color(0xFF20a18d),
            padding: const EdgeInsets.all(18.0),
            textStyle: const TextStyle(
              fontSize: 18,
              color:  Color.fromARGB(255, 247, 247, 247),
              letterSpacing: 2,
            )
          ),
        )
      ),
      home: const Home(),
    );
  }
}

