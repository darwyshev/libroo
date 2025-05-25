import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  
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
                _buildProfileHeader(),
                SizedBox(height: 24),
                _buildStatsCard(),
                SizedBox(height: 24),
                _buildRecentActivity(),
                SizedBox(height: 24),
                _buildMenuOptions(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // Top Bar dengan Profile dan tombol settings
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: TextStyle(
              color: Color(0xFFF7F7F7), 
              fontSize: 28, 
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF6E40F3).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Color(0xFFF7F7F7),
                size: 26,
              ),
              onPressed: () {
                Get.toNamed('/settings');
              },
            ),
          ),
        ],
      ),
    );
  }

  // Profile Header dengan foto dan informasi user
  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6E40F3), Color(0xFF8A62FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.person_rounded,
              size: 150,
              color: Color(0xFFF7F7F7).withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFF7F7F7).withOpacity(0.2),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Color(0xFFF7F7F7),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Klein Moretti Aseli',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'prayogadariusw@gmail.com',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  // Stats Card dengan statistik pembacaan
  Widget _buildStatsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistik Membaca',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatItem('Buku Dibaca', '10', Icons.book_rounded),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildStatItem('Halaman', '527', Icons.article_rounded),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatItem('Bookmark', '6', Icons.bookmark_rounded),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildStatItem('Rating', '4.8', Icons.star_rounded),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Color(0xFF6E40F3),
            size: 24,
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFFF7F7F7).withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Recent Activity section
  Widget _buildRecentActivity() {
    final List<Map<String, dynamic>> activities = [
      {
        'title': 'Menyelesaikan "Janji" oleh Tere Liye',
        'time': '2 jam yang lalu',
        'icon': Icons.check_circle_rounded,
        'color': Color(0xFF43A047),
      },
      {
        'title': 'Menambahkan bookmark di "Laut Bercerita"',
        'time': '1 hari yang lalu',
        'icon': Icons.bookmark_add_rounded,
        'color': Color(0xFF6E40F3),
      },
      {
        'title': 'Memberikan rating 5 bintang untuk "Sesuk"',
        'time': '3 hari yang lalu',
        'icon': Icons.star_rounded,
        'color': Color(0xFFFF9800),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aktivitas Terbaru',
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
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (context, index) => Divider(
              color: Color(0xFFF7F7F7).withOpacity(0.1),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final activity = activities[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: activity['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    activity['icon'],
                    color: activity['color'],
                    size: 20,
                  ),
                ),
                title: Text(
                  activity['title'],
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  activity['time'],
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Menu Options
  Widget _buildMenuOptions() {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Riwayat Peminjaman',
        'subtitle': 'Tracking riwayat peminjaman buku kamu',
        'icon': Icons.history_rounded,
        'onTap': () {
          Get.toNamed('/loan-history');
        },
      },
      {
        'title': 'Prestasi',
        'subtitle': 'Badge dan pencapaian kamu',
        'icon': Icons.emoji_events_rounded,
        'onTap': () {
          Get.toNamed('/achievement');
        },
      },
      {
        'title': 'Bantuan & Dukungan',
        'subtitle': 'Butuh bantuan? Hubungi kami',
        'icon': Icons.help_outline_rounded,
        'onTap': () {
          Get.toNamed('/help');
        },
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu',
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
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: menuItems.length,
            separatorBuilder: (context, index) => Divider(
              color: Color(0xFFF7F7F7).withOpacity(0.1),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF6E40F3).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item['icon'],
                    color: Color(0xFF6E40F3),
                    size: 24,
                  ),
                ),
                title: Text(
                  item['title'],
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  item['subtitle'],
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
                onTap: item['onTap'],
              );
            },
          ),
        ),
      ],
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home_rounded, 'Home', false, () {
              Get.back();
            }),
            _buildNavItem(Icons.explore_outlined, 'Explore', false, () {
              Get.toNamed('/explore');
            }),
            _buildNavItem(Icons.bookmark_border_rounded, 'Bookmarks', false, () {
              Get.toNamed('/bookmark');
            }),
            _buildNavItem(Icons.person_outline_rounded, 'Profile', true, () {
              // Already on Profile page
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Color(0xFF6E40F3) : Colors.white54,
              size: 26,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Color(0xFF6E40F3) : Colors.white54,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}