import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  // Observable untuk status filter
  var selectedFilter = 'Semua'.obs;
  var searchQuery = ''.obs;
  
  // Observable untuk loading state
  var isLoading = false.obs;
  
  // List filter options
  final List<String> filterOptions = [
    'Semua',
    'Dipinjam',
    'Dikembalikan',
    'Terlambat',
    'Reservasi'
  ];
  
  // Dummy data untuk riwayat peminjaman
  var borrowHistory = <Map<String, dynamic>>[
    {
      'id': 1,
      'bookTitle': 'Laut Bercerita',
      'author': 'Leila S. Chudori',
      'coverUrl': 'https://via.placeholder.com/60x80/6E40F3/FFFFFF?text=LB',
      'borrowDate': '15 Mei 2025',
      'returnDate': '29 Mei 2025',
      'actualReturnDate': null,
      'status': 'Dipinjam',
      'daysLeft': 4,
      'fine': 0,
      'category': 'Fiksi',
    },
    {
      'id': 2,
      'bookTitle': 'Janji',
      'author': 'Tere Liye',
      'coverUrl': 'https://via.placeholder.com/60x80/6E40F3/FFFFFF?text=J',
      'borrowDate': '10 Mei 2025',
      'returnDate': '24 Mei 2025',
      'actualReturnDate': '23 Mei 2025',
      'status': 'Dikembalikan',
      'daysLeft': 0,
      'fine': 0,
      'category': 'Fiksi',
    },
    {
      'id': 3,
      'bookTitle': 'Sesuk',
      'author': 'Tere Liye',
      'coverUrl': 'https://via.placeholder.com/60x80/6E40F3/FFFFFF?text=S',
      'borrowDate': '5 Mei 2025',
      'returnDate': '19 Mei 2025',
      'actualReturnDate': '22 Mei 2025',
      'status': 'Terlambat',
      'daysLeft': 0,
      'fine': 15000,
      'category': 'Fiksi',
    },
    {
      'id': 4,
      'bookTitle': 'Atomic Habits',
      'author': 'James Clear',
      'coverUrl': 'https://via.placeholder.com/60x80/6E40F3/FFFFFF?text=AH',
      'borrowDate': null,
      'returnDate': null,
      'actualReturnDate': null,
      'status': 'Reservasi',
      'daysLeft': 0,
      'fine': 0,
      'category': 'Self Help',
      'reservationDate': '20 Mei 2025',
      'estimatedAvailable': '30 Mei 2025',
    },
    {
      'id': 5,
      'bookTitle': 'Cantik Itu Luka',
      'author': 'Eka Kurniawan',
      'coverUrl': 'https://via.placeholder.com/60x80/6E40F3/FFFFFF?text=CIL',
      'borrowDate': '1 Mei 2025',
      'returnDate': '15 Mei 2025',
      'actualReturnDate': '14 Mei 2025',
      'status': 'Dikembalikan',
      'daysLeft': 0,
      'fine': 0,
      'category': 'Fiksi',
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  // Method untuk load history
  void loadHistory() {
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  // Method untuk filter history
  List<Map<String, dynamic>> get filteredHistory {
    var filtered = borrowHistory.where((item) {
      bool matchesFilter = selectedFilter.value == 'Semua' || 
                          item['status'] == selectedFilter.value;
      
      bool matchesSearch = searchQuery.value.isEmpty ||
                          item['bookTitle'].toString().toLowerCase()
                              .contains(searchQuery.value.toLowerCase()) ||
                          item['author'].toString().toLowerCase()
                              .contains(searchQuery.value.toLowerCase());
      
      return matchesFilter && matchesSearch;
    }).toList();
    
    return filtered;
  }

  // Method untuk update filter
  void updateFilter(String filter) {
    selectedFilter.value = filter;
  }

  // Method untuk update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Method untuk extend peminjaman
  void extendBorrow(int bookId) {
    var bookIndex = borrowHistory.indexWhere((book) => book['id'] == bookId);
    if (bookIndex != -1 && borrowHistory[bookIndex]['status'] == 'Dipinjam') {
      // Simulate extend 7 days
      borrowHistory[bookIndex]['daysLeft'] += 7;
      borrowHistory.refresh();
      
      Get.snackbar(
        'Berhasil',
        'Peminjaman berhasil diperpanjang 7 hari',
        backgroundColor: Color(0xFF43A047),
        colorText: Color(0xFFF7F7F7),
      );
    }
  }

  // Method untuk cancel reservasi
  void cancelReservation(int bookId) {
    Get.defaultDialog(
      title: 'Batalkan Reservasi',
      titleStyle: TextStyle(color: Color(0xFFF7F7F7)),
      backgroundColor: Color(0xFF2A2E43),
      middleText: 'Apakah kamu yakin ingin membatalkan reservasi ini?',
      middleTextStyle: TextStyle(color: Color(0xFFF7F7F7)),
      textCancel: 'Tidak',
      textConfirm: 'Ya, Batalkan',
      cancelTextColor: Color(0xFFF7F7F7),
      confirmTextColor: Color(0xFFF7F7F7),
      buttonColor: Color(0xFFE53E3E),
      onConfirm: () {
        borrowHistory.removeWhere((book) => book['id'] == bookId);
        Get.back();
        Get.snackbar(
          'Berhasil',
          'Reservasi berhasil dibatalkan',
          backgroundColor: Color(0xFF43A047),
          colorText: Color(0xFFF7F7F7),
        );
      },
    );
  }

  // Method untuk bayar denda
  void payFine(int bookId) {
    var bookIndex = borrowHistory.indexWhere((book) => book['id'] == bookId);
    if (bookIndex != -1) {
      var fine = borrowHistory[bookIndex]['fine'];
      
      Get.defaultDialog(
        title: 'Bayar Denda',
        titleStyle: TextStyle(color: Color(0xFFF7F7F7)),
        backgroundColor: Color(0xFF2A2E43),
        middleText: 'Denda yang harus dibayar: Rp ${fine.toString()}',
        middleTextStyle: TextStyle(color: Color(0xFFF7F7F7)),
        textCancel: 'Batal',
        textConfirm: 'Bayar',
        cancelTextColor: Color(0xFFF7F7F7),
        confirmTextColor: Color(0xFFF7F7F7),
        buttonColor: Color(0xFF6E40F3),
        onConfirm: () {
          borrowHistory[bookIndex]['fine'] = 0;
          borrowHistory[bookIndex]['status'] = 'Dikembalikan';
          borrowHistory.refresh();
          Get.back();
          Get.snackbar(
            'Berhasil',
            'Denda berhasil dibayar',
            backgroundColor: Color(0xFF43A047),
            colorText: Color(0xFFF7F7F7),
          );
        },
      );
    }
  }
}