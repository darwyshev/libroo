import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Observable variables untuk data user
  var userName = 'Pembaca Setia'.obs;
  var userEmail = 'pembaca.setia@libroo.com'.obs;
  var membershipStatus = 'Member Premium'.obs;
  
  // Stats observables
  var booksRead = 42.obs;
  var pagesRead = 1247.obs;
  var bookmarks = 18.obs;
  var rating = 4.8.obs;

  @override
  void onInit() {
    super.onInit();
    // Load user data when controller initializes
    loadUserData();
  }

  // Method untuk load data user
  void loadUserData() {
    // Di sini nanti bisa connect ke API atau local storage
    // Untuk sekarang pakai data dummy
    print('Loading user profile data...');
  }

  // Method untuk update profile
  void updateProfile(String name, String email) {
    userName.value = name;
    userEmail.value = email;
    // Save to storage/API
    Get.snackbar(
      'Success',
      'Profile berhasil diupdate',
      backgroundColor: Color(0xFF43A047),
      colorText: Color(0xFFF7F7F7),
    );
  }

  // Method untuk logout
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
        // Clear user data
        userName.value = '';
        userEmail.value = '';
        // Navigate to login page
        Get.offAllNamed('/login');
      },
    );
  }

  // Method untuk refresh data
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