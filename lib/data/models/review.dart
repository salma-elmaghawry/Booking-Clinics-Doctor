class Review {
  final String name, imageUrl, content;
  final double rating;

  const Review({
    required this.name,
    required this.imageUrl,
    required this.content,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      name: json['name'],
      imageUrl: json['imageUrl'],
      content: json['content'],
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'content': content,
      'rating': rating,
    };
  }
}
