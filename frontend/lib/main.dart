import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'core/theme/app_colors.dart';
import 'features/auth/presentation/splash_screen.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/past_papers/presentation/year_repository_screen.dart';
import 'features/analytics/presentation/analytics_dashboard_screen.dart';
import 'features/profile/presentation/profile_screen.dart';
// Agar flutterfire configure run kar chuki hain to is file ko uncomment kar sakti hain:
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Agar firebase_options.dart generate ho chuki hai:
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        // Jab user state verify ho rahi ho ya pehli dafa app khul rahi ho
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        // Agar user logged in hai to direct Dashboard Shell
        if (snapshot.hasData) {
          return const MainNavigationShell();
        }
        // Agar user logged in nahi hai to Splash Screen -> Login
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

  final List<Widget> _screens = const [
    DashboardScreen(),
    YearRepositoryScreen(),
    AnalyticsDashboardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.surfaceBorder, width: 1),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavButton(0, LucideIcons.layoutGrid, 'Dashboard'),
              _buildNavButton(1, LucideIcons.archive, 'Repository'),
              _buildNavButton(2, LucideIcons.trendingUp, 'Analytics'),
              _buildNavButton(3, LucideIcons.user, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySubtle : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 19,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
