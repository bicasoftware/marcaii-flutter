import 'package:flutter/material.dart';
import '../res/Strings.dart';

class ActivityManager {

    static ThemeData customTheme = ThemeData(
        primaryColor: Colors.teal,
        accentColor: Colors.green,
        accentColorBrightness: Brightness.dark,
        dividerColor: Colors.grey
    );

    static final AppBar baseAppBar = AppBar(
        title: Text(Strings.appName),
    );
}