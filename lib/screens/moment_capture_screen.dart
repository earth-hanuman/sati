import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import '../content/coach_content.dart';
import '../data/database.dart';
import '../data/db_provider.dart';
import '../data/trend.dart';
import '../theme/app_theme.dart';
import '../widgets/trend_chart.dart';
import '../widgets/ui.dart';

enum _Step { strength, fork, breath, afterSurf, reward, followup, compare, done }

class MomentCaptureScreen extends StatefulWidget {
  final Loop loop;
  const MomentCaptureScreen({super.key, required this.loop});
  @override
  State<MomentCaptureScreen> createState() => _MomentCaptureScreenState();
}

class _MomentCaptureScreenState extends State<MomentCaptureScreen> {
  _Step _step = _Step.strength;
  int _urge = 5;
  int _after = 2;
  RewardCategory? _category;
  int _reward = 5;
  bool _wasSurf = false;
  String _doneTitle = '';
  String _doneSub = '';

  void _go(_Step s) => setState(() => _step = s);

  Future<void> _finishSurf() async {
    final db = DatabaseProvider.of(context);
    await db.insertMoment(MomentsCompanion.insert(
      id: const Uuid().v4(),
      loopId: widget.loop.id,
      type: 'surf',
      urgeStrength: _urge,
      urgeAfter: Value(_after),
      createdAt: DateTime.now().toUtc(),
    ));
    _wasSurf = true;
    _doneTitle = _after < _urge ? 'You rode the wave.' : 'You stayed with it.';
    _doneSub = _after < _urge
        ? "The urge went from $_urge to $_after — and you didn't have to act on it. That's the muscle."
        : 'Staying with an urge without acting is the whole practice. It gets easier.';
    _go(_Step.done);
  }

  Future<void> _finishReward() async {
    final db = DatabaseProvider.of(context);
    final cat = _category!;
    await db.insertMoment(MomentsCompanion.insert(
      id: const Uuid().v4(),
      loopId: widget.loop.id,
      type: 'did',
      urgeStrength: _urge,
      rewardCategory: Value(cat.key),
      rewardValue: Value(_reward),
      createdAt: DateTime.now().toUtc(),
    ));
    _wasSurf = false;
    _doneTitle = "That's one more data point.";
    _doneSub =
        "You didn't have to change anything — just by looking honestly, your brain updates what this habit is really worth.";
    _go(_Step.done);
  }

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case _Step.strength:
        return _strengthStep();
      case _Step.fork:
        return _forkStep();
      case _Step.breath:
        return _breathStep();
      case _Step.afterSurf:
        return _afterSurfStep();
      case _Step.reward:
        return _rewardStep();
      case _Step.followup:
        return _followupStep();
      case _Step.compare:
        return _compareStep();
      case _Step.done:
        return _doneStep();
    }
  }

  Widget _strengthStep() {
    return AppScaffold(
      onBack: () => Navigator.of(context).pop(),
      progress: .2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Title2('How strong is the urge?'),
          const SizedBox(height: 14),
          const Sub('No right answer. Just check in.'),
          const SizedBox(height: 26),
          StrengthPicker(
            value: _urge,
            labels: strengthLabels,
            onChanged: (v) => setState(() => _urge = v),
          ),
          const Spacer(),
          PrimaryButton('Next', onPressed: () => _go(_Step.fork)),
        ],
      ),
    );
  }

  Widget _forkStep() {
    return AppScaffold(
      onBack: () => _go(_Step.strength),
      progress: .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Title2("What's happening?"),
          const SizedBox(height: 14),
          const Sub("Both are fine. There's no failing here."),
          const SizedBox(height: 22),
          ChoiceTile(
            label: 'Riding it out',
            subtitle: 'stay with the urge for a moment',
            onTap: () => _go(_Step.breath),
          ),
          const SizedBox(height: 12),
          ChoiceTile(
            label: 'I did the behavior',
            subtitle: "let's look at it together",
            onTap: () => _go(_Step.reward),
          ),
        ],
      ),
    );
  }

  Widget _breathStep() {
    return AppScaffold(
      onBack: () => _go(_Step.fork),
      progress: .6,
      child: Column(
        children: [
          Expanded(child: _BreathingExercise(accent: context.c.accent, accentInk: context.c.accentInk)),
          PrimaryButton('The wave passed', onPressed: () => _go(_Step.afterSurf)),
          GhostButton('Skip', onPressed: () => _go(_Step.afterSurf)),
        ],
      ),
    );
  }

  Widget _afterSurfStep() {
    return AppScaffold(
      progress: .9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Title2("Where's the urge now?"),
          const SizedBox(height: 14),
          const Sub("Notice it rose… and it's already changing. Urges are waves, not walls."),
          const SizedBox(height: 26),
          StrengthPicker(value: _after, labels: afterLabels, onChanged: (v) => setState(() => _after = v)),
          const Spacer(),
          PrimaryButton('Done', onPressed: _finishSurf),
        ],
      ),
    );
  }

  Widget _rewardStep() {
    return AppScaffold(
      onBack: () => _go(_Step.fork),
      progress: .6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Title2('What were you hoping to get?'),
          const SizedBox(height: 14),
          const Sub('The real reward is usually hiding under the obvious one.'),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                for (final cat in rewardCategories) ...[
                  ChoiceTile(
                    label: '${cat.emoji} ${cat.label}',
                    subtitle: cat.subtitle,
                    selected: _category?.key == cat.key,
                    onTap: () {
                      setState(() {
                        _category = cat;
                        _reward = cat.answers.first.suggestedValue;
                      });
                      _go(_Step.followup);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _followupStep() {
    final cat = _category!;
    return AppScaffold(
      onBack: () => _go(_Step.reward),
      progress: .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Title2(cat.question),
          const SizedBox(height: 14),
          const Sub('Be honest with yourself. Curiosity, not judgment.'),
          const SizedBox(height: 20),
          for (final a in cat.answers) ...[
            ChoiceTile(
              label: a.text,
              onTap: () {
                setState(() => _reward = a.suggestedValue);
                _go(_Step.compare);
              },
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _compareStep() {
    return AppScaffold(
      progress: .96,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Title2('So — how rewarding was it, really?'),
          const SizedBox(height: 14),
          const Sub('Not how good you expected. How it actually left you feeling.'),
          const SizedBox(height: 26),
          StrengthPicker(value: _reward, labels: compareLabels, onChanged: (v) => setState(() => _reward = v)),
          const Spacer(),
          PrimaryButton('Log this moment', onPressed: _finishReward),
        ],
      ),
    );
  }

  Widget _doneStep() {
    final c = context.c;
    final db = DatabaseProvider.of(context);
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Center(
            child: Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: c.accentSoft,
                shape: BoxShape.circle,
                border: Border.all(color: c.accent),
              ),
              child: Icon(Icons.check_rounded, color: c.accent, size: 38),
            ),
          ),
          const SizedBox(height: 18),
          Center(child: Title2(_doneTitle)),
          const SizedBox(height: 14),
          Sub(_doneSub),
          const SizedBox(height: 22),
          if (!_wasSurf)
            FutureBuilder<List<int>>(
              future: db.rewardSeries(widget.loop.id),
              builder: (context, snap) {
                final raw = snap.data ?? const <int>[];
                if (raw.isEmpty) return const SizedBox.shrink();
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: c.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: c.line),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(widget.loop.behavior,
                                style: TextStyle(color: c.text, fontSize: 15, fontWeight: FontWeight.w600)),
                          ),
                          Text('how rewarding, over time', style: TextStyle(color: c.faint, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TrendChart(raw: raw),
                      const SizedBox(height: 10),
                      Text(trendDelta(raw),
                          style: TextStyle(color: c.accent, fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                );
              },
            ),
          const Spacer(),
          PrimaryButton('Back home', onPressed: () => Navigator.of(context).pop()),
        ],
      ),
    );
  }
}

/// Breathing orb that expands/contracts with rotating curiosity captions.
class _BreathingExercise extends StatefulWidget {
  final Color accent, accentInk;
  const _BreathingExercise({required this.accent, required this.accentInk});
  @override
  State<_BreathingExercise> createState() => _BreathingExerciseState();
}

class _BreathingExerciseState extends State<_BreathingExercise> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(seconds: 4));
  int _capIndex = 0;

  @override
  void initState() {
    super.initState();
    _ctrl.addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        setState(() => _capIndex = (_capIndex + 1) % breathCaptions.length);
        _ctrl.reverse();
      } else if (s == AnimationStatus.dismissed) {
        _ctrl.forward();
      }
    });
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: Tween(begin: 0.72, end: 1.05).animate(
            CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
          ),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(0, -0.2),
                colors: [widget.accent, widget.accent.withValues(alpha: 0.25)],
              ),
              boxShadow: [BoxShadow(color: widget.accent.withValues(alpha: 0.5), blurRadius: 60, spreadRadius: -10)],
            ),
            child: Center(
              child: AnimatedBuilder(
                animation: _ctrl,
                builder: (context, _) => Text(
                  _ctrl.status == AnimationStatus.forward || _ctrl.value > 0.5 ? 'breathe in' : 'breathe out',
                  style: TextStyle(color: widget.accentInk, fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Text(
            breathCaptions[_capIndex],
            key: ValueKey(_capIndex),
            textAlign: TextAlign.center,
            style: TextStyle(color: c.muted, fontSize: 17, height: 1.5),
          ),
        ),
      ],
    );
  }
}
