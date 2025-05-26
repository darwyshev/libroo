import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // VARIABEL STATIS DATA USER
  var userName = 'Pembaca Setia'.obs;
  var userEmail = 'pembaca.setia@libroo.com'.obs;
  var membershipStatus = 'Member Premium'.obs;
  
  // DATA STATISTIK
  var booksRead = 42.obs;
  var pagesRead = 1247.obs;
  var bookmarks = 18.obs;
  var rating = 4.8.obs;

  @override
  void onInit() {
    super.onInit();
    // LOAD DATA USER SAAT INISIALISASI
    loadUserData();
  }

  // METODE UNTUK LOAD DATA USER
  void loadUserData() {
    // MASIH DUMMY BOLO
    print('Loading user profile data...');
  }

  // METODE UNTUK UPDATE PROFIL USER
  void updateProfile(String name, String email) {
    userName.value = name;
    userEmail.value = email;
    Get.snackbar(
      'Success',
      'Profile berhasil diupdate',
      backgroundColor: Color(0xFF43A047),
      colorText: Color(0xFFF7F7F7),
    );
  }

  // METODE UNTUK LOGOUT
  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      titleStyle: TextStyle(color: Color(0xFFF7F7F7)),
      backgroundColor: Color(0xFF2A2E43),
      middleText: 'Apakah kamu yakin ingin logout?',
      middleTextStyle: TextStyle(color: Color(0xFFF7F7F7)),
      textCancel: 'Batal',
      textConfirm: 'Logout',
      cancelTextColor: Color(0xFFF7F7F7),
      confirmTextColor: Color(0xFFF7F7F7),
      buttonColor: Color(0xFF6E40F3),
      onConfirm: () {
        Get.back();
        // CLEAR DATA USER
        userName.value = '';
        userEmail.value = '';
        Get.offAllNamed('/login');
      },
    );
  }

  // METODE UNTUK REFRESH PROFIL
  void refreshProfile() {
    loadUserData();
    Get.snackbar(
      'Info',
      'Profile data telah diperbarui',
      backgroundColor: Color(0xFF2A2E43),
      colorText: Color(0xFFF7F7F7),
    );
  }
}