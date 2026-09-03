import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared_widgets/app_components.dart';

class VoiceExaminerScreen extends StatefulWidget {
  const VoiceExaminerScreen({super.key});

  @override
  State<VoiceExaminerScreen> createState() => _VoiceExaminerScreenState();
}

class _VoiceExaminerScreenState extends State<VoiceExaminerScreen> {
  bool _isListening = false;
  bool _evaluated = false;

  @override
  Widget build(BuildContext context) {
    if (_evaluated) {
      return _buildScoreReport();
    }

    return Scaffold(
      backgroundColor: _isListening
          ? AppColors.surfaceDark
          : AppColors.background,
      appBar: AppBar(
        title: Text(
          'Oral Viva Examiner',
          style: AppTypography.screenHeading.copyWith(
            color: _isListening ? Colors.white : AppColors.textPrimary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: _isListening ? Colors.white : AppColors.textPrimary,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if (!_isListening) ...[
                AppBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BOARD VIVA QUESTION',
                        style: AppTypography.labelMicro.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Explain why two electric lines of force can never cross each other.',
                        style: AppTypography.cardTitle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Speak in English or Urdu clearly. AI will evaluate scientific explanation and terminology.',
                        style: AppTypography.body,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  'Tap the mic button to begin response',
                  style: AppTypography.body,
                ),
                const SizedBox(height: 20),
              ] else ...[
                const Spacer(),
                Text(
                  'Listening to your viva response...',
                  style: AppTypography.cardTitle.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    16,
                    (i) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2.5),
                      width: 4,
                      height: (i % 4 + 1) * 16.0,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
              GestureDetector(
                onTap: () {
                  if (_isListening) {
                    setState(() {
                      _isListening = false;
                      _evaluated = true;
                    });
                  } else {
                    setState(() => _isListening = true);
                  }
                },
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: _isListening ? AppColors.error : AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isListening ? LucideIcons.square : LucideIcons.mic,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreReport() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Evaluation Report', style: AppTypography.screenHeading),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 6),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '92%',
                      style: AppTypography.brandTitle.copyWith(
                        color: AppColors.primary,
                        fontSize: 24,
                      ),
                    ),
                    Text('Viva Score', style: AppTypography.labelMicro),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Rubric Marks Breakdown', style: AppTypography.cardTitle),
          const SizedBox(height: 12),
          _buildScoreBar('Concept Accuracy', 0.95, '9.5/10'),
          _buildScoreBar('Scientific Terminology', 0.90, '9.0/10'),
          _buildScoreBar('Articulation & Fluency', 0.90, '9.0/10'),
          const SizedBox(height: 20),
          AppBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Examiner Notes', style: AppTypography.cardTitle),
                const SizedBox(height: 6),
                Text(
                  'Excellent argument. You stated clearly that at the intersection point the electric field would have two different directions, which is physically impossible.',
                  style: AppTypography.body,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => setState(() => _evaluated = false),
            child: const Text('Next Question'),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBar(String label, double val, String score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppBox(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
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
            const SizedBox(height: 6),
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
