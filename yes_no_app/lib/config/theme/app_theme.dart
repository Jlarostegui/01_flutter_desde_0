import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF49149f);
const List<Color> _colorTheme = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.red,
  Colors.pink  

];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor <= _colorTheme.length,
            'selectedColor must be between 0 and ${_colorTheme.length - 1}');

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorTheme[selectedColor],
      brightness: Brightness.light
    );
  }
}
 