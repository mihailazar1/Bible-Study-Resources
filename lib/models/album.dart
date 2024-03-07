class Album {
  final String Subfolder;
  final String Audio;
  final String Link;
  final String ShortLink;
  final String Time;

  Album({
    required this.Subfolder,
    required this.Audio,
    required this.Link,
    required this.ShortLink,
    required this.Time,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'Audio': String Audio,
        'Link': String Link,
        'ShortLink': String ShortLink,
        'Subfolder': String Subfolder,
        'Time': String Time,
      } =>
        Album(
          Audio: Audio,
          Link: Link,
          ShortLink: ShortLink,
          Subfolder: Subfolder,
          Time: Time,
        ),
      _ => throw const FormatException('Filed to load album.'),
    };
  }
}
