import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDetailController extends GetxController {
  final isBookmarked = false.obs;
  final readingProgress = 0.0.obs;
  final showFullDescription = false.obs;
  final userRating = 0.0.obs;
  final hasUserRated = false.obs;
  
  // Book availability status
  final isAvailable = true.obs;
  final totalStock = 5.obs;
  final availableStock = 5.obs;
  final borrowedBy = ''.obs;
  final returnDate = DateTime.now().add(Duration(days: 7)).obs;
  final borrowDate = DateTime.now().obs;
  final isCurrentUserBorrowing = false.obs;
  
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
        'totalRatings': 1245,
      };
    }
    
    // Simulate some books being borrowed
    if (bookData.value['title'] == 'Bumi') {
      isAvailable.value = false;
      availableStock.value = 2;
      borrowedBy.value = 'Ahmad Fauzi';
      returnDate.value = DateTime.now().add(Duration(days: 3));
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
  
  void showBorrowConfirmation() {
    if (!isAvailable.value && availableStock.value == 0) {
      Get.snackbar(
        'Buku Tidak Tersedia',
        'Maaf, buku sedang dipinjam semua. Silakan coba lagi nanti.',
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        icon: Icon(Icons.error, color: Colors.white),
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: Color(0xFF2A2E43),
        title: Text(
          'Konfirmasi Peminjaman',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yakin ingin meminjam buku "${bookData.value['title']}"?',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),
            Text(
              'Pilih tanggal pengembalian:',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _selectReturnDate(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6E40F3).withOpacity(0.2),
                  side: BorderSide(color: Color(0xFF6E40F3)),
                ),
                child: Obx(() => Text(
                  '${returnDate.value.day}/${returnDate.value.month}/${returnDate.value.year}',
                  style: TextStyle(color: Color(0xFF6E40F3)),
                )),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Batal', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _borrowBook();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6E40F3),
            ),
            child: Text('Pinjam', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
  
  void _selectReturnDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: returnDate.value,
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF6E40F3),
              surface: Color(0xFF2A2E43),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      returnDate.value = picked;
    }
  }
  
  void _borrowBook() {
    // Simulate borrowing process
    isCurrentUserBorrowing.value = true;
    borrowDate.value = DateTime.now();
    availableStock.value = availableStock.value - 1;
    if (availableStock.value == 0) {
      isAvailable.value = false;
    }
    
    _showQRCode();
    
    Get.snackbar(
      'Peminjaman Berhasil',
      'Buku berhasil dipinjam. Silakan tunjukkan QR Code ke petugas perpustakaan.',
      backgroundColor: Color(0xFF2A2E43),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
    );
  }
  
  void _showQRCode() {
    final borrowInfo = {
      'bookTitle': bookData.value['title'],
      'borrower': 'User Name', // In real app, get from user session
      'borrowDate': borrowDate.value.toIso8601String(),
      'returnDate': returnDate.value.toIso8601String(),
      'qrId': 'QR${DateTime.now().millisecondsSinceEpoch}',
    };
    
    Get.dialog(
      AlertDialog(
        backgroundColor: Color(0xFF2A2E43),
        title: Text(
          'QR Code Peminjaman',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code, size: 100, color: Colors.black),
                    SizedBox(height: 8),
                    Text(
                      borrowInfo['qrId']!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tunjukkan QR Code ini ke petugas perpustakaan',
              style: TextStyle(color: Colors.white70, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Batas pengembalian: ${returnDate.value.day}/${returnDate.value.month}/${returnDate.value.year}',
              style: TextStyle(color: Color(0xFF6E40F3), fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6E40F3),
            ),
            child: Text('Tutup', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
  
  void showQRCode() {
    if (isCurrentUserBorrowing.value) {
      _showQRCode();
    } else {
      Get.snackbar(
        'Belum Meminjam',
        'Anda belum meminjam buku ini. Silakan pinjam terlebih dahulu.',
        backgroundColor: Colors.orange.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16),
        borderRadius: 8,
        duration: Duration(seconds: 2),
        icon: Icon(Icons.info, color: Colors.white),
      );
    }
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
  
  void showRatingDialog() {
    double tempRating = userRating.value;
    
    Get.dialog(
      AlertDialog(
        backgroundColor: Color(0xFF2A2E43),
        title: Text(
          'Beri Rating',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bagaimana pendapat Anda tentang buku ini?',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),
            StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          tempRating = index + 1.0;
                        });
                      },
                      child: Icon(
                        index < tempRating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 32,
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Batal', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              userRating.value = tempRating;
              hasUserRated.value = true;
              Get.back();
              
              Get.snackbar(
                'Rating Tersimpan',
                'Terima kasih atas rating Anda!',
                backgroundColor: Color(0xFF2A2E43),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(16),
                borderRadius: 8,
                duration: Duration(seconds: 2),
                icon: Icon(Icons.star, color: Colors.amber),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6E40F3),
            ),
            child: Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}