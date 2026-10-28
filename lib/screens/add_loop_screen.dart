import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import '../data/database.dart';
import '../data/db_provider.dart';
import 'loop_form.dart';

/// Standalone "add a habit" flow: reuses the loop-mapping steps, inserts a new
/// (non-focus) loop, then pops back to Home.
class AddLoopScreen extends StatelessWidget {
  const AddLoopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = DatabaseProvider.of(context);
    return LoopForm(
      onExitFirst: () => Navigator.of(context).pop(),
      submitLabel: 'Add this habit',
      onComplete: (behavior, trigger, rewardGuess) async {
        await db.insertLoop(LoopsCompanion.insert(
          id: const Uuid().v4(),
          behavior: behavior,
          trigger: Value(trigger),
          rewardGuess: Value(rewardGuess),
          isFocus: const Value(false),
          createdAt: DateTime.now().toUtc(),
        ));
        if (context.mounted) Navigator.of(context).pop();
      },
    );
  }
}
