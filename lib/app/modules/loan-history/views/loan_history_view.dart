import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanHistoryView extends StatelessWidget {
  const LoanHistoryView({super.key});

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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      _buildSummaryCard(),
                      SizedBox(height: 24),
                      _buildFilterTabs(),
                      SizedBox(height: 16),
                      _buildLoanHistory(),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // App Bar dengan tombol back
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF6E40F3).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xFFF7F7F7),
                size: 20,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          SizedBox(width: 16),
          Text(
            'Riwayat Peminjaman',
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Summary Card dengan statistik peminjaman
  Widget _buildSummaryCard() {
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
            right: -10,
            bottom: -10,
            child: Icon(
              Icons.history_rounded,
              size: 120,
              color: Color(0xFFF7F7F7).withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Peminjaman',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '15 Buku',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    _buildMiniStat('Aktif', '3'),
                    SizedBox(width: 24),
                    _buildMiniStat('Selesai', '12'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFF7F7F7).withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // Filter Tabs
  Widget _buildFilterTabs() {
    return Row(
      children: [
        _buildFilterTab('Semua', true),
        SizedBox(width: 12),
        _buildFilterTab('Aktif', false),
        SizedBox(width: 12),
        _buildFilterTab('Selesai', false),
        SizedBox(width: 12),
        _buildFilterTab('Terlambat', false),
      ],
    );
  }

  Widget _buildFilterTab(String text, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF6E40F3) : Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFFF7F7F7),
          fontSize: 14,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  // Loan History List
  Widget _buildLoanHistory() {
    final List<Map<String, dynamic>> loanHistory = [
      {
        'title': 'Laut Bercerita',
        'author': 'Leila S. Chudori',
        'loanDate': '15 Mei 2025',
        'returnDate': '29 Mei 2025',
        'status': 'active',
        'daysLeft': 4,
        'image': 'assets/book/cover-laut-bercerita.webp',
      },
      {
        'title': 'Cantik Itu Luka',
        'author': 'Eka Kurniawan',
        'loanDate': '10 Mei 2025',
        'returnDate': '24 Mei 2025',
        'status': 'active',
        'daysLeft': -1,
        'cover': 'assets/book2.jpg',
      },
      {
        'title': 'Bumi Manusia',
        'author': 'Pramoedya Ananta Toer',
        'loanDate': '05 Mei 2025',
        'returnDate': '19 Mei 2025',
        'status': 'active',
        'daysLeft': 6,
        'cover': 'assets/book3.jpg',
      },
      {
        'title': 'Janji',
        'author': 'Tere Liye',
        'loanDate': '20 Apr 2025',
        'returnDate': '04 Mei 2025',
        'status': 'completed',
        'returnedDate': '03 Mei 2025',
        'image': 'assets/book/cover-janji.webp',
      },
      {
        'title': 'Sesuk',
        'author': 'Tere Liye',
        'loanDate': '15 Apr 2025',
        'returnDate': '29 Apr 2025',
        'status': 'completed',
        'returnedDate': '28 Apr 2025',
        'image': 'assets/book/cover-sesuk.webp',
      },
      {
        'title': 'Ronggeng Dukuh Paruk',
        'author': 'Ahmad Tohari',
        'loanDate': '10 Apr 2025',
        'returnDate': '24 Apr 2025',
        'status': 'completed',
        'returnedDate': '23 Apr 2025',
        'cover': 'assets/book6.jpg',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Riwayat Lengkap',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: loanHistory.length,
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final loan = loanHistory[index];
            return _buildLoanItem(loan);
          },
        ),
      ],
    );
  }

  Widget _buildLoanItem(Map<String, dynamic> loan) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    if (loan['status'] == 'active') {
      if (loan['daysLeft'] < 0) {
        statusColor = Color(0xFFE53E3E);
        statusText = 'Terlambat ${loan['daysLeft'].abs()} hari';
        statusIcon = Icons.warning_rounded;
      } else {
        statusColor = Color(0xFF6E40F3);
        statusText = '${loan['daysLeft']} hari lagi';
        statusIcon = Icons.schedule_rounded;
      }
    } else {
      statusColor = Color(0xFF43A047);
      statusText = 'Dikembalikan';
      statusIcon = Icons.check_circle_rounded;
    }

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF6E40F3).withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.book_rounded,
                color: Color(0xFF6E40F3),
                size: 30,
              ),
            ),
            SizedBox(width: 16),
            // Book Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loan['title'],
                    style: TextStyle(
                      color: Color(0xFFF7F7F7),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    loan['author'],
                    style: TextStyle(
                      color: Color(0xFFF7F7F7).withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: Color(0xFFF7F7F7).withOpacity(0.5),
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Dipinjam: ${loan['loanDate']}',
                        style: TextStyle(
                          color: Color(0xFFF7F7F7).withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.event_rounded,
                        color: Color(0xFFF7F7F7).withOpacity(0.5),
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        loan['status'] == 'completed'
                            ? 'Dikembalikan: ${loan['returnedDate']}'
                            : 'Jatuh tempo: ${loan['returnDate']}',
                        style: TextStyle(
                          color: Color(0xFFF7F7F7).withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Status Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          statusIcon,
                          color: statusColor,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Action Button
            if (loan['status'] == 'active')
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF6E40F3).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: Color(0xFF6E40F3),
                    size: 20,
                  ),
                  onPressed: () {
                    Get.snackbar(
                      'Perpanjang',
                      'Fitur perpanjangan akan segera tersedia',
                      backgroundColor: Color(0xFF2A2E43),
                      colorText: Color(0xFFF7F7F7),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}