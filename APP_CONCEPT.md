# Habit-Change App — Concept & Build Notes

> Working brainstorm doc. Captures everything decided so far so we can build later.
> Date started: 2026-10-28

---

## 1. Origin & inspiration

Inspired by the work of **Dr. Judson "Jud" Brewer** (psychiatrist/neuroscientist, Brown University),
author of *The Craving Mind* and *Unwinding Anxiety*. He built three commercial apps through his
company **MindSciences / Claritas MindSciences** (acquired by **Sharecare** in 2020):

| App | Target | Format |
|-----|--------|--------|
| Craving to Quit | Smoking cessation | ~22 modules / 22 days, 5–15 min each (audio, video, animation) |
| Eat Right Now | Emotional / stress eating | 28-day, 28 modules |
| Unwinding Anxiety | Anxiety & worry | 30 modules over ~2 months |

Those apps are **proprietary and subscription-based** (not free, not open source). We are NOT cloning them.
We are building our own app on the **published science**, which is open.

## 2. The science we're building on (the mechanism)

Core idea: habits run on a **habit loop** = **Trigger → Behavior → Reward**, learned via
**reward-based learning** (basal ganglia / striatum). Getting "caught up" in craving/rumination
correlates with **posterior cingulate cortex (PCC)** activity; mindfulness quiets it.

You change a habit NOT by willpower, but by **changing how rewarding the brain thinks the behavior is**:
1. **Awareness** — map your own loops.
2. **Explore the reward** — pay full attention while doing the behavior → brain updates the real reward value (a *negative prediction error*).
3. **Bigger Better Offer (BBO)** — substitute a more rewarding alternative (curiosity, breath, body scan).

Signature technique: **RAIN** (Recognize, Allow, Investigate, Note) + the curiosity prompt **"Hmm."**
(RAIN predates Brewer — generic mindfulness, safe to use.)

### Key primary sources (for clinical scaffolding)
- Brewer et al. 2011, *Drug & Alcohol Dependence* 119:72–80 — smoking RCT (31% vs 6% abstinence at 17 wk).
- Mason, Jhaveri, Cohn & Brewer 2018, *J. Behavioral Medicine* 41(2):160–73 — eating app, 40% reduction in craving-related eating (no control arm).
- Roy et al. 2021, *JMIR* 23(12):e26987 — Unwinding Anxiety RCT (GAD), NNT = 1.6. **Strongest design.**
- Nardi et al. 2022, *JMIR* e33696 — which app FEATURES correlated with improvement. **Most useful for us.**
- Brewer, Garrison & Whitfield-Gabrieli 2013, *Front. Hum. Neurosci.* — PCC / self-reference theory.

### Caveat
Most efficacy numbers come from Brewer's own lab / company (he holds equity). Build confidently on the
**mechanism**; claim modestly on **outcomes**.

## 3. Legal guardrails (not legal advice)

- **Copyright** ✅ — ideas/methods are free to use. Do NOT copy his lesson scripts, wording, audio/video,
  animations, UI, or book passages. Build from understanding, in our own words/voice.
- **Trademark** ⚠️ (biggest real risk) — do NOT use "Unwinding Anxiety®", "Eat Right Now®",
  "Craving to Quit®", "Dr. Jud", or imply endorsement. Pick a distinct name.
- **Patents** ⚠️ — web + Google Patents search surfaced none; couldn't fully confirm (CV unparsed here).
  TODO: run authoritative **USPTO assignee search** (MindSciences / Claritas / Sharecare; inventor Brewer)
  before building anything mechanically novel (e.g. neurofeedback). Broad method patents unlikely (prior art).
- **Health claims** ⚠️ (separate lane — FTC/FDA) — stay general-wellness. Do NOT claim to "treat"
  anxiety/addiction. Avoids digital-therapeutic regulation.

## 4. Product thesis

Most habit apps are **willpower prosthetics** (streaks, blockers, gamified pressure). Brewer's insight is
that willpower barely works. So the entire app is built around ONE loop:
**notice → get curious → see the reward shrink.** If a feature doesn't serve that loop, it's cut.

**Framing (leading candidate):** the app is a **"lab for running experiments on your own habits."**
Curiosity is both the mechanism and the brand. (See open question Q1.)

One-sentence pitch:
> A journal that watches one specific thing — whether your habits actually reward you —
> and shows you the answer until your brain believes it.

Strategic bet: a **general habit-change engine** (user points it at any habit), NOT separate vertical apps.
Kept from feeling generic by shipping 2–3 strong starter loops (phone/scrolling, stress-snacking, procrastination).

### Decisions (locked 2026-10-28)
- **Focus:** *Start one, unlock many* — onboard with a single focus loop, open multi-loop tracking once the user has the hang of it.
- **Hero element:** *The Moment capture* — the sub-5-second in-the-moment logging + urge-surf is the centerpiece; everything else supports it.
- **Platform:** *Cross-platform* — one codebase for iOS + Android. **Stack: Flutter (Dart).** Chosen for pixel-level control of the custom animated UI (breathing orb, reward-value chart, transitions) and first-class local SQLite.
- **Local storage:** **Drift** (SQLite) — typed queries suit the trend aggregations; rock-solid offline.
- **Business model:** *Open source and free* — no monetization. Public repo, open license. (A deliberate inversion of Brewer's proprietary, subscription apps.)
- **Storage implication:** fully **on-device / offline-first**, no accounts required. Keeps it free to run, privacy-first, and simple. (Optional self-hostable or export/import sync could come later.)

## 5. Core data object

```
Loop
 ├─ Trigger             (emotion, time, place, person, feeling)
 ├─ Behavior            (what I do)
 ├─ Reward              (what I ACTUALLY get — not the obvious one)
 └─ Reward value trend  ← the heart of the app; updates over time
```

A user keeps ~3–5 active loops. The app is generic *because* this object is generic, but never feels
generic because it holds the user's own loops in their own words.

## 6. Screens (only four)

1. **Home — "Your Loops"** — calm list, each with a reward-value sparkline. One primary button:
   *"Something's happening right now."* No feed, no badges, no social.
2. **The Moment (capture)** — MUST be sub-5-seconds. Pick loop → urge strength slider (0–10) →
   either *"Ride it out"* (urge-surf / RAIN exercise) or *"I did it — let's look"* (mindful-rep:
   *what did you actually get?*). Doing the behavior is NOT punished — it's an invitation to pay attention.
3. **Loop detail — "What I'm learning"** — the payoff: the **reward-value trend line** over time,
   plus a log of past notes (moving to re-read).
4. **Learn** — ~20–30 short "modules" reframed as **3-min concept + an experiment to try today**.
   The structured arc that onboards new users.

## 7. Daily rhythm

- Morning: one short lesson + set an intention (e.g. "today I'm just *noticing* the trigger").
- Daytime: tap the Moment button whenever a loop fires.
- Evening: 30-sec reflection → updates the trend lines.
- Low-burden, high-insight. Opposite of a demanding gamified app.

## 8. The "coach" — built WITHOUT AI (decided)

Goal: Socratic reflective questioning that helps users discover their real reward / map loops.
Decision: do it with **scripting + branching logic**, not an LLM. (Brewer's apps used zero AI.)

Chosen approach: **branching decision tree** —
- fixed question backbone: *What set this off? → What did you do? → What were you hoping to get? →
  What did you actually get? → How does that compare?*
- follow-ups branch on tapped reward category (e.g. "relief/escape" → *"Did it make the feeling go away,
  or just pause it?"*; "pleasure/taste" → *"As good as you imagined, or did you stop noticing partway?"*).
- rely on taps/sliders/structured choices over free text (no model to parse it).
- rotate several phrasings per prompt so it doesn't feel robotic.

Why AI-free is good here: privacy (intimate data, on-device), $0 to run, works offline, legally safer
(reviewed script can't give medical advice), and better mechanism fidelity (user's OWN discovery).
AI kept as a *maybe-later* layer only for parsing free-text journaling.

## 9. Explicitly OUT of scope (and why)

- ❌ Streaks / don't-break-the-chain — contradicts the philosophy; relapse is data, not failure; shame feeds loops.
- ❌ Blocking / app-lockout — willpower-by-force; not our lane.
- ❌ Social feed / friends / sharing — intimate, sometimes shameful data. Privacy is a feature.
- ❌ Heavy gamification (points, coins, avatars) — extrinsic rewards undercut intrinsic curiosity.
- ❌ Generic meditation library — don't become a Calm clone; exercises are loop-targeted (urge-surf, RAIN).
- ❌ Clinical/therapeutic claims — stay general-wellness.
- ❌ Advice-giving chatbot — breaks the mechanism + health-claim risk. Coach ASKS, never advises.

## 10. Build phasing

1. **v1 (irreducible core):** Loops + Moment capture + reward-value trend. Ship just the insight engine.
   If that alone doesn't hook people, no content will.
2. **v2:** The Learn arc (lessons + daily experiments) for structure & retention.
3. **v3:** (Optional) AI free-text layer on top of the scripted coach.

## 11. Open questions

### Resolved (2026-10-28) — see §4 Decisions
- ~~Q2 Focus~~ → Start one, unlock many.
- ~~Q3 Hero~~ → The Moment capture.
- ~~Q4 Platform~~ → Cross-platform (iOS + Android).
- ~~Q5 Storage~~ → On-device / offline-first, no accounts.
- ~~Q6 Business model~~ → Open source and free.

### Resolved (continued)
- ~~Q4a Stack~~ → **Flutter (Dart) + Drift (SQLite).**

### Still open
- **Q1 — Tone/framing:** "self-experiment Lab" vs. something warmer/less clinical? (affects naming, copy, visual design)
- **Q7 — Name:** needs a distinct, non-trademark-colliding name.
- **Q8 — License:** which open-source license (MIT / Apache-2.0 / GPL)?
