import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/genre_chips.dart';
import '../widgets/anime_grid.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';
  List<String> selectedGenres = [];
  final TextEditingController _searchController = TextEditingController();

  final List<String> genres = [
    'Action',
    'Romance',
    'Comedy',
    'Drama',
    'Fantasy',
    'Horror',
    'Slice of Life',
    'Thriller',
    'Adventure',
    'Sci-Fi',
    'Mystery',
    'Supernatural',
    'Sports',
    'Music',
    'School',
    'Military',
  ];

  final List<Map<String, dynamic>> animeList = [
    {
      'title': 'Attack on Titan',
      'genres': ['Action', 'Drama', 'Fantasy'],
      'rating': 9.0,
      'episodes': 87,
      'status': 'Completed',
    },
    {
      'title': 'Your Name',
      'genres': ['Romance', 'Drama', 'Supernatural'],
      'rating': 8.4,
      'episodes': 1,
      'status': 'Movie',
    },
    {
      'title': 'One Piece',
      'genres': ['Action', 'Adventure', 'Comedy'],
      'rating': 9.2,
      'episodes': 1000,
      'status': 'Ongoing',
    },
    {
      'title': 'Demon Slayer',
      'genres': ['Action', 'Supernatural', 'Drama'],
      'rating': 8.7,
      'episodes': 44,
      'status': 'Ongoing',
    },
    {
      'title': 'My Hero Academia',
      'genres': ['Action', 'School', 'Adventure'],
      'rating': 8.5,
      'episodes': 138,
      'status': 'Ongoing',
    },
    {
      'title': 'Spirited Away',
      'genres': ['Adventure', 'Fantasy', 'Family'],
      'rating': 9.3,
      'episodes': 1,
      'status': 'Movie',
    },
    {
      'title': 'Death Note',
      'genres': ['Thriller', 'Mystery', 'Supernatural'],
      'rating': 9.0,
      'episodes': 37,
      'status': 'Completed',
    },
    {
      'title': 'Naruto',
      'genres': ['Action', 'Adventure', 'Comedy'],
      'rating': 8.3,
      'episodes': 720,
      'status': 'Completed',
    },
  ];

  List<Map<String, dynamic>> get filteredAnime {
    return animeList.where((anime) {
      final matchesSearch = searchQuery.isEmpty ||
          anime['title'].toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesGenres = selectedGenres.isEmpty ||
          selectedGenres.any((genre) => anime['genres'].contains(genre));
      
      return matchesSearch && matchesGenres;
    }).toList();
  }

  void _onGenreToggle(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
      }
    });
  }

  void _clearFilters() {
    setState(() {
      selectedGenres.clear();
      searchQuery = '';
      _searchController.clear();
    });
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
              Padding(
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
                      'Search Anime',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    if (selectedGenres.isNotEmpty || searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: _clearFilters,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.purple.withOpacity(0.5),
                            ),
                          ),
                          child: const Text(
                            'Clear',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Search Bar
              SearchBarWidget(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Genres Section
              GenreChips(
                genres: genres,
                selectedGenres: selectedGenres,
                onGenreToggle: _onGenreToggle,
              ),

              const SizedBox(height: 20),

              // Results Count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      '${filteredAnime.length} results found',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Anime Grid
              Expanded(
                child: AnimeGrid(animeList: filteredAnime),
              ),
            ],
          ),
        ),
      ),
    );
  }
}