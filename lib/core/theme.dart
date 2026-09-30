import 'package:flutter/material.dart';

ThemeData buildTheme(Brightness brightness) => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF3B82F6),
      brightness: brightness,
    );
