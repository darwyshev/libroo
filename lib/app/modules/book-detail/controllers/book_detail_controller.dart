import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDetailController extends GetxController {
  final isBookmarked = false.obs;
  final isReading = false.obs;
  final readingProgress = 0.0.obs;
  final showFullDescription = false.obs;
  
  // Sample book data - in real app this would come from API
  final bookData = {}.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Get book data from arguments
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      bookData.value = args;
    } else {
      // Default book data if no arguments provided
      bookData.value = {
        'title': 'Janji',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-janji.webp',
        'rating': '4.8',
        'genre': 'Fiksi',
        'description': 'Sebuah cerita yang mengharukan tentang janji dan pengorbanan. Mengisahkan perjalanan hidup yang penuh dengan lika-liku kehidupan.',
        'pages': 320,
        'language': 'Indonesia',
        'publisher': 'Gramedia Pustaka Utama',
        'year': 2023,
      };
    }
  }
  
  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
    
    // Show snackbar notification
    Get.snackbar(
      isBookmarked.value ? 'Ditambahkan ke Bookmark' : 'Dihapus dari Bookmark',
      isBookmarked.value 
          ? 'Buku berhasil ditambahkan ke daftar bookmark Anda'
          : 'Buku berhasil dihapus dari daftar bookmark Anda',
      backgroundColor: Color(0xFF2A2E43),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      duration: Duration(seconds: 2),
      icon: Icon(
        isBookmarked.value ? Icons.bookmark : Icons.bookmark_border,
        color: Color(0xFF6E40F3),
      ),
    );
  }
  
  void startReading() {
    isReading.value = true;
    readingProgress.value = 0.0;
    
    Get.snackbar(
      'Mulai Membaca',
      'Selamat membaca! Progress Anda akan tersimpan otomatis.',
      backgroundColor: Color(0xFF2A2E43),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      duration: Duration(seconds: 2),
      icon: Icon(
        Icons.menu_book,
        color: Color(0xFF6E40F3),
      ),
    );
  }
  
  void downloadBook() {
    Get.snackbar(
      'Download Dimulai',
      'Buku sedang diunduh untuk dibaca offline.',
      backgroundColor: Color(0xFF2A2E43),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      duration: Duration(seconds: 2),
      icon: Icon(
        Icons.download,
        color: Color(0xFF6E40F3),
      ),
    );
  }
  
  void toggleDescription() {
    showFullDescription.value = !showFullDescription.value;
  }
  
  void shareBook() {
    Get.snackbar(
      'Berbagi Buku',
      'Link buku telah disalin ke clipboard',
      backgroundColor: Color(0xFF2A2E43),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      duration: Duration(seconds: 2),
      icon: Icon(
        Icons.share,
        color: Color(0xFF6E40F3),
      ),
    );
  }
}