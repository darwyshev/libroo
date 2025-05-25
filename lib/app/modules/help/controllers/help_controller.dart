import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class HelpController extends GetxController {
  // Observable untuk FAQ expanded state
  var expandedFAQIndex = (-1).obs;
  
  // Observable untuk search query
  var searchQuery = ''.obs;
  
  // Controller untuk search text field
  final searchController = TextEditingController();
  
  // Daftar FAQ
  final List<Map<String, String>> faqList = [
    {
      'question': 'Bagaimana cara meminjam buku?',
      'answer': 'Untuk meminjam buku, cari buku yang ingin dipinjam melalui fitur pencarian atau jelajahi kategori. Tap buku yang dipilih, lalu pilih "Pinjam Buku". Pastikan Anda sudah login dan memiliki akun aktif.'
    },
    {
      'question': 'Berapa lama durasi peminjaman buku?',
      'answer': 'Durasi peminjaman standar adalah 5 hari. Anda dapat memperpanjang peminjaman hingga 2 kali jika tidak ada antrian untuk buku tersebut.'
    },
    {
      'question': 'Bagaimana cara mengembalikan buku?',
      'answer': 'Datang langsung ke perpustakaan atau gunakan fitur "Kembalikan Buku" di aplikasi untuk konfirmasi pengembalian.'
    },
    {
      'question': 'Apa itu Member Premium?',
      'answer': 'Tidak ada Member Premium di Libroo. Semua fitur tersedia gratis untuk semua pengguna.'
    },
    {
      'question': 'Bagaimana cara upgrade ke Premium?',
      'answer': 'Tidak ada, Libroo adalah layanan gratis yang tidak memerlukan biaya berlangganan. Semua fitur tersedia untuk semua pengguna tanpa biaya.'
    },
    {
      'question': 'Apakah bisa membaca offline?',
      'answer': 'Tidak, Libroo adalah layanan aplikasi untuk meminjam buku fisik ke perpustakaan sekolah, jadi tidak ada fitur membaca offline. Semua buku harus dipinjam secara online melalui aplikasi.'
    },
    {
      'question': 'Bagaimana cara reset password?',
      'answer': 'Di halaman profil, tap ikon setting, tap "Edit Profil", lalu ganti password Anda. Pastikan untuk memasukkan password lama dan baru dengan benar.'
    },
    {
      'question': 'Bagaimana sistem denda keterlambatan?',
      'answer': 'Denda keterlambatan adalah Rp 2.000 per hari untuk buku fisik. Akses akan dibatasi jika sering terlambat mengembalikan.'
    }
  ];
  
  // Contact options
  final List<Map<String, dynamic>> contactOptions = [
    {
      'title': 'Email Support',
      'subtitle': 'prayogadariusw@gmail.com',
      'icon': Icons.email_outlined,
      'action': 'email'
    },
    {
      'title': 'WhatsApp',
      'subtitle': '+62 838-4847-5758',
      'icon': Icons.chat_outlined,
      'action': 'whatsapp'
    },
    {
      'title': 'Telepon',
      'subtitle': '(021) 5555-1234',
      'icon': Icons.phone_outlined,
      'action': 'phone'
    },
    {
      'title': 'Live Chat',
      'subtitle': 'Chat langsung dengan CS',
      'icon': Icons.support_agent_outlined,
      'action': 'livechat'
    }
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Toggle FAQ expansion
  void toggleFAQ(int index) {
    if (expandedFAQIndex.value == index) {
      expandedFAQIndex.value = -1;
    } else {
      expandedFAQIndex.value = index;
    }
  }

  // Search FAQ
  void searchFAQ(String query) {
    searchQuery.value = query.toLowerCase();
  }

  // Get filtered FAQ based on search
  List<Map<String, String>> get filteredFAQ {
    if (searchQuery.value.isEmpty) {
      return faqList;
    }
    return faqList.where((faq) =>
      faq['question']!.toLowerCase().contains(searchQuery.value) ||
      faq['answer']!.toLowerCase().contains(searchQuery.value)
    ).toList();
  }

  // Handle contact actions
  void handleContactAction(String action, String value) {
    switch (action) {
      case 'email':
        _copyToClipboard(value, 'Email address copied!');
        break;
      case 'whatsapp':
        _copyToClipboard(value, 'WhatsApp number copied!');
        break;
      case 'phone':
        _copyToClipboard(value, 'Phone number copied!');
        break;
      case 'livechat':
        Get.snackbar(
          'Live Chat',
          'Menghubungkan ke customer service...',
          backgroundColor: Color(0xFF6E40F3),
          colorText: Color(0xFFF7F7F7),
          icon: Icon(Icons.chat, color: Color(0xFFF7F7F7)),
        );
        break;
    }
  }

  void _copyToClipboard(String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      message,
      backgroundColor: Color(0xFF43A047),
      colorText: Color(0xFFF7F7F7),
      icon: Icon(Icons.copy, color: Color(0xFFF7F7F7)),
      duration: Duration(seconds: 2),
    );
  }

  // Send feedback
  void sendFeedback(String feedback) {
    if (feedback.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Mohon isi feedback terlebih dahulu',
        backgroundColor: Color(0xFFE53935),
        colorText: Color(0xFFF7F7F7),
      );
      return;
    }

    // Simulate sending feedback
    Get.back(); // Close dialog
    Get.snackbar(
      'Terima Kasih',
      'Feedback Anda telah diterima dan akan segera kami tindaklanjuti',
      backgroundColor: Color(0xFF43A047),
      colorText: Color(0xFFF7F7F7),
      icon: Icon(Icons.thumb_up, color: Color(0xFFF7F7F7)),
      duration: Duration(seconds: 3),
    );
  }

  // Show feedback dialog
  void showFeedbackDialog() {
    final feedbackController = TextEditingController();
    
    Get.dialog(
      Dialog(
        backgroundColor: Color(0xFF2A2E43),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kirim Feedback',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Berikan saran atau masukan untuk membantu kami meningkatkan layanan',
                style: TextStyle(
                  color: Color(0xFFF7F7F7).withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: feedbackController,
                maxLines: 4,
                style: TextStyle(color: Color(0xFFF7F7F7)),
                decoration: InputDecoration(
                  hintText: 'Tulis feedback Anda di sini...',
                  hintStyle: TextStyle(color: Color(0xFFF7F7F7).withOpacity(0.5)),
                  filled: true,
                  fillColor: Color(0xFF1F2334),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Batal',
                      style: TextStyle(color: Color(0xFFF7F7F7).withOpacity(0.7)),
                    ),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => sendFeedback(feedbackController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6E40F3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Kirim',
                      style: TextStyle(color: Color(0xFFF7F7F7)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}