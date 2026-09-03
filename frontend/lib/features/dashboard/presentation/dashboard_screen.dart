import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared_widgets/app_components.dart';
import '../../syllabus/presentation/board_selection_screen.dart';
import '../../syllabus/presentation/syllabus_dashboard_screen.dart';
import '../../doc_ai/presentation/doc_chat_screen.dart';
import '../../voice_examiner/presentation/voice_examiner_screen.dart';
import '../../past_papers/presentation/year_repository_screen.dart';
import '../../analytics/presentation/analytics_dashboard_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Top Bar: Identity & Board Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nisab PK', style: AppTypography.brandTitle),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.accentSage,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'FBISE • Class 12 Pre-Eng',
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BoardSelectionScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.surfaceBorder),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          LucideIcons.slidersHorizontal,
                          size: 14,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Change Board',
                          style: AppTypography.cardTitle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Hero Target Card
            AppBox(
              color: AppColors.surfaceDark,
              border: null,
              padding: const EdgeInsets.all(20),
              radius: 20,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SyllabusDashboardScreen(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CURRENT FOCUS',
                        style: AppTypography.labelMicro.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '75% Complete',
                          style: AppTypography.labelMicro.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Physics: Electrostatics & Fields',
                    style: AppTypography.cardTitle.copyWith(
                      color: AppColors.textWhite,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Chapter 12 • 2 subtopics remaining before revision mock',
                    style: AppTypography.body.copyWith(
                      color: const Color(0xFF9EABA8),
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              LucideIcons.play,
                              size: 13,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Resume',
                              style: AppTypography.cardTitle.copyWith(
                                color: Colors.white,
                                fontSize: 12.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AnalyticsDashboardScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'View Syllabus Matrix →',
                          style: TextStyle(
                            color: AppColors.primarySubtle,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2x2 Feature Suites
            Text(
              'Study Suites',
              style: AppTypography.cardTitle.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: AppBox(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SyllabusDashboardScreen(),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primarySubtle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            LucideIcons.layers,
                            size: 20,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text('Syllabus Engine', style: AppTypography.cardTitle),
                        const SizedBox(height: 4),
                        Text(
                          'Chapter tracker with official board weightage.',
                          style: AppTypography.body.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppBox(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const YearRepositoryScreen(),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF7ED),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            LucideIcons.archive,
                            size: 20,
                            color: AppColors.accentAmber,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text('Solved Papers', style: AppTypography.cardTitle),
                        const SizedBox(height: 4),
                        Text(
                          'Annual archives with detailed step solutions.',
                          style: AppTypography.body.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: AppBox(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DocChatScreen()),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            LucideIcons.fileSearch,
                            size: 20,
                            color: AppColors.accentBlue,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Doc AI Assistant',
                          style: AppTypography.cardTitle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Instant conceptual answers from your books.',
                          style: AppTypography.body.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppBox(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VoiceExaminerScreen(),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            LucideIcons.mic,
                            size: 20,
                            color: AppColors.accentSage,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text('Oral Examiner', style: AppTypography.cardTitle),
                        const SizedBox(height: 4),
                        Text(
                          'Voice viva with real-time scoring rubric.',
                          style: AppTypography.body.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Performance Bar
            AppBox(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AnalyticsDashboardScreen(),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  const Icon(
                    LucideIcons.trendingUp,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overall Board Readiness',
                          style: AppTypography.cardTitle.copyWith(
                            fontSize: 13.5,
                          ),
                        ),
                        Text(
                          '84% average across Physics, Chem & Math',
                          style: AppTypography.body.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    LucideIcons.arrowRight,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
