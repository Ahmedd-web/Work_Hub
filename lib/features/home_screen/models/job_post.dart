class JobPost {
  const JobPost({
    required this.id,
    required this.title,
    required this.companyLabel,
    required this.postedAt,
    required this.location,
    this.isFeatured = false,
    this.ownerId = '',
    this.salary,
    this.experience,
    this.department,
    this.educationLevel,
    this.nationality,
    this.city,
    this.deadline,
    this.description,
    this.companySummary,
    required this.postedDaysAgo,
    required this.categoryId,
  });

  final String id;
  final String title;
  final String companyLabel;
  final String postedAt;
  final String location;
  final bool isFeatured;
  final String ownerId;
  final int postedDaysAgo;
  final String categoryId;

  final String? salary;
  final String? experience;
  final String? department;
  final String? educationLevel;
  final String? nationality;
  final String? city;
  final String? deadline;
  final String? description;
  final String? companySummary;
}
