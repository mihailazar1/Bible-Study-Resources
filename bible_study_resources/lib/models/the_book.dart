// ignore_for_file: non_constant_identifier_names

class TheBook {
  final int id;
  final int b; // book number
  final int c; // chapter number
  final int v; // verse number
  final String t; // content

  const TheBook({
    required this.id,
    required this.b,
    required this.c,
    required this.v,
    required this.t,
  });

  // Convert a verse into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'b': b,
      'c': c,
      'v': v,
      't': t,
    };
  }

  // Implement toString to make it easier to see information about
  // each Manna when using the print statement.
  @override
  String toString() {
    return 'Book{id: $id, book: $b, chapter: $c, verse: $v, text: $t';
  }
}
