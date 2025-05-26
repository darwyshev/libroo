import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoanHistoryController extends GetxController {
  // VARIABEL
  final searchController = TextEditingController();
  final searchQuery = ''.obs;
  final selectedFilter = 'Semua'.obs;
  final loanHistory = <Map<String, dynamic>>[].obs;
  final filteredLoanHistory = <Map<String, dynamic>>[].obs;

  // DATA SAMPEL
  final List<Map<String, dynamic>> _sampleData = [
    {
      'id': '1',
      'title': 'Laut Bercerita',
      'author': 'Leila S. Chudori',
      'loanDate': '15 Mei 2025',
      'returnDate': '29 Mei 2025',
      'status': 'active',
      'daysLeft': 4,
      'image': 'assets/book/cover-laut-bercerita.webp',
      'canExtend': true,
      'isExtended': false,
    },
    {
      'id': '2',
      'title': 'Bumi',
      'author': 'Tere Liye',
      'loanDate': '10 Mei 2025',
      'returnDate': '24 Mei 2025',
      'status': 'active',
      'daysLeft': -1,
      'image': 'assets/book/cover-bumi.webp',
      'canExtend': true,
      'isExtended': false,
    },
    {
      'id': '3',
      'title': 'Janji',
      'author': 'Tere Liye',
      'loanDate': '05 Mei 2025',
      'returnDate': '19 Mei 2025',
      'status': 'active',
      'daysLeft': -6,
      'image': 'assets/book/cover-janji.webp',
      'canExtend': false,
      'isExtended': true,
    },
    {
      'id': '4',
      'title': 'Sesuk',
      'author': 'Tere Liye',
      'loanDate': '20 Apr 2025',
      'returnDate': '04 Mei 2025',
      'status': 'completed',
      'returnedDate': '03 Mei 2025',
      'image': 'assets/book/cover-sesuk.webp',
      'canExtend': false,
      'isExtended': false,
    },
    {
      'id': '5',
      'title': 'Sagaras',
      'author': 'Tere Liye',
      'loanDate': '15 Apr 2025',
      'returnDate': '29 Apr 2025',
      'status': 'completed',
      'returnedDate': '28 Apr 2025',
      'image': 'assets/book/cover-sagaras.webp',
      'canExtend': false,
      'isExtended': false,
    },
    {
      'id': '6',
      'title': 'Hujan',
      'author': 'Tere Liye',
      'loanDate': '10 Apr 2025',
      'returnDate': '24 Apr 2025',
      'status': 'completed',
      'returnedDate': '23 Apr 2025',
      'image': 'assets/book/cover-hujan.webp',
      'canExtend': false,
      'isExtended': false,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    loanHistory.value = List.from(_sampleData);
    filteredLoanHistory.value = List.from(_sampleData);
    
    // INISIALISASI PENCARIAN DAN FILTER
    ever(searchQuery, (_) => _filterLoanHistory());
    ever(selectedFilter, (_) => _filterLoanHistory());
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // FUNGSI SEARCH
  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  // FUNGSI FILTER
  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void _filterLoanHistory() {
    List<Map<String, dynamic>> filtered = List.from(loanHistory);

    // TERAPKAN PENCARIAN
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered.where((loan) {
        return loan['title'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
               loan['author'].toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }

    // TERAPKAN FILTER
    if (selectedFilter.value != 'Semua') {
      filtered = filtered.where((loan) {
        switch (selectedFilter.value) {
          case 'Aktif':
            return loan['status'] == 'active' && loan['daysLeft'] >= 0;
          case 'Selesai':
            return loan['status'] == 'completed';
          case 'Terlambat':
            return loan['status'] == 'active' && loan['daysLeft'] < 0;
          default:
            return true;
        }
      }).toList();
    }

    filteredLoanHistory.value = filtered;
  }

  // FUNGSI UNTUK MENGEMBALIKAN BUKU
  void extendLoan(String loanId) {
    final loanIndex = loanHistory.indexWhere((loan) => loan['id'] == loanId);
    if (loanIndex != -1) {
      final loan = loanHistory[loanIndex];
      
      if (loan['canExtend'] && !loan['isExtended']) {
        // NAMBAH 2 HARI
        loan['daysLeft'] = loan['daysLeft'] + 2;
        loan['isExtended'] = true;
        loan['canExtend'] = false;
        
        // UPDATE TANGGAL KEMBALI
        loan['returnDate'] = _addDaysToDate(loan['returnDate'], 2);
        
        loanHistory[loanIndex] = loan;
        _filterLoanHistory();
        
        Get.snackbar(
          'Berhasil',
          'Peminjaman berhasil diperpanjang 2 hari',
          backgroundColor: Color(0xFF43A047),
          colorText: Color(0xFFF7F7F7),
          duration: Duration(seconds: 3),
        );
      } else if (loan['isExtended']) {
        Get.snackbar(
          'Tidak Dapat Diperpanjang',
          'Buku ini sudah pernah diperpanjang sebelumnya',
          backgroundColor: Color(0xFFE53E3E),
          colorText: Color(0xFFF7F7F7),
          duration: Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'Tidak Dapat Diperpanjang',
          'Buku ini tidak dapat diperpanjang',
          backgroundColor: Color(0xFFE53E3E),
          colorText: Color(0xFFF7F7F7),
          duration: Duration(seconds: 3),
        );
      }
    }
  }

  // METODE UNTUK MENAMBAH HARI KE TANGGAL
  String _addDaysToDate(String dateString, int days) {
    final parts = dateString.split(' ');
    if (parts.length >= 2) {
      int day = int.tryParse(parts[0]) ?? 1;
      day += days;
      return '$day ${parts[1]} ${parts.length > 2 ? parts[2] : '2025'}';
    }
    return dateString;
  }

  // KALKULASI DENDA
  int calculateFine(int daysLate) {
    return daysLate > 0 ? daysLate * 2000 : 0;
  }

  // FORMAT CURRENCY
  String formatCurrency(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  // DAPATKAN STATISTIK RINGKASAN
  Map<String, int> getSummaryStats() {
    final active = loanHistory.where((loan) => loan['status'] == 'active' && loan['daysLeft'] >= 0).length;
    final completed = loanHistory.where((loan) => loan['status'] == 'completed').length;
    final overdue = loanHistory.where((loan) => loan['status'] == 'active' && loan['daysLeft'] < 0).length;
    
    return {
      'total': loanHistory.length,
      'active': active,
      'completed': completed,
      'overdue': overdue,
    };
  }
}