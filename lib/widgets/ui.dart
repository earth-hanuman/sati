import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Screen shell with consistent padding and an optional top bar (back + progress).
class AppScaffold extends StatelessWidget {
  final Widget child;
  final VoidCallback? onBack;
  final double? progress; // 0..1, shows a progress bar when non-null
  const AppScaffold({super.key, required this.child, this.onBack, this.progress});

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (onBack != null || progress != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          if (onBack != null)
                            _CircleBack(onTap: onBack!)
                          else
                            const SizedBox(width: 2),
                          if (progress != null) ...[
                            const SizedBox(width: 14),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: LinearProgressIndicator(
                                  value: progress!.clamp(0, 1),
                                  minHeight: 4,
                                  backgroundColor: c.line,
                                  valueColor: AlwaysStoppedAnimation(c.accent),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleBack extends StatelessWidget {
  final VoidCallback onTap;
  const _CircleBack({required this.onTap});
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return InkResponse(
      onTap: onTap,
      radius: 26,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: c.line.withValues(alpha: 0.5), shape: BoxShape.circle),
        child: Icon(Icons.chevron_left, color: c.text, size: 24),
      ),
    );
  }
}

class Eyebrow extends StatelessWidget {
  final String text;
  const Eyebrow(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Text(
        text.toUpperCase(),
        style: TextStyle(
          color: context.c.faint,
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.6,
        ),
      );
}

class Title1 extends StatelessWidget {
  final String text;
  const Title1(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: context.c.text,
          fontSize: 29,
          height: 1.18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      );
}

class Title2 extends StatelessWidget {
  final String text;
  const Title2(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: context.c.text,
          fontSize: 23,
          height: 1.3,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
      );
}

class Sub extends StatelessWidget {
  final String text;
  const Sub(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(color: context.c.muted, fontSize: 16, height: 1.55),
      );
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const PrimaryButton(this.label, {super.key, this.onPressed});
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Opacity(
      opacity: onPressed == null ? 0.4 : 1,
      child: Material(
        color: c.accent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Center(
              child: Text(label,
                  style: TextStyle(color: c.accentInk, fontSize: 17, fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ),
    );
  }
}

class GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const GhostButton(this.label, {super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label,
          style: TextStyle(color: context.c.muted, fontSize: 15, fontWeight: FontWeight.w600)),
    );
  }
}

/// A tappable option chip (used in onboarding + reward category pick).
class ChoiceTile extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;
  const ChoiceTile({
    super.key,
    required this.label,
    this.subtitle,
    this.selected = false,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Material(
      color: selected ? c.accentSoft : c.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? c.accent : c.line),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(color: c.text, fontSize: 16, fontWeight: FontWeight.w600)),
              if (subtitle != null) ...[
                const SizedBox(height: 3),
                Text(subtitle!,
                    style: TextStyle(color: c.faint, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Paints a dashed rounded-rectangle border around [child].
class DashedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;
  const DashedBorder({
    super.key,
    required this.child,
    required this.color,
    this.radius = 20,
    this.dashWidth = 6,
    this.dashGap = 5,
    this.strokeWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: color,
        radius: radius,
        dashWidth: dashWidth,
        dashGap: dashGap,
        strokeWidth: strokeWidth,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius, dashWidth, dashGap, strokeWidth;
  _DashedBorderPainter({
    required this.color,
    required this.radius,
    required this.dashWidth,
    required this.dashGap,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    for (final metric in path.computeMetrics()) {
      var dist = 0.0;
      while (dist < metric.length) {
        canvas.drawPath(metric.extractPath(dist, dist + dashWidth), paint);
        dist += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) =>
      old.color != color ||
      old.radius != radius ||
      old.dashWidth != dashWidth ||
      old.dashGap != dashGap ||
      old.strokeWidth != strokeWidth;
}

/// A 0..10 slider with a big readout and a changing label.
class StrengthPicker extends StatelessWidget {
  final int value;
  final List<String> labels;
  final ValueChanged<int> onChanged;
  const StrengthPicker({
    super.key,
    required this.value,
    required this.labels,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Column(
      children: [
        Text('$value',
            style: TextStyle(
                color: c.text, fontSize: 68, fontWeight: FontWeight.w700, height: 1, letterSpacing: -2)),
        const SizedBox(height: 6),
        Text(labels[value.clamp(0, labels.length - 1)],
            style: TextStyle(color: c.muted, fontSize: 15)),
        const SizedBox(height: 20),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 10,
            activeTrackColor: c.accent,
            inactiveTrackColor: c.line,
            thumbColor: Colors.white,
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 22),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
          ),
          child: Slider(
            value: value.toDouble(),
            min: 0,
            max: 10,
            divisions: 10,
            onChanged: (v) => onChanged(v.round()),
          ),
        ),
      ],
    );
  }
}
