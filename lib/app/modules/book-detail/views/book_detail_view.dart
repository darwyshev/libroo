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
                    SizedBox(height: 24),
                    _buildActionButtons(),
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
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      actions: [
        Obx(() => IconButton(
          icon: Icon(
            controller.isBookmarked.value ? Icons.bookmark : Icons.bookmark_border,
            color: controller.isBookmarked.value ? Color(0xFF6E40F3) : Colors.white,
          ),
          onPressed: controller.toggleBookmark,
        )),
        IconButton(
          icon: Icon(Icons.share, color: Colors.white),
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
            color: Colors.white,
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
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
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

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.startReading,
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
                Icon(Icons.menu_book, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Mulai Baca',
                  style: TextStyle(
                    color: Colors.white,
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
            onPressed: controller.downloadBook,
            icon: Icon(
              Icons.download,
              color: Color(0xFF6E40F3),
            ),
          ),
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
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Obx(() => AnimatedCrossFade(
          firstChild: Text(
            description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.6,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
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
        SizedBox(height: 8),
        GestureDetector(
          onTap: controller.toggleDescription,
          child: Obx(() => Text(
            controller.showFullDescription.value ? 'Lihat Lebih Sedikit' : 'Lihat Selengkapnya',
            style: TextStyle(
              color: Color(0xFF6E40F3),
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
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
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Halaman', book['pages']?.toString() ?? '320'),
              ),
              Expanded(
                child: _buildStatItem('Bahasa', book['language'] ?? 'Indonesia'),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Penerbit', book['publisher'] ?? 'Gramedia'),
              ),
              Expanded(
                child: _buildStatItem('Tahun', book['year']?.toString() ?? '2023'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
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
        'title': 'Sagaras',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-sagaras.webp',
        'rating': '4.8',
      },
      {
        'title': 'Sesuk',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-sesuk.webp',
        'rating': '4.6',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buku Serupa',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarBooks.length,
            itemBuilder: (context, index) {
              final book = similarBooks[index];
              return Container(
                width: 120,
                margin: EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to book detail with new book data
                    Get.to(() => BookDetailView(), arguments: book);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          child: Image.asset(
                            book['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        book['title']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 12),
                          SizedBox(width: 2),
                          Text(
                            book['rating']!,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}