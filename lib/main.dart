import 'package:flutter/material.dart';
import 'app.dart';
import 'data/database.dart';
import 'data/db_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  runApp(DatabaseProvider(db: db, child: const SatiApp()));
}
