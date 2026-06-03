import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// =============================================================
/// AESTHETIC DIRECTION: "editorial-technical"
/// - Near-black background, warm off-white text
/// - One sharp accent (electric lime) used sparingly
/// - Editorial serif headings (Fraunces) + clean grotesque body
///   (Manrope) + monospace for labels/tags (JetBrains Mono)
/// Change AppColors / the fonts in AppTheme to rebrand everything.
/// =============================================================

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0B0C0E); // near-black
  static const Color surface = Color(0xFF141619); // raised cards
  static const Color surfaceAlt = Color(0xFF1B1E22); // hover / nested
  static const Color border = Color(0xFF26292E);

  static const Color text = Color(0xFFECEAE4); // warm off-white
  static const Color textMuted = Color(0xFF8A8F98); // secondary text
  static const Color textFaint = Color(0xFF5A5F66); // tertiary / captions

  static const Color accent = Color(0xFFD7FF3E); // electric lime
  static const Color accentDim = Color(0xFF9DBB2E);
}

/// Consistent spacing scale (8pt-based).
class Gap {
  Gap._();
  static const double xs = 8;
  static const double sm = 16;
  static const double md = 24;
  static const double lg = 40;
  static const double xl = 64;
  static const double xxl = 96;
}

/// Max content width so the layout stays readable on large monitors.
const double kMaxContentWidth = 1100;
const double kNavHeight = 72;

/// Responsive breakpoints.
class Responsive {
  Responsive._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 760;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= 760 && w < 1100;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1100;

  /// Horizontal page padding that grows on larger screens.
  static double pagePadding(BuildContext context) =>
      isMobile(context) ? Gap.md : Gap.xl;
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);

    // Body font: Manrope (clean, characterful grotesque).
    final bodyText = GoogleFonts.manropeTextTheme(base.textTheme).apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.background,
        primary: AppColors.accent,
        secondary: AppColors.accent,
        onPrimary: AppColors.background,
        onSurface: AppColors.text,
      ),
      textTheme: bodyText,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.accent,
        selectionColor: Color(0x33D7FF3E),
        selectionHandleColor: AppColors.accent,
      ),
      dividerColor: AppColors.border,
    );
  }

  // ---- Named text styles (use these everywhere for consistency) ----

  /// Editorial serif display heading.
  static TextStyle display(BuildContext context) => GoogleFonts.fraunces(
        fontSize: Responsive.isMobile(context) ? 44 : 72,
        height: 1.02,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
        letterSpacing: -1.5,
      );

  static TextStyle sectionTitle(BuildContext context) => GoogleFonts.fraunces(
        fontSize: Responsive.isMobile(context) ? 30 : 40,
        height: 1.1,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
        letterSpacing: -0.5,
      );

  static TextStyle cardTitle = GoogleFonts.fraunces(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
    letterSpacing: -0.3,
  );

  static TextStyle body = GoogleFonts.manrope(
    fontSize: 16,
    height: 1.65,
    color: AppColors.textMuted,
  );

  static TextStyle bodyStrong = GoogleFonts.manrope(
    fontSize: 16,
    height: 1.6,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  /// Monospace label, e.g. "01 / ABOUT" or tech tags.
  static TextStyle mono({
    double size = 13,
    Color color = AppColors.accent,
    FontWeight weight = FontWeight.w500,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: size,
        color: color,
        fontWeight: weight,
        letterSpacing: 1.0,
      );
}
