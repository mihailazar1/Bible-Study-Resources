import "package:bible_study_resources/models/book_database.dart";
import "package:bible_study_resources/models/the_book.dart";
import "package:flutter/material.dart";

class TheBookPage extends StatefulWidget {
  TheBookPage({super.key});

  @override
  State<TheBookPage> createState() => _TheBookState();
}

class _TheBookState extends State<TheBookPage> {
  final dbHelper = BookDatabaseHelper();

  late Future<List<TheBook>> book;

  @override
  void initState() {
    super.initState();
  }

  Future<List<TheBook>> getContents() {
    book = dbHelper.getALLVersesOfABook(1);
    return book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Contents'),
      ),
      body: FutureBuilder<List<TheBook>>(
        future: getContents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final TheBook currentBook = snapshot.data![index];
                return ListTile(
                  title: Text(currentBook.t),
                  subtitle: Text(
                      'Book: ${currentBook.b}, Chapter: ${currentBook.c}, Verse: ${currentBook.v}'),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
