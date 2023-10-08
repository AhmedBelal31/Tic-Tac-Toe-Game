import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_game/constants/color.dart';
import 'package:tic_tac_toe_game/screens/game.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() => Timer(const Duration(seconds: 1), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const GameScreen()));
      });

  TextStyle customFontWhite =
      GoogleFonts.coiny(fontSize: 28, color: Colors.white, letterSpacing: 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Center(
          child: Text(
        "Tic-Tac-Toe Game ",
        style: customFontWhite,
      )),
    );
  }
}
