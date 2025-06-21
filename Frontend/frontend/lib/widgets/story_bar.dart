import 'package:flutter/material.dart';

class StoryBar extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  const StoryBar({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    final usersWithStories = users.where((user) => user['hasStory'] == true).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Stories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: usersWithStories.length + 1, // +1 for "Your Story"
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildYourStory();
              }
              
              final user = usersWithStories[index - 1];
              return _buildStoryItem(user);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildYourStory() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.pink],
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Your Story',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStoryItem(Map<String, dynamic> user) {
    final bool storyViewed = user['storyViewed'] ?? false;
    
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: storyViewed
                  ? LinearGradient(
                      colors: [Colors.grey.withOpacity(0.5), Colors.grey.withOpacity(0.3)],
                    )
                  : const LinearGradient(
                      colors: [Colors.purple, Colors.pink, Colors.orange],
                    ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1A1F2E),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  user['avatar'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 60,
            child: Text(
              user['name'],
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}