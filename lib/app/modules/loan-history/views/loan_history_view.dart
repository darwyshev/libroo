import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/loan_history_controller.dart';

class LoanHistoryView extends GetView<HistoryController> {
  const LoanHistoryView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildSearchAndFilter(),
            Expanded(
              child: Obx(() => controller.isLoading.value
                  ? _buildLoadingState()
                  : _buildHistoryList()),
            ),
          ],
        ),
      ),
    );
  }

  // Top Bar dengan back button dan title
  Widget _buildTopBar() {
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
              onPressed: () => Get.back(),
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

  // Search bar dan filter
  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF2A2E43),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              onChanged: controller.updateSearchQuery,
              style: TextStyle(color: Color(0xFFF7F7F7)),
              decoration: InputDecoration(
                hintText: 'Cari judul atau penulis...',
                hintStyle: TextStyle(color: Color(0xFFF7F7F7).withOpacity(0.6)),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Color(0xFF6E40F3),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          SizedBox(height: 16),
          // Filter chips
          Container(
            height: 50,
            child: Obx(() => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.filterOptions.length,
              itemBuilder: (context, index) {
                final filter = controller.filterOptions[index];
                final isSelected = controller.selectedFilter.value == filter;
                
                return Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Color(0xFFF7F7F7) : Color(0xFFF7F7F7).withOpacity(0.7),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      controller.updateFilter(filter);
                    },
                    backgroundColor: Color(0xFF2A2E43),
                    selectedColor: Color(0xFF6E40F3),
                    checkmarkColor: Color(0xFFF7F7F7),
                    side: BorderSide(
                      color: isSelected ? Color(0xFF6E40F3) : Color(0xFF2A2E43),
                    ),
                  ),
                );
              },
            )),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  // Loading state
  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: Color(0xFF6E40F3),
      ),
    );
  }

  // History list
  Widget _buildHistoryList() {
    return Obx(() {
      final filteredItems = controller.filteredHistory;
      
      if (filteredItems.isEmpty) {
        return _buildEmptyState();
      }
      
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return _buildHistoryItem(item);
        },
      );
    });
  }

  // Empty state
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_rounded,
            size: 80,
            color: Color(0xFFF7F7F7).withOpacity(0.3),
          ),
          SizedBox(height: 16),
          Text(
            'Tidak ada riwayat ditemukan',
            style: TextStyle(
              color: Color(0xFFF7F7F7).withOpacity(0.7),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Coba ubah filter atau kata kunci pencarian',
            style: TextStyle(
              color: Color(0xFFF7F7F7).withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // History item card
  Widget _buildHistoryItem(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book cover
                Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF6E40F3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      item['bookTitle'][0],
                      style: TextStyle(
                        color: Color(0xFFF7F7F7),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Book info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['bookTitle'],
                        style: TextStyle(
                          color: Color(0xFFF7F7F7),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        item['author'],
                        style: TextStyle(
                          color: Color(0xFFF7F7F7).withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildStatusChip(item['status']),
                    ],
                  ),
                ),
                // Status icon
                _buildStatusIcon(item['status']),
              ],
            ),
            SizedBox(height: 16),
            _buildItemDetails(item),
            if (_shouldShowActions(item['status']))
              _buildActionButtons(item),
          ],
        ),
      ),
    );
  }

  // Status chip
  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status) {
      case 'Dipinjam':
        chipColor = Color(0xFF2196F3);
        break;
      case 'Dikembalikan':
        chipColor = Color(0xFF43A047);
        break;
      case 'Terlambat':
        chipColor = Color(0xFFE53E3E);
        break;
      case 'Reservasi':
        chipColor = Color(0xFFFF9800);
        break;
      default:
        chipColor = Color(0xFF6E40F3);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: chipColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Status icon
  Widget _buildStatusIcon(String status) {
    IconData icon;
    Color color;
    
    switch (status) {
      case 'Dipinjam':
        icon = Icons.schedule_rounded;
        color = Color(0xFF2196F3);
        break;
      case 'Dikembalikan':
        icon = Icons.check_circle_rounded;
        color = Color(0xFF43A047);
        break;
      case 'Terlambat':
        icon = Icons.warning_rounded;
        color = Color(0xFFE53E3E);
        break;
      case 'Reservasi':
        icon = Icons.bookmark_rounded;
        color = Color(0xFFFF9800);
        break;
      default:
        icon = Icons.help_outline_rounded;
        color = Color(0xFF6E40F3);
    }

    return Icon(
      icon,
      color: color,
      size: 24,
    );
  }

  // Item details based on status
  Widget _buildItemDetails(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF1F2334),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          if (item['status'] == 'Reservasi') ...[
            _buildDetailRow('Tanggal Reservasi', item['reservationDate']),
            _buildDetailRow('Estimasi Tersedia', item['estimatedAvailable']),
          ] else ...[
            _buildDetailRow('Tanggal Pinjam', item['borrowDate']),
            _buildDetailRow('Batas Kembali', item['returnDate']),
            if (item['actualReturnDate'] != null)
              _buildDetailRow('Tanggal Kembali', item['actualReturnDate']),
          ],
          if (item['status'] == 'Dipinjam')
            _buildDetailRow('Sisa Hari', '${item['daysLeft']} hari'),
          if (item['fine'] > 0)
            _buildDetailRow('Denda', 'Rp ${item['fine']}', isHighlight: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFFF7F7F7).withOpacity(0.7),
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isHighlight ? Color(0xFFE53E3E) : Color(0xFFF7F7F7),
              fontSize: 12,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Check if should show action buttons
  bool _shouldShowActions(String status) {
    return status == 'Dipinjam' || status == 'Terlambat' || status == 'Reservasi';
  }

  // Action buttons
  Widget _buildActionButtons(Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Row(
        children: [
          if (item['status'] == 'Dipinjam') ...[
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.extendBorrow(item['id']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6E40F3),
                  foregroundColor: Color(0xFFF7F7F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Perpanjang'),
              ),
            ),
          ],
          if (item['status'] == 'Terlambat') ...[
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.payFine(item['id']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE53E3E),
                  foregroundColor: Color(0xFFF7F7F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Bayar Denda'),
              ),
            ),
          ],
          if (item['status'] == 'Reservasi') ...[
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.cancelReservation(item['id']),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFFE53E3E),
                  side: BorderSide(color: Color(0xFFE53E3E)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Batalkan'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}