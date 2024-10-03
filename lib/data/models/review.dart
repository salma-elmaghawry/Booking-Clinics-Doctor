class ReviewModel {
  final String name, imageUrl, content;
  final double rating;

  const ReviewModel({
    required this.name,
    required this.imageUrl,
    required this.content,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
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