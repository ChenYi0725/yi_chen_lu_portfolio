class Photo {
  final String coverImagePath;
  final String title;

  final List<String> contentImages;

  Photo({
    required this.coverImagePath,
    required this.title,
    List<String>? contentImages,
  }) : contentImages = contentImages ?? [];
}
