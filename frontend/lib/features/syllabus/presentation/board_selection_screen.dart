import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared_widgets/app_components.dart';
import 'subject_catalog_screen.dart';

class BoardSelectionScreen extends StatefulWidget {
  const BoardSelectionScreen({super.key});

  @override
  State<BoardSelectionScreen> createState() => _BoardSelectionScreenState();
}

class _BoardSelectionScreenState extends State<BoardSelectionScreen> {
  String? _selectedBoard;
  String? _selectedClass;
  String? _selectedGroup;

  final List<String> _boards = [
    'Federal Board (FBISE)',
    'BISE Rawalpindi',
    'BISE Lahore',
    'BISE Gujranwala',
    'BISE Sahiwal',
    'Sindh Board (BIEK)',
    'KPK Board (BISE Peshawar)',
  ];

  final List<String> _classes = [
    'Class 9 (Matric Part 1)',
    'Class 10 (Matric Part 2)',
    'Class 11 (FSc Part 1)',
    'Class 12 (FSc Part 2)',
  ];

  final List<String> _groups = [
    'Pre-Engineering',
    'Pre-Medical',
    'ICS (Computer Science)',
    'General Science',
    'Arts & Humanities',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isReady =
        _selectedBoard != null &&
        _selectedClass != null &&
        _selectedGroup != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Academic Setup', style: AppTypography.screenHeading),
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
          Text(
            'Select Your Academic Track',
            style: AppTypography.cardTitle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            'Nisab PK filters official curriculum, past papers, and oral rubrics based on your board.',
            style: AppTypography.body,
          ),
          const SizedBox(height: 24),

          _buildDropdown(
            label: 'EXAMINATION BOARD',
            hint: 'Choose your board',
            value: _selectedBoard,
            items: _boards,
            icon: LucideIcons.building,
            onChanged: (val) => setState(() => _selectedBoard = val),
          ),
          const SizedBox(height: 16),

          _buildDropdown(
            label: 'GRADE / CLASS',
            hint: 'Choose class level',
            value: _selectedClass,
            items: _classes,
            icon: LucideIcons.graduationCap,
            onChanged: (val) => setState(() => _selectedClass = val),
          ),
          const SizedBox(height: 16),

          _buildDropdown(
            label: 'ACADEMIC GROUP',
            hint: 'Select discipline',
            value: _selectedGroup,
            items: _groups,
            icon: LucideIcons.bookOpen,
            onChanged: (val) => setState(() => _selectedGroup = val),
          ),
          const SizedBox(height: 32),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isReady
                  ? AppColors.primary
                  : AppColors.surfaceBorder,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            onPressed: isReady
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SubjectCatalogScreen(
                          board: _selectedBoard!,
                          grade: _selectedClass!,
                          group: _selectedGroup!,
                        ),
                      ),
                    );
                  }
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue to Catalog',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: isReady ? Colors.white : AppColors.textMuted,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  LucideIcons.arrowRight,
                  size: 16,
                  color: isReady ? Colors.white : AppColors.textMuted,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelMicro.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Row(
                children: [
                  Icon(icon, size: 18, color: AppColors.textMuted),
                  const SizedBox(width: 10),
                  Text(hint, style: AppTypography.body),
                ],
              ),
              isExpanded: true,
              icon: const Icon(
                LucideIcons.chevronDown,
                size: 18,
                color: AppColors.textPrimary,
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(icon, size: 16, color: AppColors.primary),
                      const SizedBox(width: 10),
                      Text(
                        item,
                        style: AppTypography.body.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
