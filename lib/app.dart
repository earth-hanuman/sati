import 'package:flutter/material.dart';
import 'data/database.dart';
import 'data/db_provider.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'theme/app_theme.dart';

class SatiApp extends StatelessWidget {
  const SatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sati',
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: const RootRouter(),
    );
  }
}

/// Shows onboarding until at least one loop exists, then Home. Reactive: when
/// onboarding writes the first loop, the stream flips us to Home automatically.
class RootRouter extends StatelessWidget {
  const RootRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final db = DatabaseProvider.of(context);
    return StreamBuilder<List<Loop>>(
      stream: db.watchActiveLoops(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: SizedBox.shrink());
        }
        final loops = snap.data ?? const <Loop>[];
        if (loops.isEmpty) return const OnboardingScreen();
        return HomeScreen(loops: loops);
      },
    );
  }
}
