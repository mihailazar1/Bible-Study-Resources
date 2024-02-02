class BookAlbum {
  final String reference;
  final String text;

  BookAlbum({
    required this.reference,
    required this.text,
  });

  factory BookAlbum.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'reference': String reference,
        'rext': String text,
      } =>
        BookAlbum(
          reference: reference,
          text: text,
        ),
      _ => throw const FormatException('Filed to load album.'),
    };
  }
}
