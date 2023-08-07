import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ThemeBase {}

class ThemeImpl {
  final ThemeBase themeType;

  ThemeImpl(this.themeType);

  ThemeData data() {
    // final Color primaryColor = Color.fromRGBO(119, 231, 228, 1);
    const Color primaryColor = Color.fromRGBO(38, 196, 137, 1);
    return ThemeData(
      primaryIconTheme: const IconThemeData(color: primaryColor),
      cupertinoOverrideTheme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: TextStyle(
            color: _defaultColor(),
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      scaffoldBackgroundColor: _scaffoldColor(),
      canvasColor: _scaffoldColor(),
      iconTheme: const IconThemeData(color: primaryColor),
      cardColor: _cardColor(),
      primaryColor: primaryColor,
      primaryColorLight: const Color.fromRGBO(89, 171, 225, 1),
      appBarTheme: AppBarTheme(color: _scaffoldColor(), elevation: 0),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(200, 55)),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateColor.resolveWith(
            (states) => primaryColor,
          ),
        ),
      ),

      // text
      fontFamily: 'Korail',
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            color: _defaultColor(), fontSize: 24, fontWeight: FontWeight.w900),
        bodyMedium: TextStyle(color: _defaultColor(), fontSize: 14),
        bodySmall: TextStyle(color: _defaultColor(), fontSize: 12),
      ),
    );
  }

  Color _defaultColor() {
    if (themeType is DarkTheme) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color _scaffoldColor() {
    if (themeType is DarkTheme) {
      return const Color.fromRGBO(18, 18, 18, 1);
    } else {
      return const Color.fromRGBO(243, 244, 252, 1);
    }
  }

  Color _cardColor() {
    if(themeType is DarkTheme) {
    return  const Color.fromRGBO(30, 30, 30, 1);
    } 
    else  {
      return const Color.fromRGBO(236, 237, 240, 1);
    }
  }
}

class LightTheme implements ThemeBase {
  static ThemeData get() => ThemeImpl(LightTheme()).data();
}

class DarkTheme implements ThemeBase {
  static ThemeData get() => ThemeImpl(DarkTheme()).data();
}
