import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared_widgets/app_components.dart';

class DocChatScreen extends StatefulWidget {
  const DocChatScreen({super.key});

  @override
  State<DocChatScreen> createState() => _DocChatScreenState();
}

class _DocChatScreenState extends State<DocChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'role': 'ai',
      'text':
          'Salam Hammad! I’ve indexed your Physics Chapter 12 PDF. Ask any conceptual question, definition, or mathematical derivation.',
    },
  ];

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text;
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _controller.clear();
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _messages.add({
          'role': 'ai',
          'text':
              'Based on Page 14 of your book:\n\nGauss’s Law states that the total electric flux out of a closed surface is equal to the charge enclosed divided by permittivity:\n\nΦ = Q / ε₀\n\nIt is used to calculate electric field intensity for symmetric charge distributions.',
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Doc AI Studio',
              style: AppTypography.screenHeading.copyWith(fontSize: 16),
            ),
            Text(
              'Physics_Book_FBISE_12.pdf',
              style: AppTypography.body.copyWith(fontSize: 11),
            ),
          ],
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.surfaceBorder, height: 1),
        ),
      ),
      body: Column(
        children: [
          // Contextual Chip Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.surfaceMuted,
            child: Row(
              children: [
                const Icon(
                  LucideIcons.fileCheck,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Indexed: 14 Pages • Embeddings Ready',
                    style: AppTypography.body.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          // Chat Stream
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUser = _messages[index]['role'] == 'user';
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: isUser
                          ? null
                          : Border.all(color: AppColors.surfaceBorder),
                    ),
                    child: Text(
                      _messages[index]['text']!,
                      style: AppTypography.body.copyWith(
                        color: isUser ? Colors.white : AppColors.textPrimary,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Floating Composer Bar
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.surfaceBorder)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Ask anything from the document...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _send,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        LucideIcons.send,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
