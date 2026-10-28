import 'package:flutter/material.dart';

/// Semantic colors shared by light & dark, read via `Theme.of(context)`.
/// Mirrors the palette from the HTML prototypes.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color bg;
  final Color surface;
  final Color surface2;
  final Color line;
  final Color text;
  final Color muted;
  final Color faint;
  final Color accent;
  final Color accentSoft;
  final Color accentInk;
  final Color warm;

  const AppColors({
    required this.bg,
    required this.surface,
    required this.surface2,
    required this.line,
    required this.text,
    required this.muted,
    required this.faint,
    required this.accent,
    required this.accentSoft,
    required this.accentInk,
    required this.warm,
  });

  static const dark = AppColors(
    bg: Color(0xFF0F1115),
    surface: Color(0xFF171A21),
    surface2: Color(0xFF1F232C),
    line: Color(0xFF2A2F3A),
    text: Color(0xFFEEF1F6),
    muted: Color(0xFF9AA3B2),
    faint: Color(0xFF6B7382),
    accent: Color(0xFF7BC6A4),
    accentSoft: Color(0xFF213128),
    accentInk: Color(0xFF0F1115),
    warm: Color(0xFFE0A96D),
  );

  static const light = AppColors(
    bg: Color(0xFFF4F6F9),
    surface: Color(0xFFFFFFFF),
    surface2: Color(0xFFEEF1F6),
    line: Color(0xFFE2E6EC),
    text: Color(0xFF141821),
    muted: Color(0xFF5C6473),
    faint: Color(0xFF8A92A1),
    accent: Color(0xFF2F9E72),
    accentSoft: Color(0xFFDFF0E7),
    accentInk: Color(0xFFFFFFFF),
    warm: Color(0xFFCF8A3E),
  );

  @override
  AppColors copyWith({
    Color? bg,
    Color? surface,
    Color? surface2,
    Color? line,
    Color? text,
    Color? muted,
    Color? faint,
    Color? accent,
    Color? accentSoft,
    Color? accentInk,
    Color? warm,
  }) {
    return AppColors(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      line: line ?? this.line,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      faint: faint ?? this.faint,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      accentInk: accentInk ?? this.accentInk,
      warm: warm ?? this.warm,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      line: Color.lerp(line, other.line, t)!,
      text: Color.lerp(text, other.text, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      faint: Color.lerp(faint, other.faint, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      accentInk: Color.lerp(accentInk, other.accentInk, t)!,
      warm: Color.lerp(warm, other.warm, t)!,
    );
  }
}

extension AppColorsX on BuildContext {
  AppColors get c => Theme.of(this).extension<AppColors>()!;
}

ThemeData _base(AppColors c, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: c.bg,
    fontFamily: null, // system font (San Francisco / Roboto)
    colorScheme: ColorScheme.fromSeed(
      seedColor: c.accent,
      brightness: brightness,
      surface: c.surface,
    ),
    extensions: [c],
  );
}

ThemeData buildLightTheme() => _base(AppColors.light, Brightness.light);
ThemeData buildDarkTheme() => _base(AppColors.dark, Brightness.dark);
