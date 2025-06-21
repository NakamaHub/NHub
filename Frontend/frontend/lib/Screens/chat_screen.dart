import 'package:flutter/material.dart';
import '../widgets/chat_list.dart';
import '../widgets/story_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  final List<Map<String, dynamic>> chatUsers = [
    {
      'name': 'OtakuMaster',
      'avatar': 'OM',
      'lastMessage': 'Did you watch the new episode?',
      'time': '2m',
      'unreadCount': 3,
      'isOnline': true,
      'hasStory': true,
      'storyViewed': false,
    },
    {
      'name': 'AnimeQueen',
      'avatar': 'AQ',
      'lastMessage': 'That fight scene was amazing! 🔥',
      'time': '15m',
      'unreadCount': 0,
      'isOnline': true,
      'hasStory': true,
      'storyViewed': true,
    },
    {
      'name': 'NarutoFan99',
      'avatar': 'NF',
      'lastMessage': 'Believe it! 🍜',
      'time': '1h',
      'unreadCount': 1,
      'isOnline': false,
      'hasStory': false,
      'storyViewed': false,
    },
    {
      'name': 'SailorMoonLover',
      'avatar': 'SM',
      'lastMessage': 'In the name of the moon...',
      'time': '2h',
      'unreadCount': 0,
      'isOnline': true,
      'hasStory': true,
      'storyViewed': false,
    },
    {
      'name': 'DragonBallZ',
      'avatar': 'DB',
      'lastMessage': 'Over 9000! 💪',
      'time': '3h',
      'unreadCount': 5,
      'isOnline': false,
      'hasStory': false,
      'storyViewed': false,
    },
    {
      'name': 'StudioGhibli',
      'avatar': 'SG',
      'lastMessage': 'Totoro is the best! 🌳',
      'time': '5h',
      'unreadCount': 0,
      'isOnline': true,
      'hasStory': true,
      'storyViewed': true,
    },
    {
      'name': 'OnePieceCrew',
      'avatar': 'OP',
      'lastMessage': 'Luffy will be Pirate King! 👑',
      'time': '1d',
      'unreadCount': 2,
      'isOnline': false,
      'hasStory': false,
      'storyViewed': false,
    },
    {
      'name': 'AttackOnTitan',
      'avatar': 'AT',
      'lastMessage': 'Sasageyo! ⚔️',
      'time': '2d',
      'unreadCount': 0,
      'isOnline': true,
      'hasStory': true,
      'storyViewed': false,
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    if (searchQuery.isEmpty) return chatUsers;
    return chatUsers.where((user) =>
        user['name'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D1B69),
              Color(0xFF0A0E1A),
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Search Bar
              _buildSearchBar(),
              
              const SizedBox(height: 16),
              
              // Stories
              StoryBar(users: chatUsers),
              
              const SizedBox(height: 16),
              
              // Chat List
              Expanded(
                child: ChatList(users: filteredUsers),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Anime Chat',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              // Handle new chat
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Start new chat'),
                  backgroundColor: Colors.purple,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.purple,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: const InputDecoration(
            hintText: 'Search chats...',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }
}