class ResumeProgram {
  final String programName;
  final List<String> directorsName;
  final String performanceVenues;
  // final String performanceAddress;
  final String performanceLocation;
  final String programLink;
  final bool isOutsideUrl;
  ResumeProgram({
    required this.programName,
    required this.directorsName,
    required this.performanceVenues,
    // required this.performanceAddress,
    required this.performanceLocation,
    required this.programLink,
    required this.isOutsideUrl,
  });
}

class ResumeItem {
  final String programName;
  final String directorName;
  final String performanceVenues;
  final String performanceLocation;
  final String programLink;
  ResumeItem({
    required this.programName,
    required this.directorName,
    required this.performanceVenues,
    required this.performanceLocation,
    required this.programLink,
  });
}
