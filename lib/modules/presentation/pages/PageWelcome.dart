import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/presentation/Styles.dart';

class PageWelcome extends StatelessWidget {
  final VoidCallback onComecar;

  const PageWelcome({Key key, @required this.onComecar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Hero(
                tag: "WelcomeImage",
                child: Image.asset(
                  "assets/marcai_icone.png",
                  fit: BoxFit.fitWidth,
                  repeat: ImageRepeat.repeatX,
                ),
              ),
            ),
          ),
          Text(
            Strings.welcomeAntesComecar,
            style: Styles.hintStyle(context),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  child: MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      Strings.comecar,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: onComecar,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
