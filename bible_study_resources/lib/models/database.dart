import 'dart:async';
import 'dart:io';
import 'package:bible_study_resources/models/manna.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late final Future<Database> database;

  DatabaseHelper() {
    database = initDatabase();
  }

  Future<Database> initDatabase() async {
    // Get the directory for the application's database.
    final dbDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(dbDirectory.path, 'manna.db');

    // Check if the database already exists.
    if (await databaseExists(dbPath)) {
      return openDatabase(dbPath);
    }

    // If not, copy the pre-populated database from assets.
    await Directory(dirname(dbPath)).create(recursive: true);
    ByteData data = await rootBundle.load(join('lib/assets', 'manna.sqlite'));
    List<int> bytes = data.buffer.asUint8List();
    await File(dbPath).writeAsBytes(bytes);

    return openDatabase(dbPath);
  }

  Future<List<Manna>> getAllMannas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('manna');

    return List.generate(maps.length, (i) {
      return Manna(
        id: maps[i]['id'] as int,
        day: maps[i]['day'] as int,
        month_number: maps[i]['month_number'] as int,
        month_name: maps[i]['month_name'] as String,
        display_title: maps[i]['display_title'] as String,
        book: maps[i]['book'] as String,
        book_id: maps[i]['book_id'] as int,
        chapter: maps[i]['chapter'] as String,
        verse: maps[i]['verse'] as String,
        verse_id: maps[i]['verse_id'] as int,
        verse_text: maps[i]['verse_text'] as String,
        content: maps[i]['content'] as String,
        lang: maps[i]['lang'] as String,
        category: maps[i]['category'] as String,
        category_name: maps[i]['category_name'] as String,
        herald: maps[i]['herald'] as String,
      );
    });
  }

  Future<String> getMannaDisplayTitle(int month_number, int day) async {
    final db = await database;

    String whereClause = 'month_number = ? AND day = ?';
    List<dynamic> whereArgs = [month_number, day];

    final List<Map<String, dynamic>> maps = await db.query(
      'manna',
      columns: ['display_title'],
      where: whereClause,
      whereArgs: whereArgs,
    );

    return maps[0]['display_title'] as String;
  }

  Future<String> getMannaVerse(
      int month_number, int day, int partOfVerse) async {
    final db = await database;

    String whereClause = 'month_number = ? AND day = ?';
    List<dynamic> whereArgs = [month_number, day];

    final List<Map<String, dynamic>> maps = await db.query(
      'manna',
      columns: ['book', 'chapter', 'verse', 'verse_text'],
      where: whereClause,
      whereArgs: whereArgs,
    );

    String reference = ' - ' +
        maps[0]['book'] +
        ' ' +
        maps[0]['chapter'] +
        ':' +
        maps[0]['verse'];

    String onlyVerse = maps[0]['verse_text'];

    if (partOfVerse == 0) {
      return onlyVerse + reference;
    } else if (partOfVerse == 1) {
      return onlyVerse;
    } else {
      return reference + ' - ';
    }
  }

  Future<String> getMannaContent(int month_number, int day) async {
    final db = await database;

    String whereClause = 'month_number = ? AND day = ?';
    List<dynamic> whereArgs = [month_number, day];

    final List<Map<String, dynamic>> maps = await db.query(
      'manna',
      columns: ['content', 'herald'],
      where: whereClause,
      whereArgs: whereArgs,
    );

    String content = maps[0]['content'];
    String defaultHerald = 'R0000';

    if (maps[0]['content'].toString() != defaultHerald) {
      content += ' - ' + maps[0]['herald'];
    }

    return content;
  }
}
