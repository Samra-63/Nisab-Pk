import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared_widgets/app_components.dart';

class YearRepositoryScreen extends StatelessWidget {
  const YearRepositoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final papers = [
      {
        'year': '2023',
        'subject': 'Physics (FBISE)',
        'totalQ': '18 Solved Questions',
        'verified': true,
      },
      {
        'year': '2022',
        'subject': 'Chemistry (FBISE)',
        'totalQ': '15 Solved Questions',
        'verified': true,
      },
      {
        'year': '2023',
        'subject': 'Mathematics (FBISE)',
        'totalQ': '20 Solved Questions',
        'verified': true,
      },
      {
        'year': '2021',
        'subject': 'Computer Science',
        'totalQ': '14 Solved Questions',
        'verified': true,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Solved Board Papers', style: AppTypography.screenHeading),
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
          Text('Archived Examinations', style: AppTypography.cardTitle),
          const SizedBox(height: 4),
          Text(
            'Standard solved solutions matching official board rubrics.',
            style: AppTypography.body,
          ),
          const SizedBox(height: 16),
          ...papers.map((p) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: AppBox(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaperReaderView(
                        title: '${p['year']} ${p['subject']}',
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primarySubtle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        p['year'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p['subject'] as String,
                            style: AppTypography.cardTitle,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            p['totalQ'] as String,
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
            );
          }),
        ],
      ),
    );
  }
}

class PaperReaderView extends StatelessWidget {
  final String title;
  const PaperReaderView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title, style: AppTypography.cardTitle),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          AppBox(
            color: AppColors.surfaceDark,
            border: null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SECTION B • QUESTION 1',
                  style: AppTypography.labelMicro.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'State Ampere’s Law and write down its mathematical expression.',
                  style: AppTypography.cardTitle.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarySubtle,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Official Solution',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Ampere’s Law states that the sum of the quantities B · ΔL for all path elements around any closed path equals μ₀ times the total current enclosed by the path.\n\nMathematical Formula:\n∮ B · dl = μ₀ I\n\nWhere:\n• B = Magnetic field intensity\n• μ₀ = Permeability of free space\n• I = Enclosed electric current',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
