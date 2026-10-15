class Article {
  final String sourceName;
  final String title;
  final String? urlToImage;
  final String? description;

  const Article({
    required this.sourceName,
    required this.title,
    this.urlToImage,
    this.description,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final source = json['source'] as Map<String, dynamic>?;

    return Article(
      sourceName: (source?['name'] as String?) ?? 'Fuente desconocida',
      title: (json['title'] as String?) ?? 'Sin título',
      urlToImage: json['urlToImage'] as String?,
      description: json['description'] as String?,
    );
  }
}