import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/book_detail_controller.dart';

class BookDetailView extends GetView<BookDetailController> {
  const BookDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: Obx(() {
        final Map<String, dynamic> book = controller.bookData.value.cast<String, dynamic>();
        if (book.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xFF6E40F3)),
                SizedBox(height: 16),
                Text(
                  'Memuat detail buku...',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          );
        }
        
        return CustomScrollView(
          slivers: [
            _buildSliverAppBar(book),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBookInfo(book),
                    SizedBox(height: 16),
                    _buildAvailabilityStatus(),
                    SizedBox(height: 24),
                    _buildActionButtons(),
                    SizedBox(height: 24),
                    _buildRatingSection(book),
                    SizedBox(height: 24),
                    _buildDescription(book),
                    SizedBox(height: 24),
                    _buildBookStats(book),
                    SizedBox(height: 24),
                    _buildSimilarBooks(),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSliverAppBar(Map<String, dynamic> book) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: Color(0xFF1F2334),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Color(0xFFF7F7F7)),
        onPressed: () => Get.back(),
      ),
      actions: [
        Obx(() => IconButton(
          icon: Icon(
            controller.isBookmarked.value ? Icons.bookmark : Icons.bookmark_border,
            color: controller.isBookmarked.value ? Color(0xFF6E40F3) : Color(0xFFF7F7F7),
          ),
          onPressed: controller.toggleBookmark,
        )),
        IconButton(
          icon: Icon(Icons.share, color: Color(0xFFF7F7F7)),
          onPressed: controller.shareBook,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1F2334),
                    Color(0xFF2A2E43),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: 200,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    book['image'] ?? 'assets/book/cover-janji.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookInfo(Map<String, dynamic> book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book['title'] ?? 'Judul Buku',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'oleh ${book['author'] ?? 'Penulis'}',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            SizedBox(width: 4),
            Text(
              book['rating']?.toString() ?? '4.5',
              style: TextStyle(
                color: Color(0xFFF7F7F7),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4),
            Text(
              '(${book['totalRatings'] ?? 0} ulasan)',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
            SizedBox(width: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF6E40F3).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                book['genre'] ?? 'Fiksi',
                style: TextStyle(
                  color: Color(0xFF6E40F3),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvailabilityStatus() {
    return Obx(() => Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: controller.isAvailable.value || controller.availableStock.value > 0
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: controller.isAvailable.value || controller.availableStock.value > 0
              ? Colors.green
              : Colors.red,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                controller.isAvailable.value || controller.availableStock.value > 0
                    ? Icons.check_circle
                    : Icons.cancel,
                color: controller.isAvailable.value || controller.availableStock.value > 0
                    ? Colors.green
                    : Colors.red,
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                controller.isAvailable.value || controller.availableStock.value > 0
                    ? 'Tersedia'
                    : 'Sedang Dipinjam',
                style: TextStyle(
                  color: controller.isAvailable.value || controller.availableStock.value > 0
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Stok: ',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                '${controller.availableStock.value}/${controller.totalStock.value}',
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          if (!controller.isAvailable.value && controller.borrowedBy.value.isNotEmpty) ...[
            SizedBox(height: 8),
            Text(
              'Dipinjam oleh: ${controller.borrowedBy.value}',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              'Pengembalian: ${controller.returnDate.value.day}/${controller.returnDate.value.month}/${controller.returnDate.value.year}',
              style: TextStyle(color: Colors.orange, fontSize: 12),
            ),
          ],
          if (controller.isCurrentUserBorrowing.value) ...[
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF6E40F3).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Anda sedang meminjam buku ini',
                style: TextStyle(
                  color: Color(0xFF6E40F3),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    ));
  }

  Widget _buildActionButtons() {
    return Obx(() => Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.isCurrentUserBorrowing.value
                ? null
                : controller.showBorrowConfirmation,
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.isCurrentUserBorrowing.value
                  ? Colors.grey
                  : Color(0xFF6E40F3),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  controller.isCurrentUserBorrowing.value
                      ? Icons.check
                      : Icons.library_books,
                  color: Color(0xFFF7F7F7),
                ),
                SizedBox(width: 8),
                Text(
                  controller.isCurrentUserBorrowing.value
                      ? 'Sudah Dipinjam'
                      : 'Pinjam',
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
        SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF6E40F3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: controller.showQRCode,
            icon: Icon(
              Icons.qr_code,
              color: Color(0xFF6E40F3),
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildRatingSection(Map<String, dynamic> book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating & Ulasan',
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
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF2A2E43),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      book['rating']?.toString() ?? '4.5',
                      style: TextStyle(
                        color: Color(0xFFF7F7F7),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (double.tryParse(book['rating']?.toString() ?? '4.5') ?? 4.5)
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${book['totalRatings'] ?? 0} ulasan',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Obx(() => controller.hasUserRated.value
                      ? Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF6E40F3).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Color(0xFF6E40F3)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Rating Anda',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < controller.userRating.value
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 20,
                                  );
                                }),
                              ),
                              SizedBox(height: 8),
                              Text(
                                controller.userRating.value.toString(),
                                style: TextStyle(
                                  color: Color(0xFF6E40F3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ElevatedButton(
                          onPressed: controller.showRatingDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6E40F3),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Color(0xFFF7F7F7), size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Beri Rating',
                                style: TextStyle(
                                  color: Color(0xFFF7F7F7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription(Map<String, dynamic> book) {
    final description = book['description'] ?? 
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Obx(() => AnimatedCrossFade(
          firstChild: Text(
            description.length > 150 ? 
            '${description.substring(0, 150)}...' : description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          secondChild: Text(
            description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          crossFadeState: controller.showFullDescription.value
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300),
        )),
        if (description.length > 150) ...[
          SizedBox(height: 8),
          GestureDetector(
            onTap: controller.toggleDescription,
            child: Obx(() => Text(
              controller.showFullDescription.value ? 'Tampilkan lebih sedikit' : 'Selengkapnya',
              style: TextStyle(
                color: Color(0xFF6E40F3),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        ],
      ],
    );
  }

  Widget _buildBookStats(Map<String, dynamic> book) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Buku',
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.menu_book,
                  label: 'Halaman',
                  value: '${book['pages'] ?? 0}',
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.language,
                  label: 'Bahasa',
                  value: book['language'] ?? 'Indonesia',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.business,
                  label: 'Penerbit',
                  value: book['publisher'] ?? '-',
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.calendar_today,
                  label: 'Tahun',
                  value: '${book['year'] ?? 0}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Color(0xFF6E40F3), size: 16),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarBooks() {
    final similarBooks = [
      {
        'title': 'Bumi',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-bumi.webp',
        'rating': '4.7',
      },
      {
        'title': 'Janji',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-janji.webp',
        'rating': '4.6',
      },
      {
        'title': 'Sesuk',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-sesuk.webp',
        'rating': '4.8',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buku Serupa',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarBooks.length,
            itemBuilder: (context, index) {
              final book = similarBooks[index];
              return Container(
                width: 140,
                margin: EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            book['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      book['title']!,
                      style: TextStyle(
                        color: Color(0xFFF7F7F7),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      book['author']!,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 12),
                        SizedBox(width: 4),
                        Text(
                          book['rating']!,
                          style: TextStyle(
                            color: Color(0xFFF7F7F7),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}