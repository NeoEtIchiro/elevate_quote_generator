class Quote {
  final int? id;
  final String contentEn;
  final String contentFr;
  final String author;

  Quote({
    this.id,
    required this.contentEn,
    required this.contentFr,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content_en': contentEn,
      'content_fr': contentFr,
      'author': author,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'],
      contentEn: map['content_en'],
      contentFr: map['content_fr'],
      author: map['author'],
    );
  }
}