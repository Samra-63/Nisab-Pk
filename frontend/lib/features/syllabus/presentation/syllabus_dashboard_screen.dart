import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared_widgets/app_components.dart';

class SyllabusDashboardScreen extends StatelessWidget {
  const SyllabusDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chapters = [
      {
        'num': '12',
        'title': 'Electrostatics',
        'topics': 'Coulomb’s Law, Electric Flux, Gauss’s Law, Capacitors',
        'status': 'Done',
        'weight': '14 Marks',
      },
      {
        'num': '13',
        'title': 'Current Electricity',
        'topics': 'Ohm’s Law, Kirchhoff’s Rules, Potentiometer',
        'status': 'In Progress',
        'weight': '12 Marks',
      },
      {
        'num': '14',
        'title': 'Electromagnetism',
        'topics': 'Magnetic Force, Ampere’s Law, CRO, Torque on Coil',
        'status': 'Locked',
        'weight': '16 Marks',
      },
      {
        'num': '15',
        'title': 'Electromagnetic Induction',
        'topics': 'Faraday’s Law, Lenz’s Law, Transformers, AC Generator',
        'status': 'Locked',
        'weight': '14 Marks',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Physics Roadmap', style: AppTypography.screenHeading),
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
          // Header Milestone Summary
          AppBox(
            color: AppColors.surfaceMuted,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FBISE Class 12 • Physics (56 Marks Tracked)',
                        style: AppTypography.cardTitle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Board Exam Target: 85/85 marks',
                        style: AppTypography.body,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '2/10 Covered',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Curriculum Milestones', style: AppTypography.cardTitle),
          const SizedBox(height: 16),

          // Timeline Node Structure
          ...chapters.map((ch) {
            final isDone = ch['status'] == 'Done';
            final isInProg = ch['status'] == 'In Progress';
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline Column
                Column(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppColors.accentSage
                            : isInProg
                            ? AppColors.primary
                            : AppColors.surfaceMuted,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          isDone
                              ? LucideIcons.check
                              : isInProg
                              ? LucideIcons.play
                              : LucideIcons.lock,
                          size: 15,
                          color: isDone || isInProg
                              ? Colors.white
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 80,
                      color: AppColors.surfaceBorder,
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                // Milestone Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: AppBox(
                      color: isInProg
                          ? AppColors.surface
                          : AppColors.surface.withOpacity(0.85),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CHAPTER ${ch['num']}',
                                style: AppTypography.labelMicro.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                ch['weight']!,
                                style: AppTypography.labelMicro.copyWith(
                                  color: AppColors.accentAmber,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(ch['title']!, style: AppTypography.cardTitle),
                          const SizedBox(height: 4),
                          Text(
                            ch['topics']!,
                            style: AppTypography.body.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
