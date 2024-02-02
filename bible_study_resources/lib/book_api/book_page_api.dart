import 'package:bible_study_resources/book_api/book_chapter.dart';
import "package:flutter/material.dart";

class BookPageAPI extends StatefulWidget {
  @override
  _BibleAppState createState() => _BibleAppState();
}

class _BibleAppState extends State<BookPageAPI> {
  String _selectedBook = 'Genesis';
  int _selectedChapter = 1;

  final List<String> _books = [
    'Genesis',
    'Exodus',
    'Leviticus',
    'Numbers',
    'Deuteronomy',
    'Joshua',
    'Judges',
    'Ruth',
    '1 Samuel',
    '2 Samuel',
    '1 Kings',
    '2 Kings',
    '1 Chronicles',
    '2 Chronicles',
    'Ezra',
    'Nehemiah',
    'Esther',
    'Job',
    'Psalms',
    'Proverbs',
    'Ecclesiastes',
    'Song of Solomon',
    'Isaiah',
    'Jeremiah',
    'Lamentations',
    'Ezekiel',
    'Daniel',
    'Hosea',
    'Joel',
    'Amos',
    'Obadiah',
    'Jonah',
    'Micah',
    'Nahum',
    'Habakkuk',
    'Zephaniah',
    'Haggai',
    'Zechariah',
    'Malachi',
    'Matthew',
    'Mark',
    'Luke',
    'John',
    'Acts',
    'Romans',
    '1 Corinthians',
    '2 Corinthians',
    'Galatians',
    'Ephesians',
    'Philippians',
    'Colossians',
    '1 Thessalonians',
    '2 Thessalonians',
    '1 Timothy',
    '2 Timothy',
    'Titus',
    'Philemon',
    'Hebrews',
    'James',
    '1 Peter',
    '2 Peter',
    '1 John',
    '2 John',
    '3 John',
    'Jude',
    'Revelation'
  ];
  final List<int> _bookChapterNumbers = [
    50,
    40,
    27,
    36,
    34,
    24,
    21,
    4,
    31,
    24,
    22,
    25,
    29,
    36,
    10,
    13,
    10,
    42,
    150,
    31,
    12,
    8,
    66,
    52,
    5,
    48,
    12,
    14,
    3,
    9,
    1,
    4,
    7,
    3,
    3,
    3,
    2,
    14,
    4,
    28,
    16,
    24,
    21,
    28,
    16,
    16,
    13,
    6,
    6,
    4,
    4,
    5,
    3,
    6,
    4,
    3,
    1,
    13,
    5,
    5,
    3,
    5,
    1,
    1,
    1,
    22,
  ];

  Map<String, List<String>> _chapters = {};

  void initState() {
    for (int i = 0; i < _books.length; i++) {
      _chapters[_books[i]] = List.generate(
          _bookChapterNumbers[i], (index) => (index + 1).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('The Bible',
            style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: _books.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(_books[index], style: TextStyle(fontSize: 19)),
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _chapters[_books[index]]?.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, chapterIndex) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedBook = _books[index];
                          _selectedChapter = int.parse(
                              _chapters[_books[index]]![chapterIndex]);
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            _chapters[_books[index]]![chapterIndex],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: BookChapter(
          apiLink:
              'https://bible-api.com/${_selectedBook} ${_selectedChapter}'),
    );
  }
}
