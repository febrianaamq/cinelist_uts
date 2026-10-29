class Show {
  final int id;
  final String name;
  final String? imageUrl;
  final List<String> genres;
  final String? premiered;
  final double rating;
  final String? summary;
  final String? status;

  const Show({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.genres,
    required this.premiered,
    required this.rating,
    required this.status,
    required this.summary,
});

  factory Show.fromJson(Map<String, dynamic>json) {
    final image = json['image'] as Map<String, dynamic>?;
    final ratingData = json['rating'] as Map<String, dynamic>?;
    return Show(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Tanpa Judul',
      imageUrl: image?['medium'] as String?,
      genres: (json['genres'] as List<dynamic>? ?? []).map((genre) => genre.toString()).toList(),
      premiered: json['premiered'] as String?,
      rating: (ratingData?['average'] as num?)?.toDouble() ?? 0.0,
      summary: json['summary'] as String?,
      status: json['status'] as String,
    );
  }
}