import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {
  final bool isDark;

  const ProfileStats({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Posts', '127', isDark),
        _buildStatItem('Followers', '2.5K', isDark),
        _buildStatItem('Following', '892', isDark),
        _buildStatItem('Watched', '1.2K', isDark),
      ],
    );
  }

  Widget _buildStatItem(String label, String count, bool isDark) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.grey[300] : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}