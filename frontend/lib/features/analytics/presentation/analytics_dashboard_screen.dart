import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared_widgets/app_components.dart';

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Exam Readiness Matrix',
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
          Row(
            children: [
              Expanded(
                child: AppBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '84%',
                        style: AppTypography.brandTitle.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      Text('Readiness Index', style: AppTypography.labelMicro),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '32/45',
                        style: AppTypography.brandTitle.copyWith(
                          color: AppColors.accentAmber,
                        ),
                      ),
                      Text('Mastered Topics', style: AppTypography.labelMicro),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text('Subject Mastery Breakdown', style: AppTypography.cardTitle),
          const SizedBox(height: 12),
          _buildSubjectBar('Physics', 0.88, '88%'),
          _buildSubjectBar('Chemistry', 0.72, '72%'),
          _buildSubjectBar('Mathematics', 0.90, '90%'),
          _buildSubjectBar('Computer Science', 0.95, '95%'),
        ],
      ),
    );
  }

  Widget _buildSubjectBar(String subject, double val, String score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subject,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  score,
                  style: AppTypography.cardTitle.copyWith(
                    fontSize: 13,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: val,
                minHeight: 6,
                backgroundColor: AppColors.surfaceMuted,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
