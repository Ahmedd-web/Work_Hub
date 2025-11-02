class JobPost {
  const JobPost({
    required this.title,
    required this.companyLabel,
    required this.postedAt,
    required this.location,
    this.isFeatured = false,
  });

  final String title;
  final String companyLabel;
  final String postedAt;
  final String location;
  final bool isFeatured;
}
