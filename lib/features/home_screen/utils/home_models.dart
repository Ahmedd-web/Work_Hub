// Shared lightweight models for the job-seeker home page.

class CategoryItem {
  const CategoryItem({required this.id, required this.title});

  final String id;
  final String title;
}

enum JobTimeFilter { last24h, last7d, last30d, anytime }
