# Data Model & Trend Computation — spec

> The storage shape and the exact math behind the reward-value trend. Stack-independent.
> Everything is on-device, offline-first, no accounts. Companion to `MVP_SCOPE.md`. Date: 2026-10-28.

## Entities

### Loop
The habit the user is working. v1 = one active focus loop; schema already supports many.

| field | type | notes |
|-------|------|-------|
| `id` | string (uuid) | |
| `behavior` | string | the thing they do ("Evening phone scrolling") |
| `trigger` | string | guessed trigger, refinable |
| `rewardGuess` | string | guessed reward from onboarding |
| `isFocus` | bool | v1: exactly one true |
| `createdAt` | datetime (UTC) | |
| `archivedAt` | datetime? | null = active |
| `colorKey` | string | theme accent for the loop |

### Moment
One logged event against a loop. Two kinds, discriminated by `type`.

| field | type | notes |
|-------|------|-------|
| `id` | string (uuid) | |
| `loopId` | string | FK → Loop.id |
| `type` | enum `surf` \| `did` | which path was taken |
| `urgeStrength` | int 0–10 | captured in step 2, always present |
| `urgeAfter` | int 0–10? | `surf` only |
| `rewardCategory` | string? | `did` only — one of the coach-tree keys |
| `followupAnswerIndex` | int? | `did` only — 0/1/2 from the branch |
| `rewardValue` | int 0–10? | `did` only — the honest payoff; FEEDS THE TREND |
| `note` | string? | optional free text (never required, never parsed) |
| `createdAt` | datetime (UTC) | |

### AppMeta (single row)
`onboardingDone: bool`, `schemaVersion: int`, `createdAt`. No user identity, no device id.

## Relationships
- `Loop 1 — * Moment` (cascade delete).
- Trend for a loop = ordered `rewardValue`s from its `type:"did"` moments.
- `surf` moments are excluded from the reward trend; they feed a separate **"rode it out" counter**
  and an optional urge-drop stat (avg `urgeStrength - urgeAfter`).

## The reward-value trend (the hero math)

**Raw series:** for a loop, take all `did` moments ordered by `createdAt`, use their `rewardValue`.

**Why not plot raw?** A single series is noisy (a user has good and bad days). We show BOTH:
1. **Dots** = each raw `rewardValue` (honesty made visible).
2. **Line** = a smoothed trend so the drift is readable.

**Smoothing = EWMA** (exponentially weighted moving average), simple and streaming-friendly:

```
trend[0] = rewardValue[0]
trend[i] = α * rewardValue[i] + (1 - α) * trend[i-1]
α = 0.35      // higher = more reactive, lower = smoother; tune during polish
```

EWMA is chosen over a plain moving average because it needs no window bookkeeping, updates in O(1)
as each moment arrives, and naturally weights recent honesty more.

**Delta line (plain language), comparing first vs latest trend value:**
- latest < first → "↓ from {first}/10 to {latest}/10 — the shine is wearing off."
- latest > first → "↑ now {latest}/10 — still feels rewarding. Keep watching."
- equal → "holding at {latest}/10 — keep collecting moments."

**Empty / sparse states:**
- 0 `did` moments → no chart; show "Log a moment to start your trend."
- 1 moment → single dot + "One data point. A few more and the pattern shows."
- Always show dots even if the line is short.

## Seed / demo data
Prototype seeds `[8,7,7,6,5,6]` to show the drift immediately. Real app starts empty
(no fake progress — that would violate the honesty principle).

## Storage & privacy
- Local embedded DB (choose with stack: Drift/SQLite if Flutter; WatermelonDB/SQLite if RN).
- No network layer in v1. No analytics. No crash reporter that phones home (or opt-in only).
- **Export:** serialize all Loops + Moments + AppMeta to a single JSON file the user saves/shares.
- **Import:** parse that JSON back (merge or replace — decide in v1.x). Validate `schemaVersion`.
- **Migrations:** bump `schemaVersion`; write forward-only migration steps.

## Example records (JSON)

```json
{
  "schemaVersion": 1,
  "loops": [{
    "id": "l_01", "behavior": "Evening phone scrolling",
    "trigger": "Winding down at night", "rewardGuess": "A break or escape",
    "isFocus": true, "createdAt": "2026-10-28T20:00:00Z", "archivedAt": null, "colorKey": "warm"
  }],
  "moments": [
    { "id": "m_01", "loopId": "l_01", "type": "did", "urgeStrength": 6,
      "rewardCategory": "relief", "followupAnswerIndex": 1, "rewardValue": 3,
      "note": null, "createdAt": "2026-10-28T22:10:00Z" },
    { "id": "m_02", "loopId": "l_01", "type": "surf", "urgeStrength": 7,
      "urgeAfter": 2, "createdAt": "2026-10-29T22:40:00Z" }
  ]
}
```
