import 'package:flutter/material.dart';
import '../data/trend.dart';
import '../theme/app_theme.dart';

/// The hero chart: raw reward values as dots + an EWMA-smoothed line,
/// with a soft gradient fill. Draws on a 0..10 vertical scale.
class TrendChart extends StatelessWidget {
  final List<int> raw;
  final double height;
  const TrendChart({super.key, required this.raw, this.height = 120});

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    if (raw.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text('Log a moment to start your trend.',
              style: TextStyle(color: c.faint, fontSize: 14)),
        ),
      );
    }
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _TrendPainter(raw: raw, smoothed: ewma(raw), accent: c.accent),
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  final List<int> raw;
  final List<double> smoothed;
  final Color accent;
  _TrendPainter({required this.raw, required this.smoothed, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    const pad = 10.0;
    const minV = 0.0, maxV = 10.0;
    final n = raw.length;

    double x(int i) =>
        pad + (n == 1 ? (size.width - 2 * pad) / 2 : i * (size.width - 2 * pad) / (n - 1));
    double y(double v) =>
        size.height - pad - (v - minV) / (maxV - minV) * (size.height - 2 * pad);

    final linePts = [
      for (var i = 0; i < n; i++) Offset(x(i), y(smoothed[i])),
    ];

    // gradient fill under the smoothed line
    if (n >= 2) {
      final fill = Path()..moveTo(linePts.first.dx, size.height - pad);
      for (final p in linePts) {
        fill.lineTo(p.dx, p.dy);
      }
      fill
        ..lineTo(linePts.last.dx, size.height - pad)
        ..close();
      final fillPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [accent.withValues(alpha: 0.28), accent.withValues(alpha: 0.0)],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
      canvas.drawPath(fill, fillPaint);
    }

    // smoothed line
    if (n >= 2) {
      final linePaint = Paint()
        ..color = accent
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      final path = Path()..moveTo(linePts.first.dx, linePts.first.dy);
      for (final p in linePts.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, linePaint);
    }

    // raw dots
    final dotPaint = Paint()..color = accent;
    for (var i = 0; i < n; i++) {
      final isLast = i == n - 1;
      canvas.drawCircle(Offset(x(i), y(raw[i].toDouble())), isLast ? 4.5 : 2.6, dotPaint);
    }
    // halo on the last point
    final last = Offset(x(n - 1), y(raw.last.toDouble()));
    canvas.drawCircle(
      last,
      9,
      Paint()
        ..color = accent.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant _TrendPainter old) =>
      old.raw != raw || old.accent != accent;
}
