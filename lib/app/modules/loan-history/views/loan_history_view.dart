import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/loan_history_controller.dart';

class LoanHistoryView extends GetView<LoanHistoryController> {
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
                      _buildSearchBar(),
                      SizedBox(height: 16),
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

  // Search Bar
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller.searchController,
        onChanged: controller.onSearchChanged,
        style: TextStyle(color: Color(0xFFF7F7F7)),
        decoration: InputDecoration(
          hintText: 'Cari judul atau penulis buku...',
          hintStyle: TextStyle(
            color: Color(0xFFF7F7F7).withOpacity(0.5),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Color(0xFF6E40F3),
          ),
          suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: Color(0xFFF7F7F7).withOpacity(0.5),
                  ),
                  onPressed: controller.clearSearch,
                )
              : SizedBox.shrink()),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  // Summary Card dengan statistik peminjaman
  Widget _buildSummaryCard() {
    return Obx(() {
      final stats = controller.getSummaryStats();
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
                    '${stats['total']} Buku',
                    style: TextStyle(
                      color: Color(0xFFF7F7F7),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      _buildMiniStat('Aktif', '${stats['active']}'),
                      SizedBox(width: 24),
                      _buildMiniStat('Selesai', '${stats['completed']}'),
                      SizedBox(width: 24),
                      _buildMiniStat('Terlambat', '${stats['overdue']}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
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
    final filters = ['Semua', 'Aktif', 'Selesai', 'Terlambat'];
    
    return Obx(() => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isActive = controller.selectedFilter.value == filter;
          return Padding(
            padding: EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => controller.setFilter(filter),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isActive ? Color(0xFF6E40F3) : Color(0xFF2A2E43),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ));
  }

  // Loan History List
  Widget _buildLoanHistory() {
    return Obx(() {
      final loans = controller.filteredLoanHistory;
      
      if (loans.isEmpty) {
        return _buildEmptyState();
      }
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Riwayat Lengkap',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${loans.length} buku',
                style: TextStyle(
                  color: Color(0xFFF7F7F7).withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: loans.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final loan = loans[index];
              return _buildLoanItem(loan);
            },
          ),
        ],
      );
    });
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Color(0xFF6E40F3).withOpacity(0.5),
          ),
          SizedBox(height: 16),
          Text(
            'Tidak ada hasil',
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Coba ubah kata kunci atau filter pencarian',
            style: TextStyle(
              color: Color(0xFFF7F7F7).withOpacity(0.6),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoanItem(Map<String, dynamic> loan) {
    Color statusColor;
    String statusText;
    IconData statusIcon;
    Widget? fineWidget;

    if (loan['status'] == 'active') {
      if (loan['daysLeft'] < 0) {
        final daysLate = loan['daysLeft'].abs();
        final fine = controller.calculateFine(daysLate);
        statusColor = Color(0xFFE53E3E);
        statusText = 'Terlambat $daysLate hari';
        statusIcon = Icons.warning_rounded;
        
        fineWidget = Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFFE53E3E).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE53E3E).withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.attach_money_rounded,
                color: Color(0xFFE53E3E),
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                'Denda: ${controller.formatCurrency(fine)}',
                style: TextStyle(
                  color: Color(0xFFE53E3E),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
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
                image: loan['image'] != null
                    ? DecorationImage(
                        image: AssetImage(loan['image']),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: loan['image'] == null
                  ? Icon(
                      Icons.book_rounded,
                      color: Color(0xFF6E40F3),
                      size: 30,
                    )
                  : null,
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
                  if (loan['isExtended'] == true)
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.extension_rounded,
                            color: Color(0xFF43A047),
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Sudah diperpanjang',
                            style: TextStyle(
                              color: Color(0xFF43A047),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
                  // Fine information
                  if (fineWidget != null) fineWidget,
                ],
              ),
            ),
            // Action Button
            if (loan['status'] == 'active')
              Container(
                decoration: BoxDecoration(
                  color: (loan['canExtend'] == true && loan['isExtended'] != true)
                      ? Color(0xFF6E40F3).withOpacity(0.2)
                      : Color(0xFF6E40F3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: (loan['canExtend'] == true && loan['isExtended'] != true)
                        ? Color(0xFF6E40F3)
                        : Color(0xFF6E40F3).withOpacity(0.5),
                    size: 20,
                  ),
                  onPressed: () {
                    controller.extendLoan(loan['id']);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}