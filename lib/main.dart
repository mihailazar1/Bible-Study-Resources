import 'package:bible_study_resources/models/database.dart';
import 'package:bible_study_resources/pages/home_page.dart';
import 'package:flutter/material.dart';

// to install apk on device: flutter run --release

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  await dbHelper.initDatabase(); // Ensure the database is initialized.

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
