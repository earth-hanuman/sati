// Scripted (non-AI) coach content. The branch keys and suggested values here
// are the contract from CONTENT_coach-tree.md. No model — just a lookup table.

class FollowupAnswer {
  final String text;
  final int suggestedValue; // pre-sets the "how rewarding, really?" slider (0-10)
  const FollowupAnswer(this.text, this.suggestedValue);
}

class RewardCategory {
  final String key;
  final String emoji;
  final String label;
  final String subtitle;
  final String question;
  final List<FollowupAnswer> answers;
  const RewardCategory({
    required this.key,
    required this.emoji,
    required this.label,
    required this.subtitle,
    required this.question,
    required this.answers,
  });
}

const rewardCategories = <RewardCategory>[
  RewardCategory(
    key: 'relief',
    emoji: '😮‍💨',
    label: 'Relief / escape',
    subtitle: 'to get away from a feeling',
    question: 'Did it make the feeling go away — or just pause it?',
    answers: [
      FollowupAnswer('It genuinely went away', 7),
      FollowupAnswer('It just paused — then came back', 3),
      FollowupAnswer('It actually got a bit worse', 1),
    ],
  ),
  RewardCategory(
    key: 'pleasure',
    emoji: '😋',
    label: 'Pleasure / stimulation',
    subtitle: 'it feels good in the moment',
    question: 'Was it as good as you imagined — or did you stop noticing partway through?',
    answers: [
      FollowupAnswer('As good as I hoped', 7),
      FollowupAnswer('I stopped really enjoying it', 3),
      FollowupAnswer('Less than I pictured', 2),
    ],
  ),
  RewardCategory(
    key: 'comfort',
    emoji: '🫂',
    label: 'Comfort',
    subtitle: 'to soothe myself',
    question: 'Did it actually comfort you — or leave you wanting more?',
    answers: [
      FollowupAnswer('I feel genuinely soothed', 7),
      FollowupAnswer('I wanted more right after', 3),
      FollowupAnswer('I feel a bit emptier', 1),
    ],
  ),
  RewardCategory(
    key: 'boredom',
    emoji: '🥱',
    label: 'Fill the boredom',
    subtitle: 'something to do',
    question: 'Did it fill the time — or did the restlessness come back?',
    answers: [
      FollowupAnswer('I feel settled', 6),
      FollowupAnswer('The restlessness came right back', 3),
      FollowupAnswer('I lost more time than I meant to', 1),
    ],
  ),
  RewardCategory(
    key: 'connection',
    emoji: '💬',
    label: 'Connection',
    subtitle: 'to feel less alone',
    question: 'Did you feel more connected — or more alone afterward?',
    answers: [
      FollowupAnswer('More connected', 7),
      FollowupAnswer('About the same', 4),
      FollowupAnswer('More alone', 1),
    ],
  ),
  RewardCategory(
    key: 'control',
    emoji: '🎯',
    label: 'Control',
    subtitle: 'to discharge tension',
    question:
        'Did it leave you more in control — or just discharge the tension for a second?',
    answers: [
      FollowupAnswer('More in control', 7),
      FollowupAnswer("Tension's already back", 3),
      FollowupAnswer('I feel out of control', 1),
    ],
  ),
  RewardCategory(
    key: 'unsure',
    emoji: '🤔',
    label: 'Honestly not sure',
    subtitle: "that's okay",
    question: 'Take a slow breath. Looking back — what did you actually get?',
    answers: [
      FollowupAnswer('Something I needed', 6),
      FollowupAnswer('Not much, really', 3),
      FollowupAnswer('I feel worse than before', 1),
    ],
  ),
];

const strengthLabels = [
  'nothing at all', 'barely there', 'a faint tug', 'a small pull', 'building',
  'a noticeable pull', 'strong', 'pretty strong', 'hard to sit with', 'intense',
  'overwhelming',
];

const afterLabels = [
  'gone', 'almost gone', 'fading', 'easing', 'still here', 'holding steady',
  'rising', 'strong', 'very strong', 'intense', 'overwhelming',
];

const compareLabels = [
  'a letdown', 'not worth it', 'disappointing', 'underwhelming', 'meh',
  'okay, briefly', 'decent', 'good', 'really good', 'great', 'genuinely great',
];

/// Curiosity captions shown during the urge-surf breathing exercise.
const breathCaptions = [
  "Let the urge be here. You don't have to do anything about it.",
  'Where do you feel it in your body?',
  'Get curious — what is this urge actually like?',
  'Hmm. Just watch it, like weather.',
];
