// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// Year 6070 Futuristic Design System
/// Inspired by holographic AR interfaces, plasma-morphism, and VisionOS aesthetics

class Theme6070 {
  // ==================== COLOR PALETTE ====================
  // Professional neon holographic colors
  static const Color neonBlue = Color(0xFF0099FF);
  static const Color neonPurple = Color(0xFF7B2CBF);
  static const Color neonPink = Color(0xFFFF006E);
  static const Color neonCyan = Color(0xFF00D9FF);
  static const Color neonGreen = Color(0xFF00E5A0);
  static const Color neonOrange = Color(0xFFFF6B35);
  static const Color neonYellow = Color(0xFFFFC857);
  
  // Muted professional variants
  static const Color accentBlue = Color(0xFF00B8FF);
  static const Color accentPurple = Color(0xFF9D4EDD);
  static const Color accentPink = Color(0xFFFF1493);

  // Glass-morphism base colors
  static const Color glassDark = Color(0x40000000);
  static const Color glassLight = Color(0x40FFFFFF);
  static const Color plasmaBase = Color(0x20000000);

  // Background gradients
  static const List<Color> gradientSpace = [
    Color(0xFF0A0A1A),
    Color(0xFF1A0A2E),
    Color(0xFF16213E),
    Color(0xFF0F3460),
  ];

  static const List<Color> gradientLight = [
    Color(0xFFE3F2FD),
    Color(0xFFBBDEFB),
    Color(0xFF90CAF9),
    Color(0xFF64B5F6),
  ];

  static const List<Color> gradientNeon = [
    Color(0xFF1A0033),
    Color(0xFF330066),
    Color(0xFF4D0099),
    Color(0xFF6600CC),
  ];

  static const List<Color> gradientHologram = [
    Color(0x2000F0FF),
    Color(0x30B026FF),
    Color(0x20FF00D6),
    Color(0x3000FFFF),
  ];

  // ==================== GLOW EFFECTS ====================
  static List<BoxShadow> getNeonGlow(Color color, {double intensity = 0.8}) {
    return [
      BoxShadow(
        color: color.withOpacity(0.4 * intensity),
        blurRadius: 20,
        spreadRadius: 2,
      ),
      BoxShadow(
        color: color.withOpacity(0.3 * intensity),
        blurRadius: 40,
        spreadRadius: 4,
      ),
      BoxShadow(
        color: color.withOpacity(0.2 * intensity),
        blurRadius: 60,
        spreadRadius: 6,
      ),
    ];
  }

  static List<BoxShadow> getSoftGlow(Color color, {double intensity = 0.5}) {
    return [
      BoxShadow(
        color: color.withOpacity(0.2 * intensity),
        blurRadius: 30,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: color.withOpacity(0.15 * intensity),
        blurRadius: 60,
        spreadRadius: 0,
      ),
    ];
  }

  // ==================== BORDER RADIUS ====================
  static const double radiusUltraRounded = 32.0;
  static const double radiusCard = 28.0;
  static const double radiusButton = 24.0;
  static const double radiusSmall = 20.0;

  // ==================== GRADIENTS ====================
  static LinearGradient getHolographicGradient({
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: [
        neonBlue.withOpacity(0.8),
        neonPurple.withOpacity(0.6),
        neonPink.withOpacity(0.8),
        neonCyan.withOpacity(0.6),
      ],
      stops: const [0.0, 0.33, 0.66, 1.0],
    );
  }

  static LinearGradient getPlasmaGradient({
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: [glassDark, plasmaBase, glassLight.withOpacity(0.1), glassDark],
      stops: const [0.0, 0.3, 0.7, 1.0],
    );
  }

  static LinearGradient getWeatherGradient(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
      case 'sunny':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            neonOrange.withOpacity(0.6),
            neonYellow.withOpacity(0.5),
            Color(0xFF1A0A2E),
            Color(0xFF0F3460),
          ],
        );
      case 'rain':
      case 'rainy':
      case 'drizzle':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            neonBlue.withOpacity(0.6),
            neonCyan.withOpacity(0.5),
            Color(0xFF1A0A2E),
            Color(0xFF0F3460),
          ],
        );
      case 'clouds':
      case 'cloudy':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            neonPurple.withOpacity(0.6),
            neonPink.withOpacity(0.5),
            Color(0xFF1A0A2E),
            Color(0xFF0F3460),
          ],
        );
      default:
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            neonCyan.withOpacity(0.6),
            neonGreen.withOpacity(0.5),
            Color(0xFF1A0A2E),
            Color(0xFF0F3460),
          ],
        );
    }
  }

  // ==================== DECORATIONS ====================
  static BoxDecoration getGlassCard({
    Color? glowColor,
    bool withBorder = true,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radiusCard),
      gradient: getPlasmaGradient(),
      border: withBorder
          ? Border.all(
              color: (glowColor ?? neonCyan).withOpacity(0.3),
              width: 1.5,
            )
          : null,
      boxShadow: glowColor != null ? getSoftGlow(glowColor) : [],
    );
  }

  static BoxDecoration getHolographicCard({
    Color? glowColor,
    bool withGlow = true,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radiusCard),
      gradient: getHolographicGradient(),
      border: Border.all(
        color: (glowColor ?? neonCyan).withOpacity(0.5),
        width: 2,
      ),
      boxShadow: withGlow && glowColor != null ? getNeonGlow(glowColor) : [],
    );
  }

  // ==================== TEXT STYLES ====================
  static TextStyle getFuturisticText({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
    bool withGlow = false,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Colors.white,
      letterSpacing: 1.2,
      shadows: withGlow && color != null
          ? [
              Shadow(color: color.withOpacity(0.8), blurRadius: 10),
              Shadow(color: color.withOpacity(0.5), blurRadius: 20),
            ]
          : [],
    );
  }

  static TextStyle getHolographicText({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      foreground: Paint()
        ..shader = getHolographicGradient().createShader(
          const Rect.fromLTWH(0, 0, 200, 100),
        ),
      letterSpacing: 1.5,
      shadows: [Shadow(color: neonCyan.withOpacity(0.6), blurRadius: 15)],
    );
  }
}

/// Animation utilities for futuristic UI
class Animation6070 {
  static Duration get defaultDuration => const Duration(milliseconds: 600);
  static Duration get fastDuration => const Duration(milliseconds: 300);
  static Duration get slowDuration => const Duration(milliseconds: 1000);

  static Curve get defaultCurve => Curves.easeInOutCubic;
  static Curve get springCurve => Curves.elasticOut;
  static Curve get smoothCurve => Curves.easeOutCubic;
}

/// Weather icon mapper for holographic icons
class WeatherIcon6070 {
  static String getIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return '☀️';
      case 'clouds':
      case 'cloudy':
        return '☁️';
      case 'rain':
      case 'rainy':
      case 'drizzle':
        return '🌧️';
      case 'thunderstorm':
        return '⛈️';
      case 'snow':
        return '❄️';
      case 'mist':
      case 'fog':
        return '🌫️';
      default:
        return '✨';
    }
  }

  static Color getIconColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Theme6070.neonYellow;
      case 'clouds':
      case 'cloudy':
        return Theme6070.neonPurple;
      case 'rain':
      case 'rainy':
        return Theme6070.neonBlue;
      case 'thunderstorm':
        return Theme6070.neonPink;
      case 'snow':
        return Theme6070.neonCyan;
      default:
        return Theme6070.neonGreen;
    }
  }
}