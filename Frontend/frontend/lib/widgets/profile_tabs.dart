import 'package:flutter/material.dart';

class ProfileTabs extends StatelessWidget {
  final TabController tabController;
  final bool isDark;

  const ProfileTabs({
    super.key,
    required this.tabController,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: (isDark ? Colors.white : Colors.black87).withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.purple,
        indicatorWeight: 3,
        labelColor: Colors.purple,
        unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
        tabs: const [
          Tab(
            icon: Icon(Icons.grid_on, size: 24),
            text: 'Posts',
          ),
          Tab(
            icon: Icon(Icons.bookmark_border, size: 24),
            text: 'Saved',
          ),
        ],
      ),
    );
  }
}