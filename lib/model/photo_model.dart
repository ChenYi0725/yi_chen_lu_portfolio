class Photo {
  final String coverImagePath;
  final String title;
  final String description;

  final List<String> contentImages;

  Photo({
    required this.coverImagePath,
    required this.title,
    required this.description,
    List<String>? contentImages,
  }) : contentImages = contentImages ?? [];
}
