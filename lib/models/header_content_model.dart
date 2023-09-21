class HeaderContent {
  final String title;
  final String imageUrl;
  final String? description;
  final String? url;
  final String posterUrl;

  HeaderContent({
    required this.title,
    required this.imageUrl,
    this.description,
    this.url,
    required this.posterUrl,
  });
}
