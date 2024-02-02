import 'dart:async';
import 'dart:io';
import 'package:bible_study_resources/models/the_book.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class BookDatabaseHelper {
  late final Future<Database> database;

  BookDatabaseHelper() {
    database = initDatabase();
  }

  Future<Database> initDatabase() async {
    // Get the directory for the application's database.
    final dbDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(dbDirectory.path, 'bible-sqlite.dbf');

    // Check if the database already exists.
    // if (await databaseExists(dbPath)) {
    //   return openDatabase(dbPath);
    // }

    // If not, copy the pre-populated database from assets.
    await Directory(dirname(dbPath)).create(recursive: true);
    ByteData data =
        await rootBundle.load(join('lib/assets', 'bible-sqlite.db'));
    List<int> bytes = data.buffer.asUint8List();
    await File(dbPath).writeAsBytes(bytes);

    return openDatabase(dbPath);
  }

  Future<List<TheBook>> getALLVersesOfABook(int b) async {
    final db = await database;

    String whereClause = 'b = ?';
    List<dynamic> whereArgs = [b];
    final List<Map<String, dynamic>> maps = await db.query(
      't_asv',
      columns: ['t'],
      where: whereClause,
      whereArgs: whereArgs,
    );

    return List.generate(maps.length, (i) {
      return TheBook(
        id: maps[i]['id'] as int,
        b: maps[i]['b'] as int,
        c: maps[i]['c'] as int,
        v: maps[i]['v'] as int,
        t: maps[i]['t'] as String,
      );
    });
  }

/*
  Future<String> getMannaDisplayTitle(
      int month_number, int day, int MANNA_TYPE) async {
    final db = await database;

    String whereClause = 'month_number = ? AND day = ?';
    List<dynamic> whereArgs = [month_number, day];

    final List<Map<String, dynamic>> maps = await db.query(
      'manna',
      columns: ['display_title'],
      where: whereClause,
      whereArgs: whereArgs,
    );

    return maps[MANNA_TYPE]['display_title'] as String;
  }

  Future<String> getMannaVerse(
      int month_number, int day, int partOfVerse, int MANNA_TYPE) async {
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
        maps[MANNA_TYPE]['book'] +
        ' ' +
        maps[MANNA_TYPE]['chapter'] +
        ':' +
        maps[MANNA_TYPE]['verse'];

    String onlyVerse = maps[MANNA_TYPE]['verse_text'];

    if (partOfVerse == 0) {
      return onlyVerse + reference;
    } else if (partOfVerse == 1) {
      return onlyVerse;
    } else {
      return reference + ' - ';
    }
  }

  Future<String> getMannaContent(
      int month_number, int day, int MANNA_TYPE) async {
    final db = await database;

    String whereClause = 'month_number = ? AND day = ?';
    List<dynamic> whereArgs = [month_number, day];

    final List<Map<String, dynamic>> maps = await db.query(
      'manna',
      columns: ['content', 'herald'],
      where: whereClause,
      whereArgs: whereArgs,
    );

    String content = maps[MANNA_TYPE]['content'];

    return content;
  }
  */
}
