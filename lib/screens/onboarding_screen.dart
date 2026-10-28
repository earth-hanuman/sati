import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import '../data/database.dart';
import '../data/db_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';
import 'loop_form.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

/// welcome → idea → [LoopForm: behavior/trigger/reward/review] → intention
enum _Phase { welcome, idea, mapping, intention }

class _OnboardingScreenState extends State<OnboardingScreen> {
  _Phase _phase = _Phase.welcome;
  String _behavior = '';
  String _trigger = '';
  String _rewardGuess = '';

  void _go(_Phase p) => setState(() => _phase = p);

  Future<void> _finish() async {
    final db = DatabaseProvider.of(context);
    await db.insertLoop(LoopsCompanion.insert(
      id: const Uuid().v4(),
      behavior: _behavior,
      trigger: Value(_trigger),
      rewardGuess: Value(_rewardGuess),
      isFocus: const Value(true),
      createdAt: DateTime.now().toUtc(),
    ));
    // RootRouter's stream will flip to Home automatically.
  }

  @override
  Widget build(BuildContext context) {
    switch (_phase) {
      case _Phase.welcome:
        return _welcome();
      case _Phase.idea:
        return _idea();
      case _Phase.mapping:
        return LoopForm(
          onExitFirst: () => _go(_Phase.idea),
          submitLabel: 'This is my focus loop',
          onComplete: (b, t, r) {
            setState(() {
              _behavior = b;
              _trigger = t;
              _rewardGuess = r;
              _phase = _Phase.intention;
            });
          },
        );
      case _Phase.intention:
        return _intention();
    }
  }

  Widget _welcome() {
    final c = context.c;
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Center(child: Orb(color: c.accent, size: 120)),
          const SizedBox(height: 30),
          const Center(child: Title1("This isn't about willpower.")),
          const SizedBox(height: 14),
          const Sub(
              'Most ways of changing a habit fight the urge. This one gets curious about it instead — and lets your brain do the rest.'),
          const Spacer(),
          PrimaryButton('Show me how', onPressed: () => _go(_Phase.idea)),
        ],
      ),
    );
  }

  Widget _idea() {
    final c = context.c;
    return AppScaffold(
      onBack: () => _go(_Phase.welcome),
      progress: .16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('the one idea'),
          const SizedBox(height: 12),
          const Title2('Every habit is a loop.'),
          const SizedBox(height: 14),
          const Sub(
              'Something sets it off. You do the thing. You get some kind of payoff. Your brain learns the loop and runs it on autopilot.'),
          const SizedBox(height: 22),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _Pill('⚡ Trigger'),
              Text('→', style: TextStyle(color: c.warm, fontSize: 18)),
              _Pill('🔁 Behavior'),
              Text('→', style: TextStyle(color: c.warm, fontSize: 18)),
              _Pill('🎁 Reward'),
            ],
          ),
          const SizedBox(height: 20),
          const Sub(
              "You can't delete the loop. But when you really see the reward for what it is, it loses its pull. That's the whole app."),
          const Spacer(),
          PrimaryButton("Let's map one of mine", onPressed: () => _go(_Phase.mapping)),
        ],
      ),
    );
  }

  Widget _intention() {
    return AppScaffold(
      progress: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          const Eyebrow('your first job'),
          const SizedBox(height: 14),
          const Title1('Just notice. Change nothing.'),
          const SizedBox(height: 14),
          const Sub(
              "For now, don't try to stop. When the urge shows up, just open the app and look at it with curiosity. That's it. The change comes from seeing clearly — not from forcing."),
          const Spacer(),
          PrimaryButton("I'm ready", onPressed: _finish),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill(this.text);
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: c.surface2,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: c.line),
      ),
      child: Text(text, style: TextStyle(color: c.text, fontWeight: FontWeight.w600, fontSize: 14)),
    );
  }
}

/// A gently pulsing orb used on the welcome screen.
class Orb extends StatefulWidget {
  final Color color;
  final double size;
  const Orb({super.key, required this.color, required this.size});
  @override
  State<Orb> createState() => _OrbState();
}

class _OrbState extends State<Orb> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 3400))..repeat(reverse: true);
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.82, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
      ),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: const Alignment(0, -0.2),
            colors: [widget.color, widget.color.withValues(alpha: 0.25)],
          ),
          boxShadow: [BoxShadow(color: widget.color.withValues(alpha: 0.5), blurRadius: 50, spreadRadius: -12)],
        ),
      ),
    );
  }
}
