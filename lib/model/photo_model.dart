class Photo {
  final String coverImagePath;
  final String title;
  final String photoDetail;

  final List<String> contentImages;

  Photo({
    required this.coverImagePath,
    required this.title,
    required this.photoDetail,
    List<String>? contentImages,
  }) : contentImages = contentImages ?? [];
}
