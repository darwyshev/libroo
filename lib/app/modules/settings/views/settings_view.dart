import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(),
                SizedBox(height: 24),
                _buildProfileSection(),
                SizedBox(height: 24),
                _buildNotificationSection(),
                SizedBox(height: 24),
                _buildRecoverySection(),
                SizedBox(height: 24),
                _buildAccountSection(),
                SizedBox(height: 24),
                _buildAppInfoSection(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Top Bar
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF6E40F3).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFFF7F7F7),
                size: 24,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: 16),
          Text(
            'Pengaturan',
            style: TextStyle(
              color: Color(0xFFF7F7F7), 
              fontSize: 28, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Profile Section
  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profil Pengguna',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF2A2E43),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF6E40F3).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: Color(0xFF6E40F3),
                    size: 24,
                  ),
                ),
                title: Text(
                  'Edit Profil',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Ubah nama, email, dan foto profil',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFFF7F7F7).withOpacity(0.5),
                  size: 16,
                ),
                onTap: () => _showEditProfileDialog(),
              ),
              Divider(
                color: Color(0xFFF7F7F7).withOpacity(0.1),
                height: 1,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF6E40F3).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF6E40F3),
                    size: 24,
                  ),
                ),
                title: Text(
                  'Ganti Kata Sandi',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Perbarui password akun kamu',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFFF7F7F7).withOpacity(0.5),
                  size: 16,
                ),
                onTap: () => _showChangePasswordDialog(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Notification Section
  Widget _buildNotificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kelola Notifikasi',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF2A2E43),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Obx(() => _buildNotificationTile(
                'Notifikasi Peminjaman', 
                'Dapatkan notifikasi saat berhasil meminjam buku',
                controller.borrowNotification.value,
                (value) => controller.toggleBorrowNotification(value),
              )),
              Divider(color: Color(0xFFF7F7F7).withOpacity(0.1), height: 1),
              Obx(() => _buildNotificationTile(
                'Notifikasi Pengembalian', 
                'Pengingat sebelum batas waktu pengembalian',
                controller.returnNotification.value,
                (value) => controller.toggleReturnNotification(value),
              )),
              Divider(color: Color(0xFFF7F7F7).withOpacity(0.1), height: 1),
              Obx(() => _buildNotificationTile(
                'Notifikasi Keterlambatan', 
                'Peringatan jika terlambat mengembalikan buku',
                controller.overdueNotification.value,
                (value) => controller.toggleOverdueNotification(value),
              )),
              Divider(color: Color(0xFFF7F7F7).withOpacity(0.1), height: 1),
              Obx(() => _buildNotificationTile(
                'Notifikasi Promosi', 
                'Informasi tentang event dan promo terbaru',
                controller.promotionNotification.value,
                (value) => controller.togglePromotionNotification(value),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFFF7F7F7),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Color(0xFFF7F7F7).withOpacity(0.7),
          fontSize: 14,
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Color(0xFF6E40F3),
      activeTrackColor: Color(0xFF6E40F3).withOpacity(0.3),
      inactiveThumbColor: Color(0xFFF7F7F7).withOpacity(0.5),
      inactiveTrackColor: Color(0xFFF7F7F7).withOpacity(0.2),
    );
  }

  // Recovery Section
  Widget _buildRecoverySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status Pemulihan Buku',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Obx(() => Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: controller.hasOverdueBooks.value 
                ? Color(0xFFE57373).withOpacity(0.1)
                : Color(0xFF43A047).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: controller.hasOverdueBooks.value 
                  ? Color(0xFFE57373)
                  : Color(0xFF43A047),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                controller.hasOverdueBooks.value 
                    ? Icons.warning_amber_rounded
                    : Icons.check_circle_rounded,
                color: controller.hasOverdueBooks.value 
                    ? Color(0xFFE57373)
                    : Color(0xFF43A047),
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                controller.hasOverdueBooks.value 
                    ? 'Ada Buku Terlambat'
                    : 'Semua Buku Aman',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              if (controller.hasOverdueBooks.value) ...[
                Text(
                  '${controller.overdueCount.value} buku terlambat dikembalikan',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Total denda: Rp ${controller.totalFine.value}',
                  style: TextStyle(
                    color: Color(0xFFE57373),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.payFine(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF43A047),
                    foregroundColor: Color(0xFFF7F7F7),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Bayar Denda'),
                ),
              ] else ...[
                Text(
                  'Tidak ada keterlambatan pengembalian buku',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        )),
      ],
    );
  }

  // Account Section
  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Akun',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF2A2E43),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF6E40F3).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    color: Color(0xFF6E40F3),
                    size: 24,
                  ),
                ),
                title: Text(
                  'Logout Akun',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Keluar dari akun dengan aman',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFFF7F7F7).withOpacity(0.5),
                  size: 16,
                ),
                onTap: () => controller.logout(),
              ),
              Divider(
                color: Color(0xFFF7F7F7).withOpacity(0.1),
                height: 1,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFE57373).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.delete_forever_rounded,
                    color: Color(0xFFE57373),
                    size: 24,
                  ),
                ),
                title: Text(
                  'Hapus Akun',
                  style: TextStyle(
                    color: Color(0xFFE57373),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Hapus akun secara permanen',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFFF7F7F7).withOpacity(0.5),
                  size: 16,
                ),
                onTap: () => controller.deleteAccount(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // App Info Section
  Widget _buildAppInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Aplikasi',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF2A2E43),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF6E40F3),
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                'Libroo App',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Obx(() => Text(
                'Versi ${controller.appVersion.value} (${controller.buildNumber.value})',
                style: TextStyle(
                  color: Color(0xFFF7F7F7).withOpacity(0.7),
                  fontSize: 14,
                ),
              )),
              SizedBox(height: 16),
              Text(
                'Aplikasi perpustakaan digital untuk memudahkan akses dan pengelolaan buku',
                style: TextStyle(
                  color: Color(0xFFF7F7F7).withOpacity(0.8),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Edit Profile Dialog
  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: controller.userName.value);
    final emailController = TextEditingController(text: controller.userEmail.value);

    Get.dialog(
      Dialog(
        backgroundColor: Color(0xFF2A2E43),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Profil',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                style: TextStyle(color: Color(0xFFF7F7F7)),
                decoration: InputDecoration(
                  labelText: 'Nama',
                  labelStyle: TextStyle(color: Color(0xFFF7F7F7).withOpacity(0.7)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6E40F3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6E40F3), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                style: TextStyle(color: Color(0xFFF7F7F7)),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFFF7F7F7).withOpacity(0.7)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6E40F3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6E40F3), width: 2),
                    borderRadius: BorderRadius.circular