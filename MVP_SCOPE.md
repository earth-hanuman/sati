# MVP Scope — v1 "Definition of Done"

> The single source of truth for what v1 ships. If it's not here, it's not in v1.
> Companion to `APP_CONCEPT.md`. Date: 2026-10-28.

## Goal of v1

Prove the core bet in people's hands: **does logging a craving honestly, and watching its
reward value drift down, actually loosen a habit's grip?** Ship the *insight engine* and nothing else.

Success = a user can, fully offline, map one habit loop and log moments against it over days,
and the reward-value trend becomes something they want to check.

## In scope (v1 ships these)

### A. Onboarding — map your first loop
- 6–7 light steps, warm tone, no account, no permissions upfront.
- Teaches the one idea (trigger → behavior → reward) in ~2 cards.
- Guides the user to define ONE focus loop: behavior → trigger → guessed reward.
- Ends with a "just notice, change nothing" intention and hands off to Home.

### B. Home
- A list of the user's active loops, each with its reward-value sparkline + moment count.
- Tapping a loop card starts a Moment for that loop.
- An **"Add a habit"** button that reuses the loop-mapping flow (shared `LoopForm`).
- Onboarding still runs only on first launch (when zero loops exist).
- **Multi-loop IS implemented** (the "unlock many" decision — first loop via onboarding, more via Add a habit).

### C. The Moment capture (the hero — already prototyped)
- Pick loop (focus loop pre-selected) → urge strength (0–10 slider).
- Fork: **Ride it out** (breathing/urge-surf + after check-in) OR **I did it** (explore the reward).
- "Explore the reward" = reward-category pick → one branching follow-up → "how rewarding, really?" slider.
- Writes a Moment record; updates the trend.

### D. The trend ("What I'm learning")
- Reward-value line over time, with past moments as data points.
- A plain-language delta line ("↓ the shine is wearing off").

### E. Platform & data
- Cross-platform (stack TBD), runs on iOS + Android.
- 100% on-device storage, offline-first, no account, no network calls.
- Local export (JSON) so the user owns their data. Import optional.

## Explicitly OUT of v1 (deferred, not cancelled)

- ~~Multiple active loops / "unlock many"~~ (DONE — shipped)
- The Learn module arc / daily lessons (v2)
- Local notifications / reminders (v1.x — add once core is proven)
- Any AI (maybe-never for core; free-text layer is v3 at most)
- Accounts, cloud sync, multi-device
- Streaks, gamification, social — permanently out (see concept §9)
- Analytics / telemetry — intentionally none (privacy thesis)
- Backend of any kind

## Non-functional bar for v1

- **Privacy:** no tracking, no analytics SDKs, no network permission if avoidable.
- **Accessibility:** large tap targets (already), dynamic type, screen-reader labels, sufficient contrast in light & dark.
- **Performance:** Moment capture must feel instant; cold start < 2s.
- **Offline:** every feature works in airplane mode. This is a hard requirement, not a nice-to-have.
- **Theming:** light + dark from day one (prototype already does this).

## Done checklist (ship when all true)

- [ ] A new user can complete onboarding and have one focus loop.
- [ ] A user can log a "ride it out" moment and an "I did it" moment.
- [ ] The trend updates and persists across app restarts.
- [ ] Works fully offline on a real iOS and a real Android device.
- [ ] Data export produces a file the user can save.
- [ ] Light & dark both look right; text scales; VoiceOver/TalkBack can read the flow.
- [ ] No network calls, no analytics, no crash on the happy path.
- [ ] OSS repo: README, LICENSE, build instructions.
