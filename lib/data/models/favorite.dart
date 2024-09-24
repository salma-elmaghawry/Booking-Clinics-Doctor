class Favorite {
  final String docName, docAddress, docSpeciality, docImageUrl;
  final double rating;
  final int reviewsNumber;
  final bool isFavorite;

  const Favorite({
    required this.docName,
    required this.docAddress,
    required this.docSpeciality,
    required this.docImageUrl,
    required this.rating,
    required this.reviewsNumber,
    required this.isFavorite,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      docName: json['docName'],
      docAddress: json['docAddress'],
      docSpeciality: json['docSpeciality'],
      docImageUrl: json['docImageUrl'],
      rating: json['rating'],
      reviewsNumber: json['reviewsNumber'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docName': docName,
      'docAddress': docAddress,
      'docSpeciality': docSpeciality,
      'docImageUrl': docImageUrl,
      'rating': rating,
      'reviewsNumber': reviewsNumber,
      'isFavorite': isFavorite,
    };
  }
}
