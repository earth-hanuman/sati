// Reward-value trend math. See DATA_MODEL.md "The reward-value trend".

/// Exponentially weighted moving average over the raw reward values.
/// alpha: higher = more reactive, lower = smoother.
List<double> ewma(List<int> raw, {double alpha = 0.35}) {
  if (raw.isEmpty) return const [];
  final out = <double>[raw.first.toDouble()];
  for (var i = 1; i < raw.length; i++) {
    out.add(alpha * raw[i] + (1 - alpha) * out[i - 1]);
  }
  return out;
}

/// Plain-language delta comparing first raw value to latest.
String trendDelta(List<int> raw) {
  if (raw.isEmpty) return 'Log a moment to start your trend.';
  if (raw.length == 1) {
    return 'One data point. A few more and the pattern shows.';
  }
  final first = raw.first;
  final now = raw.last;
  if (now < first) {
    return '↓ from $first/10 to $now/10 — the shine is wearing off.';
  } else if (now > first) {
    return '↑ now $now/10 — still feels rewarding. Keep watching.';
  }
  return 'holding at $now/10 — keep collecting moments.';
}
