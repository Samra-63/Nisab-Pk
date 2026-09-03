import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared_widgets/app_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Student Profile', style: AppTypography.screenHeading),
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
          AppBox(
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primarySubtle,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      'H',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hammad Hassan',
                        style: AppTypography.cardTitle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'FBISE Federal Board • Class 12 Pre-Eng',
                        style: AppTypography.body.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primarySubtle,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '84% Readiness',
                              style: AppTypography.labelMicro.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '15 Badges',
                              style: AppTypography.labelMicro.copyWith(
                                color: const Color(0xFFB45309),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Preferences & Settings', style: AppTypography.cardTitle),
          const SizedBox(height: 12),
          _buildActionRow(
            LucideIcons.bookOpen,
            'Active Syllabus Mapping',
            'Federal Board 2026',
          ),
          _buildActionRow(
            LucideIcons.bookmark,
            'Saved Solved Papers',
            '6 Papers',
          ),
          _buildActionRow(
            LucideIcons.globe,
            'App Language',
            'English (Official)',
          ),
          _buildActionRow(
            LucideIcons.bell,
            'Exam Countdown Notifications',
            'Enabled',
          ),
          const SizedBox(height: 24),
          AppBox(
            color: AppColors.errorSoft,
            border: null,
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  LucideIcons.logOut,
                  color: AppColors.error,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Sign Out',
                  style: AppTypography.cardTitle.copyWith(
                    color: AppColors.error,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(IconData icon, String title, String meta) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppBox(
        onTap: () {},
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.primary),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            Text(
              meta,
              style: AppTypography.body.copyWith(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              LucideIcons.chevronRight,
              size: 14,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
