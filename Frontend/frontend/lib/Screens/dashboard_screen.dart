import 'package:flutter/material.dart';
import 'package:frontend/widgets/search_screen.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/live_watch_parties.dart';
import '../widgets/feed_tabs.dart';
import '../widgets/feed_content.dart';
import '../widgets/bottom_navigation.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    if (index == 1) {
      // Navigate to search screen when explore icon is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    } else if (index == 3) {
      // Navigate to chat screen when chat icon is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatScreen()),
      );
    } else if (index == 4) {
      // Navigate to profile screen when profile icon is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2D1B69),
                    Color(0xFF0A0E1A),
                  ],
                  stops: [0.0, 0.4],
                )
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE8E3FF),
                    Color(0xFFF5F5F5),
                  ],
                  stops: [0.0, 0.4],
                ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const LiveWatchParties(),
                      const SizedBox(height: 30),
                      const FeedTabs(),
                      const SizedBox(height: 20),
                      const FeedContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}