class Photo {
  final String id;
  final String title;
  final String author;
  final String url;
  final String urlFull;

  Photo(
      {required this.id,
      required this.title,
      required this.author,
      required this.url,
      required this.urlFull});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['description'] ?? 'No description.',
      author: json['user']['name'],
      url: json['urls']['small'],
      urlFull: json['urls']['regular'],
    );
  }
}
