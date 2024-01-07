// ignore_for_file: non_constant_identifier_names

class Manna {
  final int id; //
  final int day; //
  final int month_number; //
  final String month_name;
  final String display_title;
  final String book;
  final int book_id; //
  final String chapter; //
  final String verse;
  final int verse_id; //
  final String verse_text;
  final String content;
  final String lang;
  final String category;
  final String category_name;
  final String herald;

  const Manna({
    required this.id,
    required this.day,
    required this.month_number,
    required this.month_name,
    required this.display_title,
    required this.book,
    required this.book_id,
    required this.chapter,
    required this.verse,
    required this.verse_id,
    required this.verse_text,
    required this.content,
    required this.lang,
    required this.category,
    required this.category_name,
    required this.herald,
  });

  // Convert a Manna into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': day,
      'month_number': month_number,
      'month_name': month_name,
      'display_title': display_title,
      'book': book,
      'book_id': book_id,
      'chapter': chapter,
      'verse': verse,
      'verse_id': verse_id,
      'verse_text': verse_text,
      'content': content,
      'lang': lang,
      'category': category,
      'category_name': category_name,
      'herald': herald,
    };
  }

  // Implement toString to make it easier to see information about
  // each Manna when using the print statement.
  @override
  String toString() {
    return 'Manna{id: $id, day: $day, month_number: $month_number, month_name: $month_name, display_title: $display_title, '
        'book: $book, book_id: $book_id, chapter: $chapter, verse: $verse, verse_id: $verse_id, verse_text: $verse_text, '
        'content: $content, lang: $lang, category: $category, category_name: $category_name'
        'herald: $herald}';
  }
}
