import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class LoopOption {
  final String label;
  final String value;
  const LoopOption(this.label, this.value);
}

const kBehaviors = [
  LoopOption('📱 Phone / doomscrolling', 'Phone / doomscrolling'),
  LoopOption('🍫 Stress snacking', 'Stress snacking'),
  LoopOption('💨 Vaping / smoking', 'Vaping / smoking'),
  LoopOption('⏳ Procrastinating', 'Procrastinating'),
];
const kTriggers = [
  LoopOption('😣 Stressed or anxious', 'Stressed or anxious'),
  LoopOption('🥱 Bored or restless', 'Bored or restless'),
  LoopOption('🌙 Winding down at night', 'Winding down at night'),
  LoopOption('🫥 Lonely or low', 'Lonely or low'),
];
const kRewards = [
  LoopOption('😮‍💨 A break or escape', 'A break or escape'),
  LoopOption('🫂 Comfort', 'Comfort'),
  LoopOption('😋 A hit of pleasure', 'A hit of pleasure'),
  LoopOption('⌛ Filling the time', 'Filling the time'),
];

/// The shared behavior → trigger → reward → review flow.
/// Used both in first-run onboarding and in "add a habit".
class LoopForm extends StatefulWidget {
  /// Called when the user backs out of the very first step.
  final VoidCallback onExitFirst;

  /// Called with the mapped loop once the user confirms the review.
  final void Function(String behavior, String trigger, String rewardGuess) onComplete;

  /// Label on the final confirm button.
  final String submitLabel;

  const LoopForm({
    super.key,
    required this.onExitFirst,
    required this.onComplete,
    this.submitLabel = 'This is my focus loop',
  });

  @override
  State<LoopForm> createState() => _LoopFormState();
}

class _LoopFormState extends State<LoopForm> {
  int _step = 0; // 0 behavior, 1 trigger, 2 reward, 3 review
  String _behavior = '';
  String _trigger = '';
  String _rewardGuess = '';
  final _customCtrl = TextEditingController();
  bool _usingCustom = false;

  @override
  void dispose() {
    _customCtrl.dispose();
    super.dispose();
  }

  void _go(int step) {
    setState(() {
      _step = step;
      _usingCustom = false;
      _customCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case 0:
        return _pickStep(
          progress: .34,
          back: widget.onExitFirst,
          eyebrow: 'behavior · 1 of 3',
          title: "What's one habit you'd like to look at?",
          sub: 'Pick the behavior itself — the thing you do. Start with just one.',
          options: kBehaviors,
          current: _behavior,
          customHint: 'name the habit, in your words',
          onPick: (v) => setState(() => _behavior = v),
          onNext: () => _go(1),
        );
      case 1:
        return _pickStep(
          progress: .52,
          back: () => _go(0),
          eyebrow: 'trigger · 2 of 3',
          title: 'When does it usually show up?',
          sub: 'A feeling, a time, a place. Your best guess is fine — you’ll refine it by noticing.',
          options: kTriggers,
          current: _trigger,
          customHint: 'what sets it off?',
          onPick: (v) => setState(() => _trigger = v),
          onNext: () => _go(2),
        );
      case 2:
        return _pickStep(
          progress: .70,
          back: () => _go(1),
          eyebrow: 'reward · 3 of 3',
          title: 'What do you think you get from it?',
          sub: 'Just a guess for now. Finding the real reward is what the moments are for.',
          options: kRewards,
          current: _rewardGuess,
          customHint: "what's the payoff?",
          onPick: (v) => setState(() => _rewardGuess = v),
          onNext: () => _go(3),
        );
      default:
        return _review();
    }
  }

  Widget _pickStep({
    required double progress,
    required VoidCallback back,
    required String eyebrow,
    required String title,
    required String sub,
    required List<LoopOption> options,
    required String current,
    required String customHint,
    required ValueChanged<String> onPick,
    required VoidCallback onNext,
  }) {
    final presetValues = options.map((o) => o.value).toSet();
    final hasValue = current.trim().isNotEmpty;
    return AppScaffold(
      onBack: back,
      progress: progress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow(eyebrow),
          const SizedBox(height: 12),
          Title2(title),
          const SizedBox(height: 14),
          Sub(sub),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                for (final o in options) ...[
                  ChoiceTile(
                    label: o.label,
                    selected: current == o.value,
                    onTap: () {
                      setState(() => _usingCustom = false);
                      onPick(o.value);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
                ChoiceTile(
                  label: '✏️ Something else…',
                  selected: _usingCustom || (hasValue && !presetValues.contains(current)),
                  onTap: () {
                    setState(() => _usingCustom = true);
                    onPick(_customCtrl.text.trim());
                  },
                ),
                if (_usingCustom) ...[
                  const SizedBox(height: 12),
                  _CustomField(
                    controller: _customCtrl,
                    hint: customHint,
                    onChanged: (v) => onPick(v.trim()),
                  ),
                ],
              ],
            ),
          ),
          PrimaryButton('Next', onPressed: hasValue ? onNext : null),
        ],
      ),
    );
  }

  Widget _review() {
    return AppScaffold(
      onBack: () => _go(2),
      progress: .86,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Title2("Here's your loop."),
          const SizedBox(height: 14),
          const Sub("This is the thing we'll watch together. You can always change it later."),
          const SizedBox(height: 22),
          LoopCard(trigger: _trigger, behavior: _behavior, reward: _rewardGuess),
          const Spacer(),
          PrimaryButton(widget.submitLabel,
              onPressed: () => widget.onComplete(_behavior, _trigger, _rewardGuess)),
        ],
      ),
    );
  }
}

class _CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  const _CustomField({required this.controller, required this.hint, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return TextField(
      controller: controller,
      autofocus: true,
      onChanged: onChanged,
      style: TextStyle(color: c.text, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: c.faint),
        filled: true,
        fillColor: c.surface,
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c.accent),
        ),
      ),
    );
  }
}

class LoopCard extends StatelessWidget {
  final String trigger, behavior, reward;
  const LoopCard({super.key, required this.trigger, required this.behavior, required this.reward});
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    Widget row(String tag, String fill, {bool last = false}) => Container(
          decoration: BoxDecoration(
            border: last ? null : Border(bottom: BorderSide(color: c.line)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              SizedBox(
                width: 76,
                child: Text(tag.toUpperCase(),
                    style: TextStyle(
                        color: c.faint, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
              ),
              Expanded(
                child: Text(fill.isEmpty ? '—' : fill,
                    style: TextStyle(color: c.text, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        );
    return Container(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.line),
      ),
      child: Column(
        children: [
          row('Trigger', trigger),
          row('Behavior', behavior),
          row('Reward', reward, last: true),
        ],
      ),
    );
  }
}
