# Coach Question Tree — content spec

> The scripted (non-AI) Socratic flow for the Moment capture. Stack-independent content.
> This is the "coach." No LLM — just a fixed backbone + branching follow-ups keyed to taps.
> Companion to `APP_CONCEPT.md` §8. Date: 2026-10-28.

## Design rules

- **Questions, never advice.** The coach asks; the user discovers. (Mechanism + legal.)
- **Taps over typing.** Every branch resolves via chips/sliders so no model is needed to parse text.
- **No judgment.** Doing the behavior is never framed as failure — it's a data point.
- **Rotate phrasings.** Each prompt has 2–3 variants; pick at random so it never feels robotic.
- **Everything maps to a number.** The end goal of the "I did it" path is a single
  `rewardValue` (0–10) that feeds the trend. Follow-up answers *pre-set* that slider; the user can nudge it.

## The backbone (every moment)

```
1. Which loop?            → pick focus loop (default) or another / quick-add
2. How strong? (0–10)     → urgeStrength
3. Fork:
   ├─ "Riding it out"  → PATH A (urge-surf)
   └─ "I did it"       → PATH B (explore the reward)
```

### Strength slider labels (0→10)
`nothing at all · barely there · a faint tug · a small pull · building · a noticeable pull ·
strong · pretty strong · hard to sit with · intense · overwhelming`

---

## PATH A — Riding it out (urge-surf)

Goal: experience that an urge is a wave that crests and passes without acting.

1. **Breathing orb** (~16–20s, skippable). Rotating curiosity captions:
   - "Let the urge be here. You don't have to do anything about it."
   - "Where do you feel it in your body?"
   - "Get curious — what is this urge actually *like*?"
   - "Hmm. Just watch it, like weather."
2. **After check-in:** "Where's the urge now?" → `urgeAfter` (0–10 slider).
   Labels: `gone · almost gone · fading · easing · still here · holding steady · rising · strong · very strong · intense · overwhelming`
3. **Close** (text keyed to delta):
   - if `urgeAfter < urgeStrength`: "You rode the wave. It went from {s} to {a} — and you didn't have to act on it. That's the muscle."
   - else: "Staying with an urge without acting is the whole practice. It gets easier."

Record: a Moment with `type: "surf"`, `urgeStrength`, `urgeAfter`. (No rewardValue — surf moments don't feed the reward trend; they feed a separate "rode it out" count.)

---

## PATH B — Explore the reward (the rewiring)

### B1. "What were you hoping to get?" → pick a reward category

| key | label | subtitle |
|-----|-------|----------|
| `relief`     | 😮‍💨 Relief / escape | to get away from a feeling |
| `pleasure`   | 😋 Pleasure / stimulation | it feels good in the moment |
| `comfort`    | 🫂 Comfort | to soothe myself |
| `boredom`    | 🥱 Fill the boredom | something to do |
| `connection` | 💬 Connection | to feel less alone |
| `control`    | 🎯 Control / to feel on top of things | to discharge tension |
| `unsure`     | 🤔 Honestly not sure | that's okay |

### B2. One branching follow-up (keyed to category)

Each answer carries a **suggested rewardValue** (`→ n`) — the honest/"it worked" answer scores
higher, the "it didn't deliver" answers score lower. This is the negative-prediction-error engine.

**relief** — "Did it make the feeling go away — or just pause it?"
- It genuinely went away → 7
- It just paused — then came back → 3
- It actually got a bit worse → 1

**pleasure** — "Was it as good as you imagined — or did you stop noticing partway through?"
- As good as I hoped → 7
- I stopped really tasting/enjoying it → 3
- Less than I pictured → 2

**comfort** — "Did it actually comfort you — or leave you wanting more?"
- I feel genuinely soothed → 7
- I wanted more right after → 3
- I feel a bit emptier → 1

**boredom** — "Did it fill the time — or did the restlessness come back?"
- I feel settled → 6
- The restlessness came right back → 3
- I lost more time than I meant to → 1

**connection** — "Did you feel more connected — or more alone afterward?"
- More connected → 7
- About the same → 4
- More alone → 1

**control** — "Did it leave you more in control — or just discharge the tension for a second?"
- More in control → 7
- Tension's already back → 3
- I feel out of control → 1

**unsure** — "Take a slow breath. Looking back — what did you actually get?"
- Something I needed → 6
- Not much, really → 3
- I feel worse than before → 1

### B3. "So — how rewarding was it, really?" → `rewardValue` (0–10)

Slider pre-set to the suggested value from B2; user can adjust.
Labels: `a letdown · not worth it · disappointing · underwhelming · meh · okay, briefly · decent · good · really good · great · genuinely great`
Caption: "Not how good you *expected*. How it actually left you feeling."

### B4. Close
"That's one more data point. You didn't have to change anything — just by looking honestly,
your brain updates what this habit is really worth." → show updated trend.

Record: a Moment with `type: "did"`, `urgeStrength`, `rewardCategory`, `followupAnswerIndex`, `rewardValue`.

---

## Phrasing variants (rotate to avoid robotic feel)

Keep 2–3 per key question, e.g. for B1:
- "What were you hoping to get?"
- "What were you really after, just then?"
- "If you're honest — what was the pull promising you?"

(Fill out the rest during content polish. Variants are cosmetic; the branch keys/values above are the contract.)

## Notes for implementation
- The category → suggestedValue table is the only "intelligence." It's a lookup, not a model.
- Keep categories/values in a single data file (JSON/Dart map) so content can change without touching UI.
- A user who always answers "it didn't deliver" will see their trend fall fast — which is the point.
- Later (v3, optional): an AI layer could parse a free-text "what happened?" into a category — but the scored branch stays the fallback.
