import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared_widgets/app_components.dart';
import '../models/syllabus_models.dart';

class ChapterDetailScreen extends StatelessWidget {
  final Subject subject;
  const ChapterDetailScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final int overallPct = (subject.overallProgress * 100).toInt();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '${subject.name} Breakdown',
          style: AppTypography.screenHeading,
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.surfaceBorder, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Progress Summary Card
          AppBox(
            color: AppColors.surfaceDark,
            border: null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'COURSE COMPLETION',
                      style: AppTypography.labelMicro.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    Text(
                      '$overallPct%',
                      style: AppTypography.cardTitle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: subject.overallProgress,
                    minHeight: 7,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$overallPct% Completed',
                      style: AppTypography.body.copyWith(
                        color: AppColors.accentSage,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${100 - overallPct}% Remaining',
                      style: AppTypography.body.copyWith(
                        color: AppColors.accentAmber,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Chapters & Topics', style: AppTypography.cardTitle),
          const SizedBox(height: 12),
          ...subject.chapters.map((ch) => _buildChapterTile(ch)),
        ],
      ),
    );
  }

  Widget _buildChapterTile(Chapter ch) {
    final bool isDone = ch.progressPercentage >= 1.0;
    final bool isInProg =
        ch.progressPercentage > 0.0 && ch.progressPercentage < 1.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppBox(
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isDone
                    ? AppColors.accentSage.withOpacity(0.12)
                    : isInProg
                    ? AppColors.primarySubtle
                    : AppColors.surfaceMuted,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isDone
                      ? LucideIcons.check
                      : isInProg
                      ? LucideIcons.clock
                      : LucideIcons.lock,
                  size: 16,
                  color: isDone
                      ? AppColors.accentSage
                      : isInProg
                      ? AppColors.primary
                      : AppColors.textMuted,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chapter ${ch.chapterNumber}: ${ch.title}',
                    style: AppTypography.cardTitle.copyWith(fontSize: 14.5),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isDone
                        ? 'Completed (100%)'
                        : isInProg
                        ? 'In Progress (${(ch.progressPercentage * 100).toInt()}% Covered)'
                        : 'Pending (0%)',
                    style: AppTypography.body.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
