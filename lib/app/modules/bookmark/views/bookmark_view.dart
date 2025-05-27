import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({super.key});
  
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
                _buildBookmarkStats(),
                SizedBox(height: 24),
                _buildRecentBookmarks(),
                SizedBox(height: 24),
                _buildAllBookmarks(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // TOP BAR
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ditandai',
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
                Icons.search,
                color: Color(0xFFF7F7F7),
                size: 26,
              ),
              onPressed: () {
                Get.toNamed('/search');
              },
            ),
          ),
        ],
      ),
    );
  }

  // STATISTIK BOOKMARK
  Widget _buildBookmarkStats() {
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
              Icons.bookmark_rounded,
              size: 150,
              color: Color(0xFFF7F7F7).withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Total',
                    style: TextStyle(
                      color: Color(0xFFF7F7F7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '12 Buku Tersimpan',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Kumpulan buku favoritmu yang telah kamu tandai untuk dibaca nanti',
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

  // BOOKMARK TERKINI
  Widget _buildRecentBookmarks() {
    final List<Map<String, dynamic>> recentBooks = [
      {
        'title': 'Dawn',
        'author': 'Irfan Mahardika',
        'image': 'assets/book/cover-dawn.webp',
        'color': Color(0xFF5E35B1),
        'dateAdded': '2 hari lalu',
      },
      {
        'title': 'Life at the Monster Apartment',
        'author': 'Hinowa Kouzuki',
        'image': 'assets/book/cover-latma.webp',
        'color': Color(0xFF43A047),
        'dateAdded': '3 hari lalu',
      },
      {
        'title': 'Border v1',
        'author': 'Yua Kotegawa',
        'image': 'assets/book/cover-border.webp',
        'color': Color(0xFF1E88E5),
        'dateAdded': '1 minggu lalu',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,  
      children: [
        Text(
          'Bookmark Terbaru',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recentBooks.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed('/book-detail', arguments: recentBooks[index]);
                },
                child: Container(
                  width: 320,
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: recentBooks[index]['color'],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  recentBooks[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF7F7F7).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      recentBooks[index]['dateAdded'],
                                      style: TextStyle(
                                        color: Color(0xFFF7F7F7),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    recentBooks[index]['title'],
                                    style: TextStyle(
                                      color: Color(0xFFF7F7F7),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'by ${recentBooks[index]['author']}',
                                    style: TextStyle(
                                      color: Color(0xFFF7F7F7).withOpacity(0.8),
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.toNamed('/book-detail', arguments: recentBooks[index]);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFF7F7F7),
                                            padding: EdgeInsets.symmetric(vertical: 8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                          ),
                                          child: Text(
                                            'Pinjam',
                                            style: TextStyle(
                                              color: recentBooks[index]['color'],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF7F7F7).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            // HAPUS DARI BOOKMARK
                                            _showRemoveBookmarkDialog(recentBooks[index]);
                                          },
                                          icon: Icon(
                                            Icons.bookmark_remove,
                                            color: Color(0xFFF7F7F7),
                                            size: 20,
                                          ),
                                          padding: EdgeInsets.all(8),
                                          constraints: BoxConstraints(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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

  // GRID LAYOUT SEMUA BOOKMARK
  Widget _buildAllBookmarks() {
    final List<Map<String, dynamic>> allBookmarks = [
      {
        'title': 'Sagaras',
        'author': 'Tere Liye',
        'rating': '4.8',
        'image': 'assets/book/cover-sagaras.webp',
        'dateAdded': '1 minggu lalu',
      },
      {
        'title': 'Bumi',
        'author': 'Tere Liye',
        'rating': '4.7',
        'image': 'assets/book/cover-bumi.webp',
        'dateAdded': '2 minggu lalu',
      },
      {
        'title': 'Dan Hujan Pun Berhenti',
        'author': 'Farida Susanti',
        'rating': '4.6',
        'image': 'assets/book/cover-dhpb.webp',
        'dateAdded': '3 minggu lalu',
      },
      {
        'title': 'Senandung Talijiwo',
        'author': 'Sujiwo Tejo',
        'rating': '4.9',
        'image': 'assets/book/cover-senandung-talijiwo.webp',
        'dateAdded': '1 bulan lalu',
      },
      {
        'title': 'Janji',
        'author': 'Tere Liye',
        'rating': '4.5',
        'image': 'assets/book/cover-janji.webp',
        'dateAdded': '1 bulan lalu',
      },
      {
        'title': 'Laut Bercerita',
        'author': 'Leila S. Chudori',
        'rating': '4.8',
        'image': 'assets/book/cover-laut-bercerita.webp',
        'dateAdded': '2 bulan lalu',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Semua Bookmark',
              style: TextStyle(
                color: Color(0xFFF7F7F7),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // OPSI FILTER
                _showSortOptions();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.sort,
                    color: Color(0xFF6E40F3),
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Urutkan',
                    style: TextStyle(
                      color: Color(0xFF6E40F3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: (allBookmarks.length / 2).ceil(),
          itemBuilder: (context, rowIndex) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  // ITEM PERTAMA DI BARIS
                  Expanded(
                    child: _buildBookmarkCard(allBookmarks[rowIndex * 2]),
                  ),
                  SizedBox(width: 16),
                  // ITEM KEDUA DI BARIS
                  Expanded(
                    child: rowIndex * 2 + 1 < allBookmarks.length
                        ? _buildBookmarkCard(allBookmarks[rowIndex * 2 + 1])
                        : Container(),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // METODE UNTUK CARD BOOKMARK
  Widget _buildBookmarkCard(Map<String, dynamic> book) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/book-detail', arguments: book);
      },
      child: AspectRatio(
        aspectRatio: 0.75,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2A2E43),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Image.asset(
                        book['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['title'],
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
                          book['author'],
                          style: TextStyle(
                            color: Color(0xFFF7F7F7).withOpacity(0.7),
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  book['rating'],
                                  style: TextStyle(
                                    color: Color(0xFFF7F7F7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              book['dateAdded'],
                              style: TextStyle(
                                color: Color(0xFFF7F7F7).withOpacity(0.6),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF6E40F3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.bookmark,
                  color: Color(0xFFF7F7F7),
                  size: 16,
                ),
              ),
            ),
            // TOMBOL HAPUS
            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  _showRemoveBookmarkDialog(book);
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Color(0xFFF7F7F7),
                    size: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // DIALOG KONFIRMASI HAPUS BOOKMARK
  void _showRemoveBookmarkDialog(Map<String, dynamic> book) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Color(0xFF2A2E43),
        title: Text(
          'Hapus Bookmark',
          style: TextStyle(color: Color(0xFFF7F7F7)),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus "${book['title']}" dari bookmark?',
          style: TextStyle(color: Color(0xFFF7F7F7).withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Batal',
              style: TextStyle(color: Color(0xFFF7F7F7).withOpacity(0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Berhasil',
                'Bookmark berhasil dihapus',
                backgroundColor: Color(0xFF6E40F3),
                colorText: Color(0xFFF7F7F7),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'Hapus',
              style: TextStyle(color: Color(0xFFF7F7F7)),
            ),
          ),
        ],
      ),
    );
  }

  // DIALOG OPSI SORT
  void _showSortOptions() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Color(0xFF2A2E43),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Urutkan Berdasarkan',
              style: TextStyle(
                color: Color(0xFFF7F7F7),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildSortOption('Terbaru', Icons.access_time),
            _buildSortOption('Judul A-Z', Icons.sort_by_alpha),
            _buildSortOption('Rating Tertinggi', Icons.star),
            _buildSortOption('Penulis', Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF6E40F3)),
      title: Text(
        title,
        style: TextStyle(color: Color(0xFFF7F7F7)),
      ),
      onTap: () {
        Get.back();
        Get.snackbar(
          'Info',
          'Diurutkan berdasarkan $title',
          backgroundColor: Color(0xFF6E40F3),
          colorText: Color(0xFFF7F7F7),
        );
      },
    );
  }

  // BAR NAVIGASI BAWAH
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
            _buildNavItem(Icons.home_rounded, 'Beranda', false, () {
              Get.offNamed('/home');
            }),
            _buildNavItem(Icons.explore_outlined, 'Eksplor', false, () {
              Get.offNamed('/explore');
            }),
            _buildNavItem(Icons.bookmark_border_rounded, 'Ditandai', true, () {
              // TERLANJUR DI PAGE BOOKMARK BOLO
            }),
            _buildNavItem(Icons.person_outline_rounded, 'Profil', false, () {
              Get.offNamed('/profile');
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
              color: isActive ? Color(0xFF6E40F3) : Color(0xFFF7F7F7).withOpacity(0.54),
              size: 26,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Color(0xFF6E40F3) : Color(0xFFF7F7F7).withOpacity(0.54),
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