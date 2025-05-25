import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AchievementController extends GetxController {
  // Observable untuk loading state
  var isLoading = false.obs;
  
  // Observable untuk achievement categories
  var selectedCategory = 'Semua'.obs;
  
  // List kategori achievement
  final List<String> categories = [
    'Semua',
    'Membaca',
    'Koleksi',
    'Sosial',
    'Khusus'
  ];

  // List achievements dengan berbagai status
  var achievements = <Map<String, dynamic>>[
    {
      'id': 1,
      'title': 'Pembaca Pemula',
      'description': 'Selesaikan membaca 5 buku',
      'icon': Icons.book_rounded,
      'category': 'Membaca',
      'isUnlocked': true,
      'progress': 5,
      'target': 5,
      'points': 100,
      'unlockedDate': '15 Maret 2024',
      'color': Color(0xFF43A047),
    },
    {
      'id': 2,
      'title': 'Kutu Buku',
      'description': 'Selesaikan membaca 25 buku',
      'icon': Icons.auto_stories_rounded,
      'category': 'Membaca',
      'isUnlocked': true,
      'progress': 25,
      'target': 25,
      'points': 500,
      'unlockedDate': '2 April 2024',
      'color': Color(0xFF6E40F3),
    },
    {
      'id': 3,
      'title': 'Master Pembaca',
      'description': 'Selesaikan membaca 50 buku',
      'icon': Icons.school_rounded,
      'category': 'Membaca',
      'isUnlocked': false,
      'progress': 10,
      'target': 50,
      'points': 1000,
      'unlockedDate': null,
      'color': Color(0xFFFF9800),
    },
    {
      'id': 4,
      'title': 'Kolektor Bookmark',
      'description': 'Kumpulkan 20 bookmark',
      'icon': Icons.bookmark_rounded,
      'category': 'Koleksi',
      'isUnlocked': true,
      'progress': 20,
      'target': 20,
      'points': 200,
      'unlockedDate': '28 Maret 2024',
      'color': Color(0xFF2196F3),
    },
    {
      'id': 5,
      'title': 'Penjelajah Halaman',
      'description': 'Baca total 1000 halaman',
      'icon': Icons.article_rounded,
      'category': 'Membaca',
      'isUnlocked': false,
      'progress': 527,
      'target': 1000,
      'points': 300,
      'unlockedDate': null,
      'color': Color(0xFF9C27B0),
    },
    {
      'id': 6,
      'title': 'Kritikus Handal',
      'description': 'Berikan rating untuk 10 buku',
      'icon': Icons.star_rounded,
      'category': 'Sosial',
      'isUnlocked': false,
      'progress': 3,
      'target': 10,
      'points': 150,
      'unlockedDate': null,
      'color': Color(0xFFFF5722),
    },
    {
      'id': 7,
      'title': 'Anggota Setia',
      'description': 'Bergabung selama 6 bulan',
      'icon': Icons.loyalty_rounded,
      'category': 'Khusus',
      'isUnlocked': true,
      'progress': 6,
      'target': 6,
      'points': 250,
      'unlockedDate': '1 Januari 2024',
      'color': Color(0xFFE91E63),
    },
    {
      'id': 8,
      'title': 'Speed Reader',
      'description': 'Selesaikan 3 buku dalam seminggu',
      'icon': Icons.speed_rounded,
      'category': 'Khusus',
      'isUnlocked': false,
      'progress': 1,
      'target': 3,
      'points': 400,
      'unlockedDate': null,
      'color': Color(0xFF795548),
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadAchievements();
  }

  // Method untuk load achievements
  void loadAchievements() {
    isLoading.value = true;
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      isLoading.value = false;
    });
  }

  // Method untuk filter achievements berdasarkan kategori
  List<Map<String, dynamic>> getFilteredAchievements() {
    if (selectedCategory.value == 'Semua') {
      return achievements;
    }
    return achievements.where((achievement) => 
      achievement['category'] == selectedCategory.value
    ).toList();
  }

  // Method untuk mendapatkan total points
  int getTotalPoints() {
    return achievements
        .where((achievement) => achievement['isUnlocked'] == true)
        .fold(0, (sum, achievement) => sum + (achievement['points'] as int));
  }

  // Method untuk mendapatkan jumlah achievement yang sudah unlocked
  int getUnlockedCount() {
    return achievements.where((achievement) => achievement['isUnlocked'] == true).length;
  }

  // Method untuk mendapatkan progress percentage
  double getProgressPercentage(Map<String, dynamic> achievement) {
    return (achievement['progress'] / achievement['target']).clamp(0.0, 1.0);
  }

  // Method untuk change category
  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // Method untuk refresh achievements
  void refreshAchievements() {
    loadAchievements();
    Get.snackbar(
      'Info',
      'Achievement data telah diperbarui',
      backgroundColor: Color(0xFF2A2E43),
      colorText: Color(0xFFF7F7F7),
    );
  }
}