# Sati

**A curiosity-based habit-change app.** Not another willpower tracker — Sati helps you change a
habit by changing how *rewarding* your brain thinks it is. You notice the urge, get curious about
what you actually get from the behavior, and watch its reward value drift down over time.

> *Sati* (सति) is the Pāli word for **mindfulness / awareness** — the first step of the method.

Offline-first, private by design, and open source.

## Why

The approach is built on the published science of **reward-based learning** and the
**habit loop** (trigger → behavior → reward), popularized by Dr. Judson Brewer in
*The Craving Mind* and *Unwinding Anxiety*. Instead of fighting urges with willpower, you pay
honest attention to the reward — which lets the brain update what the habit is really worth
(a *negative prediction error*).

Sati is an **independent, original implementation of that general science**. It is **not affiliated
with, endorsed by, or derived from** Dr. Brewer or his apps (Unwinding Anxiety®, Eat Right Now®,
Craving to Quit®), and copies none of their content.

## What it does (v1)

- **Map one focus loop** in a short, warm onboarding (behavior → trigger → guessed reward).
- **The Moment** — the hero flow. When an urge hits, log it in seconds and either:
  - **ride it out** with a brief urge-surf, or
  - **look at what you got** via a scripted Socratic reflection (no AI).
- **The reward-value trend** — a chart that drifts down as the shine wears off. That drift *is* the
  habit loosening its grip.

No streaks, no shame, no blockers, no gamification, no social feed, no tracking. See
[`MVP_SCOPE.md`](MVP_SCOPE.md) for the full in/out list.

## Not medical advice

Sati is a general-wellness and self-reflection tool. It does not diagnose, treat, or cure anxiety,
addiction, or any condition. If you're struggling, please talk to a qualified professional.

## Tech

- **Flutter** (Dart) — one codebase for iOS & Android.
- **Drift** (SQLite) — all data stays **on your device**. No accounts, no network calls.

### Project layout

```
lib/
  main.dart            app entry
  app.dart             theme + root routing (onboarding vs home)
  theme/               color system (light & dark)
  content/             the scripted coach content (reward categories, prompts)
  data/                Drift database, trend math, db provider
  widgets/             shared UI + the trend chart
  screens/             onboarding, home, moment capture
prototype/             throwaway clickable HTML mockups (design reference)
```

### Planning docs

`APP_CONCEPT.md` · `MVP_SCOPE.md` · `CONTENT_coach-tree.md` · `DATA_MODEL.md`

## Build & run

```bash
flutter pub get
dart run build_runner build   # generates Drift code (lib/data/database.g.dart)
flutter run                   # pick a device
flutter test                  # unit tests
```

## License

[GPL-3.0](LICENSE). Derivatives must stay open source.
