import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/chat_message_model.dart';
import '../../../services/tutor_api_service.dart';

class DocChatScreen extends StatefulWidget {
  final String? initialSubject;
  final int? initialGrade;
  final String? initialBoard;

  const DocChatScreen({
    super.key,
    this.initialSubject,
    this.initialGrade,
    this.initialBoard,
  });

  @override
  State<DocChatScreen> createState() => _DocChatScreenState();
}

class _DocChatScreenState extends State<DocChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late String _selectedBoard;
  late int _selectedGrade;
  late String _selectedSubject;

  final List<String> _boards = ["Federal", "Rawalpindi", "Punjab"];
  final List<int> _grades = [9, 10, 11, 12];
  final List<String> _subjects = [
    "islamiat",
    "english",
    "biology",
    "physics",
    "chemistry",
  ];

  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "السلام علیکم! میں نصاب پی کے کا باضابطہ AI درسی اتالیق ہوں۔ اپنی درسی کتاب سے کوئی بھی سوال پوچھیں۔",
      isUser: false,
    ),
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedBoard = widget.initialBoard ?? "Federal";
    _selectedGrade = widget.initialGrade ?? 9;
    _selectedSubject = widget.initialSubject ?? "islamiat";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isLoading) return;

    _messageController.clear();
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });
    _scrollToBottom();

    final result = await TutorApiService.askTutor(
      query: text,
      board: _selectedBoard,
      grade: _selectedGrade,
      subject: _selectedSubject,
    );

    setState(() {
      _isLoading = false;
      if (result["success"] == true) {
        _messages.add(
          ChatMessage(
            text: result["answer"],
            isUser: false,
            citations: result["citations"],
            subject: result["subject"],
          ),
        );
      } else {
        _messages.add(
          ChatMessage(
            text: "⚠️ **مسئلہ پیش آیا:**\n${result['error']}",
            isUser: false,
          ),
        );
      }
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    const Color brandPrimary = Color(0xFF0F766E);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: brandPrimary,
        title: Row(
          children: [
            const Icon(
              LucideIcons.graduationCap,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              "Nisab PK Tutor",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Row(
              children: [
                // Board Selector
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: _selectedBoard,
                    decoration: _dropdownDecoration("Board"),
                    items: _boards
                        .map(
                          (b) => DropdownMenuItem(
                            value: b,
                            child: Text(
                              b,
                              style: const TextStyle(fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedBoard = v!),
                  ),
                ),
                const SizedBox(width: 4),
                // Grade Selector
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<int>(
                    isExpanded: true,
                    value: _selectedGrade,
                    decoration: _dropdownDecoration("Class"),
                    items: _grades
                        .map(
                          (g) => DropdownMenuItem(
                            value: g,
                            child: Text(
                              "$g",
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedGrade = v!),
                  ),
                ),
                const SizedBox(width: 4),
                // Subject Selector
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: _selectedSubject,
                    decoration: _dropdownDecoration("Subject"),
                    items: _subjects
                        .map(
                          (s) => DropdownMenuItem(
                            value: s,
                            child: Text(
                              s.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedSubject = v!),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(14),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildChatBubble(message, brandPrimary);
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: brandPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "$_selectedBoard Class $_selectedGrade ${_selectedSubject.toUpperCase()} بک اسکین ہو رہی ہے...",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          _buildInputBar(brandPrimary),
        ],
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 10),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildChatBubble(ChatMessage message, Color brandColor) {
    final isUrdu = RegExp(r'[\u0600-\u06FF]').hasMatch(message.text);

    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.84,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? brandColor : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isUser ? 16 : 4),
            bottomRight: Radius.circular(message.isUser ? 4 : 16),
          ),
          border: message.isUser
              ? null
              : Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: isUrdu
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            MarkdownBody(
              data: message.text,
              selectable: true,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  color: message.isUser
                      ? Colors.white
                      : const Color(0xFF1E293B),
                  fontSize: 14.5,
                  height: 1.5,
                  fontFamily: isUrdu
                      ? GoogleFonts.notoNastaliqUrdu().fontFamily
                      : null,
                ),
                strong: TextStyle(
                  color: message.isUser ? Colors.white : brandColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (!message.isUser && message.citations.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    LucideIcons.bookOpen,
                    size: 14,
                    color: Color(0xFF0284C7),
                  ),
                  ...message.citations.map(
                    (p) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2FE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Page $p",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0369A1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar(Color brandColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: "سوال یا کوئری لکھیں...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 13.5,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _sendMessage,
              child: CircleAvatar(
                backgroundColor: brandColor,
                radius: 21,
                child: const Icon(
                  LucideIcons.send,
                  color: Colors.white,
                  size: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
