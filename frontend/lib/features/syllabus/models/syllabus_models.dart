class Board {
  final String id;
  final String name; // e.g., FBISE, BISE Rawalpindi, BISE Lahore
  final String province;

  Board({required this.id, required this.name, required this.province});
}

class Chapter {
  final String id;
  final String title;
  final int chapterNumber;
  final double progressPercentage; // 0.0 to 1.0
  final bool isCompleted;

  Chapter({
    required this.id,
    required this.title,
    required this.chapterNumber,
    required this.progressPercentage,
    required this.isCompleted,
  });
}

class Subject {
  final String id;
  final String name;
  final int totalChapters;
  final List<Chapter> chapters;

  Subject({
    required this.id,
    required this.name,
    required this.totalChapters,
    required this.chapters,
  });

  double get overallProgress {
    if (chapters.isEmpty) return 0.0;
    final double total = chapters.fold(
      0.0,
      (sum, item) => sum + item.progressPercentage,
    );
    return total / chapters.length;
  }
}
