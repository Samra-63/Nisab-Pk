import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../doc_ai/presentation/doc_chat_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brandPrimary = Color(0xFF0F766E);
    const Color brandDark = Color(0xFF115E59);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            top: 16,
            bottom: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Header (Greeting + Board Badge)
              _buildTopHeader(brandPrimary),
              const SizedBox(height: 20),

              // 2. Hero Card: AI Textbook Tutor Banner (Direct Link to Chat)
              _buildAiHeroBanner(context, brandPrimary, brandDark),
              const SizedBox(height: 22),

              // 3. Quick Stats / Daily Streak
              _buildStudyStatsRow(),
              const SizedBox(height: 24),

              // 4. Section Title: Your Subjects
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Subjects (Class 9)",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    "Federal Board",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: brandPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 5. Grid of Subjects
              _buildSubjectsGrid(context, brandPrimary),
              const SizedBox(height: 24),

              // 6. Quick Action Prompts
              _buildSuggestedPrompts(context, brandPrimary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader(Color brandPrimary) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assalam-o-Alaikum! 👋",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "Welcome to Nisab PK",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2FE),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFBAE6FD)),
          ),
          child: Row(
            children: [
              const Icon(LucideIcons.award, size: 15, color: Color(0xFF0284C7)),
              const SizedBox(width: 5),
              Text(
                "FBISE 2026",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0369A1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAiHeroBanner(BuildContext context, Color primary, Color dark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, dark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.35),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.sparkles,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Grounded AI Academic Tutor",
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Stuck on a concept?\nAsk your official textbook.",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DocChatScreen(
                    initialBoard: "Federal",
                    initialGrade: 9,
                    initialSubject: "islamiat",
                  ),
                ),
              );
            },
            icon: const Icon(
              LucideIcons.messageSquare,
              size: 16,
              color: Color(0xFF0F766E),
            ),
            label: Text(
              "Start Asking AI Tutor",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: const Color(0xFF0F766E),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            icon: LucideIcons.flame,
            iconColor: const Color(0xFFEA580C),
            bgColor: const Color(0xFFFFF7ED),
            title: "5 Days",
            subtitle: "Study Streak",
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatItem(
            icon: LucideIcons.bookOpen,
            iconColor: const Color(0xFF2563EB),
            bgColor: const Color(0xFFEFF6FF),
            title: "2 Books",
            subtitle: "Indexed Ready",
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatItem(
            icon: LucideIcons.checkCircle2,
            iconColor: const Color(0xFF16A34A),
            bgColor: const Color(0xFFF0FDF4),
            title: "100%",
            subtitle: "Verified SLOs",
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsGrid(BuildContext context, Color brandPrimary) {
    final List<Map<String, dynamic>> subjects = [
      {
        "name": "Islamiat",
        "code": "islamiat",
        "icon": LucideIcons.moon,
        "color": const Color(0xFF0F766E),
        "status": "Ready",
      },
      {
        "name": "English",
        "code": "english",
        "icon": LucideIcons.bookMarked,
        "color": const Color(0xFF2563EB),
        "status": "Ready",
      },
      {
        "name": "Biology",
        "code": "biology",
        "icon": LucideIcons.dna,
        "color": const Color(0xFF16A34A),
        "status": "Coming Soon",
      },
      {
        "name": "Physics",
        "code": "physics",
        "icon": LucideIcons.atom,
        "color": const Color(0xFF9333EA),
        "status": "Coming Soon",
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.35,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final item = subjects[index];
        final bool isReady = item["status"] == "Ready";

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DocChatScreen(
                  initialBoard: "Federal",
                  initialGrade: 9,
                  initialSubject: item["code"],
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isReady
                    ? (item["color"] as Color).withOpacity(0.3)
                    : Colors.grey.shade200,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (item["color"] as Color).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        item["icon"] as IconData,
                        color: item["color"] as Color,
                        size: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isReady
                            ? const Color(0xFFF0FDF4)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item["status"],
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: isReady
                              ? const Color(0xFF16A34A)
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["name"],
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      "Class 9 • Textbook",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuggestedPrompts(BuildContext context, Color brandPrimary) {
    final List<Map<String, String>> prompts = [
      {
        "subject": "islamiat",
        "text": "قرآن مجید کے فضائل اور حقوق پر نوٹ لکھیں۔",
      },
      {
        "subject": "english",
        "text": "What is the theme of Chapter 1 in English?",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Suggested AI Questions",
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 10),
        ...prompts.map(
          (p) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 2,
              ),
              leading: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFE0F2FE),
                child: Icon(
                  LucideIcons.helpCircle,
                  size: 17,
                  color: Color(0xFF0284C7),
                ),
              ),
              title: Text(
                p["text"]!,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(
                LucideIcons.arrowRight,
                size: 16,
                color: Colors.black45,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocChatScreen(
                      initialBoard: "Federal",
                      initialGrade: 9,
                      initialSubject: p["subject"],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
