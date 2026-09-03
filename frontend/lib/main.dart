import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'core/theme/app_colors.dart';
import 'features/auth/presentation/splash_screen.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/past_papers/presentation/year_repository_screen.dart';
import 'features/doc_ai/presentation/doc_chat_screen.dart';
import 'features/analytics/presentation/analytics_dashboard_screen.dart';
import 'features/profile/presentation/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init note: $e");
  }
  runApp(const NisabPkApp());
}

class NisabPkApp extends StatelessWidget {
  const NisabPkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nisab PK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.surface,
        ),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        if (snapshot.hasData) {
          return const MainNavigationShell();
        }
        return const SplashScreen();
      },
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  // 5 screens: Home, Past Papers, AI Tutor (Center), Analytics, Profile
  final List<Widget> _screens = const [
    DashboardScreen(),
    YearRepositoryScreen(),
    DocChatScreen(),
    AnalyticsDashboardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
          child: Container(
            height: 62,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryDark.withOpacity(0.28),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFigmaDockButton(0, LucideIcons.home),
                _buildFigmaDockButton(1, LucideIcons.layoutGrid),
                _buildFigmaDockButton(
                  2,
                  LucideIcons.bot,
                ), // Center AI Tutor Tab
                _buildFigmaDockButton(3, LucideIcons.barChart2),
                _buildFigmaDockButton(4, LucideIcons.user),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFigmaDockButton(int index, IconData icon) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.20)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 21,
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.55),
          ),
        ),
      ),
    );
  }
}
