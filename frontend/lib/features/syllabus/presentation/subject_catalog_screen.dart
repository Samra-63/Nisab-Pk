import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared_widgets/app_components.dart';
import 'syllabus_dashboard_screen.dart';

class SubjectCatalogScreen extends StatelessWidget {
  final String board;
  final String grade;
  final String group;

  const SubjectCatalogScreen({
    super.key,
    required this.board,
    required this.grade,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> subjectCards = [
      {'name': 'Physics', 'icon': LucideIcons.atom, 'desc': 'Mechanics, Electromagnetism & Modern Physics', 'chapters': '10 Chapters'},
      {'name': 'Chemistry', 'icon': LucideIcons.flaskConical, 'desc': 'Inorganic, Organic & Analytical Chemistry', 'chapters': '12 Chapters'},
      {'name': 'Mathematics', 'icon': LucideIcons.binary, 'desc': 'Calculus, Analytic Geometry & Vectors', 'chapters': '7 Chapters'},
      {'name': 'Computer Science', 'icon': LucideIcons.laptop, 'desc': 'Databases, C Programming & Networking', 'chapters': '8 Chapters'},
      {'name': 'English Compulsory', 'icon': LucideIcons.book, 'desc': 'Prose, Poetry, Grammar & Composition', 'chapters': '14 Units'},
      {'name': 'Pakistan Studies', 'icon': LucideIcons.landmark, 'desc': 'History, Geography & Constitutional Development', 'chapters': '6 Chapters'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Curriculum Catalog', style: AppTypography.screenHeading),
        backgroundColor: AppColors.surface,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.surfaceBorder, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          AppBox(
            color: AppColors.surfaceDark,
            border: null,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(LucideIcons.graduationCap, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(board, style: AppTypography.cardTitle.copyWith(color: Colors.white)),
                      Text('$grade • $group', style: AppTypography.body.copyWith(color: AppColors.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Available Subjects', style: AppTypography.cardTitle),
          const SizedBox(height: 12),
          ...subjectCards.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: AppBox(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SyllabusDashboardScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primarySubtle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(item['icon'] as IconData, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item['name'] as String, style: AppTypography.cardTitle),
                              Text(item['chapters'] as String, style: AppTypography.labelMicro.copyWith(color: AppColors.primary)),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(item['desc'] as String, style: AppTypography.body.copyWith(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}