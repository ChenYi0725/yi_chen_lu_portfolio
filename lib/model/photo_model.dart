class Photo {
  final String coverImagePath;
  final String title;
  final String description;

  final List<String> contentImages;

  final String? url;

  Photo({
    required this.coverImagePath,
    required this.title,
    required this.description,
    List<String>? contentImages,
    this.url,
  }) : contentImages = contentImages ?? [];
}
