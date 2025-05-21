import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});
  
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
                _buildYouMightLike(),
                SizedBox(height: 24),
                _buildCategories(),
                SizedBox(height: 24),
                _buildNewBooks(),
                // Add some padding at the bottom to ensure no overflow
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // 1. Top Bar dengan Libroo dan tombol notifikasi
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Eksplorasi',
            style: TextStyle(
              color: Colors.white, 
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
                color: Colors.white,
                size: 26,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  // 2. "Kamu Mungkin Suka" Grid 4 Buku
  Widget _buildYouMightLike() {
    final List<Map<String, dynamic>> recommendedBooks = [
      {
        'title': 'Dawn',
        'author': 'Irfan Mahardika',
        'rating': '4.7',
        'image': 'assets/book/cover-dawn.webp',
      },
      {
        'title': 'Life at the Monster Apartment',
        'author': 'Hinowa Kouzuki ',
        'rating': '4.6',
        'image': 'assets/book/cover-latma.webp',
      },
      {
        'title': 'Border v1',
        'author': 'Yua Kotegawa',
        'rating': '4.8',
        'image': 'assets/book/cover-border.webp',
      },
      {
        'title': 'Sesuk',
        'author': 'Tere Liye',
        'rating': '4.5',
        'image': 'assets/book/cover-sesuk.webp',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kamu Mungkin Suka',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF2A2E43), // Slightly lighter background
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // First row of books
              Row(
                children: [
                  Expanded(child: _buildRecommendedBookCard(recommendedBooks[0])),
                  SizedBox(width: 16),
                  Expanded(child: _buildRecommendedBookCard(recommendedBooks[1])),
                ],
              ),
              SizedBox(height: 16),
              // Second row of books
              Row(
                children: [
                  Expanded(child: _buildRecommendedBookCard(recommendedBooks[2])),
                  SizedBox(width: 16),
                  Expanded(child: _buildRecommendedBookCard(recommendedBooks[3])),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method for recommended book cards
  Widget _buildRecommendedBookCard(Map<String, dynamic> book) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1F2334),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book cover image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              book['image'],
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  book['author'],
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
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      book['rating'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Categories - 10 box dengan gambar kategori
  Widget _buildCategories() {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Kesusastraan', 'image': 'assets/category/bg-kesusastraan.webp'},
      {'name': 'Ilmu Sosial', 'image': 'assets/category/bg-ilmu-sosial.webp'},
      {'name': 'Geografi & Sejarah', 'image': 'assets/category/bg-geografi-sejarah.webp'},
      {'name': 'Ilmu Murni', 'image': 'assets/category/bg-ilmu-murni.webp'},
      {'name': 'Karya Umum', 'image': 'assets/category/bg-karya-umum.webp'},
      {'name': 'Ilmu Terapan', 'image': 'assets/category/bg-ilmu-terapan.webp'},
      {'name': 'Bahasa', 'image': 'assets/category/bg-bahasa.webp'},
      {'name': 'Filsafat', 'image': 'assets/category/bg-filsafat.webp'},
      {'name': 'Ilmu Agama', 'image': 'assets/category/bg-ilmu-agama.webp'},
      {'name': 'Kesenian Hiburan', 'image': 'assets/category/bg-kesenian-hiburan.webp'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 9/16, // Aspect ratio as specified (9:16)
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return _buildCategoryCard(categories[index]);
          },
        ),
      ],
    );
  }

  // Helper method for category cards
  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Category image with gradient overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  category['image'],
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Category name at bottom
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Text(
              category['name'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // 4. Slideshow "Buku Baru"
  Widget _buildNewBooks() {
    final List<Map<String, dynamic>> newBooks = [
      {
        'title': 'Rumah Untuk Alie',
        'author': 'Lenn Liu',
        'image': 'assets/book/cover-rua.webp',
        'color': Color(0xFF5E35B1),
      },
      {
        'title': 'Yang Telah Lama Pergi',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-ytlp.webp',
        'color': Color(0xFF43A047),
      },
      {
        'title': 'Namaku Alam',
        'author': 'Leila S. Chudori',
        'image': 'assets/book/cover-na.webp',
        'color': Color(0xFF1E88E5),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buku Baru',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newBooks.length,
            itemBuilder: (context, index) {
              return Container(
                width: 320,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: newBooks[index]['color'],
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
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Book cover image
                          Container(
                            width: 120,
                            height: 160,
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
                                newBooks[index]['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'BARU',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  newBooks[index]['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'by ${newBooks[index]['author']}',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: Text(
                                    'Baca Sekarang',
                                    style: TextStyle(
                                      color: newBooks[index]['color'],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  // Bottom Navigation Bar - Same as in home_view.dart
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
            _buildNavItem(Icons.home_rounded, 'Home', false),
            _buildNavItem(Icons.explore_outlined, 'Eksplor', true), // This one is active now
            _buildNavItem(Icons.bookmark_border_rounded, 'Bookmarks', false),
            _buildNavItem(Icons.person_outline_rounded, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {},
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