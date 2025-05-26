import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildEventHero(),
                      SizedBox(height: 24),
                      _buildEventDetails(),
                      SizedBox(height: 24),
                      _buildEventRules(),
                      SizedBox(height: 24),
                      _buildEventPrizes(),
                      SizedBox(height: 24),
                      _buildEventTimeline(),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
            _buildJoinButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF6E40F3).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFFF7F7F7),
                size: 20,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: 16),
          Text(
            'Detail Event',
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF6E40F3).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.share_outlined,
                color: Color(0xFFF7F7F7),
                size: 22,
              ),
              onPressed: () {
                _showShareDialog();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventHero() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6E40F3), Color(0xFF8A62FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // POLA BACKGROUND
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFFF7F7F7).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
            child: Icon(
              Icons.auto_stories_rounded,
              size: 120,
              color: Color(0xFFF7F7F7).withOpacity(0.1),
            ),
          ),
          // KONTEN
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        color: Color(0xFFF7F7F7),
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '15 Hari Tersisa',
                        style: TextStyle(
                          color: Color(0xFFF7F7F7),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Lomba Membaca Cepat',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Kompetisi membaca dengan hadiah jutaan rupiah!',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.9),
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

  Widget _buildEventDetails() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Event',
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildDetailItem(
            Icons.calendar_today_rounded,
            'Tanggal',
            '1 - 31 Desember 2025',
          ),
          SizedBox(height: 12),
          _buildDetailItem(
            Icons.location_on_rounded,
            'Lokasi',
            'Online (Aplikasi Libroo)',
          ),
          SizedBox(height: 12),
          _buildDetailItem(
            Icons.people_rounded,
            'Peserta',
            '67 orang terdaftar',
          ),
          SizedBox(height: 12),
          _buildDetailItem(
            Icons.category_rounded,
            'Kategori',
            'Membaca Cepat & Pemahaman',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF6E40F3).withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Color(0xFF6E40F3),
            size: 20,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventRules() {
    final List<String> rules = [
      'Peserta harus terdaftar di aplikasi Libroo',
      'Buku yang dibaca harus terdaftar di aplikasi Libroo',
      'Rating buku harus dilakukan di aplikasi Libroo',
      'Setiap peserta wajib membaca dan merating minimal 5 buku',
      'Rating harus disertai review minimal 50 kata yang relevan',
      'Hasil akan diumumkan setelah periode lomba berakhir',
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.rule_rounded,
                color: Color(0xFF6E40F3),
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Syarat & Ketentuan',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ...rules.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFF6E40F3),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${entry.key + 1}',
                        style: TextStyle(
                          color: Color(0xFFF7F7F7),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: Color(0xFFF7F7F7),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEventPrizes() {
    final List<Map<String, String>> prizes = [
      {'position': '1st', 'prize': '2 Buku Pilihan', 'icon': '🥇'},
      {'position': '2nd', 'prize': '2 Buku Acak', 'icon': '🥈'},
      {'position': '3rd', 'prize': '1 Buku Acak', 'icon': '🥉'},
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events_rounded,
                color: Color(0xFF6E40F3),
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Hadiah Pemenang',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: prizes.map((prize) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF6E40F3).withOpacity(0.3),
                        Color(0xFF6E40F3).withOpacity(0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFF6E40F3).withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        prize['icon']!,
                        style: TextStyle(fontSize: 32),
                      ),
                      SizedBox(height: 8),
                      Text(
                        prize['position']!,
                        style: TextStyle(
                          color: Color(0xFFF7F7F7),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        prize['prize']!,
                        style: TextStyle(
                          color: Color(0xFF6E40F3),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTimeline() {
    final List<Map<String, String>> timeline = [
      {'date': '1 Des', 'event': 'Pendaftaran dibuka'},
      {'date': '10 Des', 'event': 'Masa persiapan peserta'},
      {'date': '15 Des', 'event': 'Lomba dimulai'},
      {'date': '30 Des', 'event': 'Lomba berakhir'},
      {'date': '31 Des', 'event': 'Pengumuman pemenang'},
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.timeline_rounded,
                color: Color(0xFF6E40F3),
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Timeline Event',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ...timeline.asMap().entries.map((entry) {
            bool isLast = entry.key == timeline.length - 1;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Color(0xFF6E40F3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 40,
                        color: Color(0xFF6E40F3).withOpacity(0.3),
                      ),
                  ],
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.value['date']!,
                          style: TextStyle(
                            color: Color(0xFF6E40F3),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          entry.value['event']!,
                          style: TextStyle(
                            color: Color(0xFFF7F7F7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildJoinButton() {
    return Container(
      padding: EdgeInsets.all(16),
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
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              _showJoinDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6E40F3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.rocket_launch_rounded,
                  color: Color(0xFFF7F7F7),
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Ikut Lomba Sekarang',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showJoinDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Color(0xFF2A2E43),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF6E40F3).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.celebration_rounded,
                  color: Color(0xFF6E40F3),
                  size: 48,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Bergabung dengan Lomba?',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Anda akan bergabung dengan Lomba Membaca Cepat. Pastikan Anda telah membaca semua syarat dan ketentuan.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Colors.white30,
                          ),
                        ),
                      ),
                      child: Text(
                        'Batal',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        _showSuccessDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6E40F3),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Ya, Gabung!',
                        style: TextStyle(
                          color: Color(0xFFF7F7F7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  void _showSuccessDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Color(0xFF2A2E43),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 48,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Berhasil Bergabung!',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Selamat! Anda telah berhasil mendaftar dalam Lomba Membaca Cepat. Mulai baca sekarang dan raih hadiah jutaan rupiah!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.back(); // KEMBALI KE HOME
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6E40F3),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Mulai Membaca',
                    style: TextStyle(
                      color: Color(0xFFF7F7F7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showShareDialog() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xFF2A2E43),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Bagikan Event',
              style: TextStyle(
                color: Color(0xFFF7F7F7),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(Icons.link_rounded, 'Salin Link'),
                _buildShareOption(Icons.message_rounded, 'WhatsApp'),
                _buildShareOption(Icons.share_rounded, 'Lainnya'),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        Get.back();
        Get.snackbar(
          'Berhasil!',
          'Event berhasil dibagikan ke $label',
          backgroundColor: Color(0xFF2A2E43),
          colorText: Color(0xFFF7F7F7),
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF6E40F3).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Color(0xFF6E40F3),
              size: 24,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}