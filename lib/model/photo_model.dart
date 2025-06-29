class Photo {
  final String coverImagePath;
  final String title;
  final String targetRoute;
  final List<String> contentImages;

  Photo({
    required this.coverImagePath,
    required this.title,
    required this.targetRoute,
    List<String>? contentImages,
  }) : contentImages = contentImages ?? [];
}
