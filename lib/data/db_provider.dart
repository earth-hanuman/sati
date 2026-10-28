import 'package:flutter/widgets.dart';
import 'database.dart';

/// Makes the single [AppDatabase] available to the widget tree.
class DatabaseProvider extends InheritedWidget {
  final AppDatabase db;
  const DatabaseProvider({super.key, required this.db, required super.child});

  static AppDatabase of(BuildContext context) {
    final p = context.dependOnInheritedWidgetOfExactType<DatabaseProvider>();
    assert(p != null, 'No DatabaseProvider found in context');
    return p!.db;
  }

  @override
  bool updateShouldNotify(DatabaseProvider oldWidget) => db != oldWidget.db;
}
