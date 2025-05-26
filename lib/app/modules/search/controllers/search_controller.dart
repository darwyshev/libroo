import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchController extends GetxController {
  // VARIABEL
  final searchQuery = ''.obs;
  final isLoading = false.obs;
  final searchResults = <Map<String, dynamic>>[].obs;
  final recentSearches = <String>[].obs;
  final searchHistory = <String>[].obs;
  
  // DATA SAMPLE BUKU
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
    {
      'title': 'Bumi',
      'author': 'Tere Liye',
      'rating': '4.9',
      'image': 'assets/book/cover-bumi.webp',
      'category': 'Kesusastraan',
      'year': '2024',
      'description': 'Novel yang mengisahkan petualangan di dunia paralel.',
    },
    {
      'title': 'Hujan',
      'author': 'Tere Liye',
      'rating': '4.8',
      'image': 'assets/book/cover-hujan.webp',
      'category': 'Kesusastraan',
      'year': '2024',
      'description': 'Kisah cinta yang terhalang oleh takdir.',
    },
    {
      'title': 'Sagaras',
      'author': 'Tere Liye',
      'rating': '4.7',
      'image': 'assets/book/cover-sagaras.webp',
      'category': 'Kesusastraan',
      'year': '2024',
      'description': 'Novel petualangan yang mengisahkan perjalanan melintasi lautan.',
    },
    {
      'title': 'Janji',
      'author': 'Tere Liye',
      'rating': '4.6',
      'image': 'assets/book/cover-janji.webp',
      'category': 'Kesusastraan',
      'year': '2024',
      'description': 'Kisah tentang janji yang terucap dan konsekuensinya.',
    },
    {
      'title': 'Laut Bercerita',
      'author': 'Leila S. Chudori',
      'rating': '4.8',
      'image': 'assets/book/cover-laut-bercerita.webp',
      'category': 'Kesusastraan',
      'year': '2024',
      'description': 'Novel yang mengisahkan hubungan manusia dengan laut.',
    },
  ];

  final List<String> popularSearches = [
    'Tere Liye',
    'Novel fantasi',
    'Kesusastraan',
    'Laut Bercerita',
    'Bumi',
    'Science fiction',
    'Psikologi',
    'Sagaras',
  ];

  @override
  void onInit() {
    super.onInit();
    loadSearchHistory();
  }

  // LOAD SEARCH HISTORY
  void loadSearchHistory() {
    // SIMULASI LOADDING
    searchHistory.addAll([
      'Tere Liye',
      'Novel romantis',
      'Buku psikologi',
    ]);
  }

  // SEARCH
  void performSearch(String query) {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    searchQuery.value = query;

    // TAMBAH KE SEARCH HISTORY KALAU BELUM PERNAH
    if (!searchHistory.contains(query)) {
      searchHistory.insert(0, query);
      if (searchHistory.length > 10) {
        searchHistory.removeLast();
      }
    }

    // SIMULASI LOADING DENGAN DELAY
    Future.delayed(Duration(milliseconds: 500), () {
      // FILTER BUKU BERDASARKAN QUERY
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

  // CLEAR SEARCH
  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
  }

  // HAPUS DARI SEARCH HISTORY
  void removeFromHistory(String query) {
    searchHistory.remove(query);
  }

  // HAPUS SEMUA SEARCH HISTORY
  void clearAllHistory() {
    searchHistory.clear();
  }

  // SEARCH CEPAT DENGAN QUERY
  void quickSearch(String query) {
    performSearch(query);
  }

  // DAPAT DAFTAR SUGGESTIONS
  List<String> getSearchSuggestions(String input) {
    if (input.isEmpty) return [];
    
    final suggestions = <String>[];
    
    // TAMBAHKAN SUGGESTIONS DARI JUDUL DAN PENULIS BUKU
    for (final book in allBooks) {
      if (book['title'].toString().toLowerCase().contains(input.toLowerCase())) {
        suggestions.add(book['title']);
      }
      if (book['author'].toString().toLowerCase().contains(input.toLowerCase())) {
        suggestions.add(book['author']);
      }
    }
    
    // TAMBAHKAN SUGGESTIONS DARI POPULAR SEARCHES
    for (final search in popularSearches) {
      if (search.toLowerCase().contains(input.toLowerCase())) {
        suggestions.add(search);
      }
    }
    
    // HAPUS DUPLIKAT DAN BATASI KE 5 SUGGESTIONS
    return suggestions.toSet().take(5).toList();
  }

  @override
  void onClose() {
    super.onClose();
  }
}