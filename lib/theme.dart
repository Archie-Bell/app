import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Custom Gradient
class Styles {
  // ========== Gradient Styles ==========
  static const RadialGradient appGradient = RadialGradient(
    colors: [
      Color(0xFF3D4DEE),
      Color(0xFF293486),
      Color(0xFFA0A5C0),
      Color(0xFFD9D9D9),
    ],
    center: Alignment.topLeft,
    radius: 2.25,
    stops: [0.1, 0.55, 0.9, 1.0],
  );

  // ========== Text Styles ==========
  // App name text style
  static TextStyle appName = const TextStyle(
    fontSize: 75,
    fontWeight: FontWeight.w900,
    fontFamily: 'Strong',
    color: Colors.white,
    height: 1.0,
  );

  // White text style
  static TextStyle whiteTextStyle = const TextStyle(
    color: Colors.white,
  );

  // Live Activity title text style
  static TextStyle liveActivityTitleStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  // Live Activity subtitle text style
  static TextStyle liveActivitySubtitleStyle = const TextStyle(
    color: Colors.white,
  );

  // Live Activity card title text style
  static TextStyle liveActivityCardTitleStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  // Live Activity card subtitle text style
  static TextStyle liveActivityCardSubtitleStyle = const TextStyle(
    color: Colors.white,
  );

  // ========== Text Field Styles ==========
  static TextField customTextField({required String hintText}) {
    return TextField(
      textAlign: TextAlign.start,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  // ========== Button Styles ==========
  static ButtonStyle button = OutlinedButton.styleFrom(
    backgroundColor: Colors.transparent,
    side: const BorderSide(color: Colors.white, width: 2),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
  );

  // ========== Live Activity Styles ==========
  // Live Activity container styles
  static const Color liveActivityBackgroundColor = Colors.transparent;
  static const Color liveActivityBorderColor = Colors.white;
  static const double liveActivityBorderRadius = 12.0;
  static const double liveActivityPadding = 5.0;
  static const double liveActivityHeight = 300.0;

  // Live Activity icon color
  static const Color liveActivityIconColor = Colors.white;

  // ========== Button Container Styles ==========
  // Container holding buttons
  static const Color buttonContainerBackgroundColor = Colors.transparent;
  static const Color buttonContainerBorderColor = Colors.white;
  static const double buttonContainerBorderRadius = 12.0;
  static const double buttonContainerPadding = 5.0;

  // ========== Modular Button Styles ==========
  static const double buttonPaddingVertical = 14.0;
  static const double buttonBorderRadius = 12.0;
  static const Color buttonBackgroundColor = Colors.transparent;
  static const Color buttonPressedBackgroundColor = Colors.white;
  static const Color buttonForegroundColor = Colors.white;
  static const Color buttonPressedForegroundColor = Colors.black;
  static const double buttonFontSize = 16.0;
  static const FontWeight buttonFontWeight = FontWeight.bold;

  // Button spacing
  static const double buttonSpacing = 8.0;
}
