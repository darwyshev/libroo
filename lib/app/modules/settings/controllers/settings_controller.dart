import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // PROFIL DATA USER
  var userName = 'Klein Moretti Aseli'.obs;
  var userEmail = 'prayogadariusw@gmail.com'.obs;
  var profileImagePath = ''.obs;
  
  // PENGATURAN NOTIFIKASI
  var borrowNotification = true.obs;
  var returnNotification = true.obs;
  var overdueNotification = true.obs;
  var promotionNotification = false.obs;
  
  // STATUS PEMBAYARAN DAN PENGEMBALIAN
  var hasOverdueBooks = false.obs;
  var totalFine = 0.obs;
  var overdueCount = 0.obs;
  
  // INFORMASI APP
  var appVersion = '1.0.0'.obs;
  var buildNumber = '1'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettingsData();
  }

  // LOAD DATA PENGATURAN
  void loadSettingsData() {
    print('Loading settings data...');
    // LOADING SEBELUM DATA DIAMBIL
    hasOverdueBooks.value = false;
    totalFine.value = 0;
    overdueCount.value = 0;
  }

  // UPDATE PROFIL
  void updateProfile(String name, String email) {
    if (name.isEmpty || email.isEmpty) {
      Get.snackbar(
        'Error',
        'Nama dan email tidak boleh kosong',
        backgroundColor: Color(0xFFE57373),
        colorText: Color(0xFFF7F7F7),
      );
      return;
    }
    
    userName.value = name;
    userEmail.value = email;
    
    Get.snackbar(
      'Berhasil',
      'Profile berhasil diperbarui',
      backgroundColor: Color(0xFF43A047),
      colorText: Color(0xFFF7F7F7),
    );
  }

  // GANTI PASSWORD
  void changePassword(String currentPassword, String newPassword, String confirmPassword) {
    if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua field harus diisi',
        backgroundColor: Color(0xFFE57373),
        colorText: Color(0xFFF7F7F7),
      );
      return;
    }
    
    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'Password baru tidak cocok',
        backgroundColor: Color(0xFFE57373),
        colorText: Color(0xFFF7F7F7),
      );
      return;
    }
    
    if (newPassword.length < 6) {
      Get.snackbar(
        'Error',
        'Password minimal 6 karakter',
        backgroundColor: Color(0xFFE57373),
        colorText: Color(0xFFF7F7F7),
      );
      return;
    }

    Get.snackbar(
      'Berhasil',
      'Password berhasil diubah',
      backgroundColor: Color(0xFF43A047),
      colorText: Color(0xFFF7F7F7),
    );
  }

  // PENGATURAN NOTIFIKASI
  void toggleBorrowNotification(bool value) {
    borrowNotification.value = value;
    saveNotificationSettings();
  }

  void toggleReturnNotification(bool value) {
    returnNotification.value = value;
    saveNotificationSettings();
  }

  void toggleOverdueNotification(bool value) {
    overdueNotification.value = value;
    saveNotificationSettings();
  }

  void togglePromotionNotification(bool value) {
    promotionNotification.value = value;
    saveNotificationSettings();
  }

  void saveNotificationSettings() {
    Get.snackbar(
      'Info',
      'Pengaturan notifikasi disimpan',
      backgroundColor: Color(0xFF2A2E43),
      colorText: Color(0xFFF7F7F7),
      duration: Duration(seconds: 2),
    );
  }

  // HAPUS AKUN
  void deleteAccount() {
    Get.defaultDialog(
      title: 'Hapus Akun',
      titleStyle: TextStyle(color: Color(0xFFF7F7F7)),
      backgroundColor: Color(0xFF2A2E43),
      contentPadding: EdgeInsets.all(15),
      middleText: 'Apakah kamu yakin ingin menghapus akun? Tindakan ini tidak dapat dibatalkan.',
      middleTextStyle: TextStyle(color: Color(0xFFF7F7F7)),
      textCancel: 'Batal',
      textConfirm: 'Hapus',
      cancelTextColor: Color(0xFFF7F7F7),
      confirmTextColor: Color(0xFFF7F7F7),
      buttonColor: Color(0xFFE57373),
      onConfirm: () {
        Get.back();
        _confirmDeleteAccount();
      },
    );
  }

  void _confirmDeleteAccount() {
    Get.defaultDialog(
      title: 'Konfirmasi Terakhir',
      titleStyle: TextStyle(color: Color(0xFFF7F7F7)),
      backgroundColor: Color(0xFF2A2E43),
      middleText: 'Ketik "HAPUS" untuk mengkonfirmasi penghapusan akun',
      middleTextStyle: TextStyle(color: Color(0xFFF7F7F7)),
      content: Column(
        children: [
          Text(
            'Ketik "HAPUS" untuk mengkonfirmasi penghapusan akun',
            style: TextStyle(color: Color(0xFFF7F7F7)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          TextField(
            style: TextStyle(color: Color(0xFFF7F7F7)),
            decoration: InputDecoration(
              hintText: 'Ketik HAPUS',
              hintStyle: TextStyle(color: Color(0xFFF7F7F7).withOpacity(0.5)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6E40F3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6E40F3)),
              ),
            ),
            onChanged: (value) {
              if (value == 'HAPUS') {
                Get.back();
                // HAPUS AKUN LOGIKA
                Get.snackbar(
                  'Berhasil',
                  'Akun berhasil dihapus',
                  backgroundColor: Color(0xFF43A047),
                  colorText: Color(0xFFF7F7F7),
                );
                Get.offAllNamed('/login');
              }
            },
          ),
        ],
      ),
      textCancel: 'Batal',
      cancelTextColor: Color(0xFFF7F7F7),
    );
  }

  // LOGOUT
  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      titleStyle: TextStyle(color: Color(0xFFF7F7F7)),
      backgroundColor: Color(0xFF2A2E43),
      contentPadding: EdgeInsets.all(20),
      middleText: 'Apakah kamu yakin ingin keluar dari akun?',
      middleTextStyle: TextStyle(color: Color(0xFFF7F7F7)),
      textCancel: 'Batal',
      textConfirm: 'Logout',
      cancelTextColor: Color(0xFFF7F7F7),
      confirmTextColor: Color(0xFFF7F7F7),
      buttonColor: Color(0xFF6E40F3),
      onConfirm: () {
        Get.back();
        // BERSIHKAN DATA USER
        userName.value = '';
        userEmail.value = '';
        Get.offAllNamed('/login');
      },
    );
  }

  void payFine() {
    if (totalFine.value > 0) {
      Get.defaultDialog(
        title: 'Bayar Denda',
        titleStyle: TextStyle(color: Color(0xFFF7F7F7)),
        backgroundColor: Color(0xFF2A2E43),
        middleText: 'Bayar denda sebesar Rp ${totalFine.value}?',
        middleTextStyle: TextStyle(color: Color(0xFFF7F7F7)),
        textCancel: 'Batal',
        textConfirm: 'Bayar',
        cancelTextColor: Color(0xFFF7F7F7),
        confirmTextColor: Color(0xFFF7F7F7),
        buttonColor: Color(0xFF43A047),
        onConfirm: () {
          Get.back();
          totalFine.value = 0;
          hasOverdueBooks.value = false;
          overdueCount.value = 0;
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