import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchController extends GetxController {
  // Observable variables
  final searchQuery = ''.obs;
  final isLoading = false.obs;
  final searchResults = <Map<String, dynamic>>[].obs;
  final recentSearches = <String>[].obs;
  final searchHistory = <String>[].obs;
  
  // Sample data - in real app, this would come from API/database
  final List<Map<String, dynamic>> allBooks = [
    {
      'title': 'Dawn',
      'author': 'Irfan Mahardika',
      'rating': '4.7',
      'image': 'assets/book/cover-dawn.webp',
      'category': 'Kesusastraan',
      'year': '2023',
      'description': 'Sebuah novel yang mengisahkan perjalanan spiritual seorang pemuda.',
    },
    {
      'title': 'Life at the Monster Apartment',
      'author': 'Hinowa Kouzuki',
      'rating': '4.6',
      'image': 'assets/book/cover-latma.webp',
      'category': 'Kesusastraan',
      'year': '2022',
      'description': 'Komedi romantis tentang kehidupan di apartemen monster.',
    },
    {
      'title': 'Border v1',
      'author': 'Yua Kotegawa',
      'rating': '4.8',
      'image': 'assets/book/cover-border.webp',
      'category': 'Ilmu Sosial',
      'year': '2023',
      'description': 'Analisis mendalam tentang batas-batas sosial modern.',
    },
    {
      'title': 'Sesuk',
      'author': 'Tere Liye',
      'rating': '4.5',
      'image': 'assets/book/cover-sesuk.webp',
      'category': 'Kesusastraan',
      'year': '2023',
      'description': 'Novel fantasi dari penulis terkenal Indonesia.',
    },
    {
      'title': 'Rumah Untuk Alie',
      'author': 'Lenn Liu',
      'rating': '4.4',
      'image': 'assets/book/cover-rua.webp',
      'category': 'Kesusastraan',
      'year': '2024',
      'description': 'Kisah mengharukan tentang pencarian rumah impian.',
    },
    {
      'title': 'Yang Telah Lama Pergi',
      'author': 'Tere Liye',
      'rating': '4.6',
      'image': 'assets/book/cover-ytlp.webp',
      'category': 'Kesusastraan',
      'year': '2024',
      'description': 'Kelanjutan dari serial Bumi karya Tere Liye.',
    },
    {
      'title': 'Namaku Alam',
      'author': 'Leila S. Chudori',
      'rating': '4.7',
      'image': 'assets/book/cover-na.webp',
      'category': 'Kesusastraan',
      'year': '2024',
      'description': 'Novel tentang perjuangan lingkungan hidup.',
    },
  ];

  final List<String> popularSearches = [
    'Tere Liye',
    'Novel fantasi',
    'Kesusastraan',
    'Buku baru 2024',
    'Romance',
    'Science fiction',
    'Psikologi',
    'Sejarah Indonesia',
  ];

  @override
  void onInit() {
    super.onInit();
    loadSearchHistory();
  }

  // Load search history from local storage (in real app)
  void loadSearchHistory() {
    // Simulate loading from local storage
    searchHistory.addAll([
      'Tere Liye',
      'Novel romantis',
      'Buku psikologi',
    ]);
  }

  // Perform search
  void performSearch(String query) {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    searchQuery.value = query;

    // Add to search history if not already exists
    if (!searchHistory.contains(query)) {
      searchHistory.insert(0, query);
      if (searchHistory.length > 10) {
        searchHistory.removeLast();
      }
    }

    // Simulate API delay
    Future.delayed(Duration(milliseconds: 500), () {
      // Filter books based on search query
      final results = allBooks.where((book) {
        final titleMatch = book['title'].toString().toLowerCase().contains(query.toLowerCase());
        final authorMatch = book['author'].toString().toLowerCase().contains(query.toLowerCase());
        final categoryMatch = book['category'].toString().toLowerCase().contains(query.toLowerCase());
        final descriptionMatch = book['description'].toString().toLowerCase().contains(query.toLowerCase());
        
        return titleMatch || authorMatch || categoryMatch || descriptionMatch;
      }).toList();

      searchResults.assignAll(results);
      isLoading.value = false;
    });
  }

  // Clear search
  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
  }

  // Remove from search history
  void removeFromHistory(String query) {
    searchHistory.remove(query);
  }

  // Clear all search history
  void clearAllHistory() {
    searchHistory.clear();
  }

  // Quick search with popular terms
  void quickSearch(String query) {
    performSearch(query);
  }

  // Get filtered suggestions based on current input
  List<String> getSearchSuggestions(String input) {
    if (input.isEmpty) return [];
    
    final suggestions = <String>[];
    
    // Add matching books titles
    for (final book in allBooks) {
      if (book['title'].toString().toLowerCase().contains(input.toLowerCase())) {
        suggestions.add(book['title']);
      }
      if (book['author'].toString().toLowerCase().contains(input.toLowerCase())) {
        suggestions.add(book['author']);
      }
    }
    
    // Add matching popular searches
    for (final search in popularSearches) {
      if (search.toLowerCase().contains(input.toLowerCase())) {
        suggestions.add(search);
      }
    }
    
    // Remove duplicates and limit to 5 suggestions
    return suggestions.toSet().take(5).toList();
  }

  @override
  void onClose() {
    super.onClose();
  }
}