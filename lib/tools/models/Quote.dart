class Quote {
  final String quote;
  final String author;
  final String category;

  const Quote({
    required this.quote,
    required this.author,
    required this.category,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quote: json['quote'] as String? ?? 'No quote available',
      author: json['author'] as String? ?? "Unknown",
      category: json['category'] as String? ?? "General",
    );
  }
}
