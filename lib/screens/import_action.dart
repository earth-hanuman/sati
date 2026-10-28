import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../data/database.dart';
import '../data/export.dart';

/// Lets the user pick a Sati backup JSON and imports it. Shows a snackbar with
/// the result. Safe to call from any screen with a Scaffold ancestor.
Future<void> importBackupFlow(BuildContext context, AppDatabase db) async {
  final messenger = ScaffoldMessenger.of(context);

  final picked = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['json'],
    withData: true,
  );
  if (picked == null || picked.files.isEmpty) return; // cancelled

  final f = picked.files.single;
  String? content;
  if (f.bytes != null) {
    content = utf8.decode(f.bytes!);
  } else if (f.path != null) {
    content = await File(f.path!).readAsString();
  }
  if (content == null) {
    messenger.showSnackBar(const SnackBar(content: Text("Couldn't read that file.")));
    return;
  }

  try {
    final r = await importBackupString(db, content);
    messenger.showSnackBar(
      SnackBar(content: Text('Restored ${r.loops} habits, ${r.moments} moments.')),
    );
  } on FormatException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.message)));
  } catch (_) {
    messenger.showSnackBar(const SnackBar(content: Text("Couldn't import that file.")));
  }
}
