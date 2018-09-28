import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/welcome_icon.png",
            fit: BoxFit.fitWidth,
            repeat: ImageRepeat.repeatX,
          ),
          Text(
            Strings.app_name,
            style: TextStyle(
              fontSize: 40.0,
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
