import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Image.asset(
            "assets/marcai_icone.png",
            fit: BoxFit.fitWidth,
            repeat: ImageRepeat.repeatX,
          ),
        ),
      ),
    );
  }
}
