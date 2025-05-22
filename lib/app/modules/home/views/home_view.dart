import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  
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
                _buildEventBox(),
                SizedBox(height: 24),
                _buildRecommendedBooks(),
                SizedBox(height: 24),
                _buildBestChoices(),
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
            'Libroo',
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
                Icons.notifications_outlined,
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

  // 2. Box Event yang menarik - Made responsive
  Widget _buildEventBox() {
    return Container(
      width: double.infinity,
      // Remove fixed height to allow container to size based on content
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
              Icons.auto_stories_rounded,
              size: 150,
              color: Color(0xFFFFFFFF).withOpacity(0.1),
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
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Terbaru',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Lomba Membaca Cepat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Ikuti lomba membaca cepat dan dapatkan hadiah menarik!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Info Lebih Lanjut',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 18,
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

  // 3. Slideshow Rekomendasi Buku
  Widget _buildRecommendedBooks() {
    final List<Map<String, dynamic>> books = [
      {
        'title': 'Janji',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-janji.webp',
        'color': Color(0xFF5E35B1),
      },
      {
        'title': 'Laut Bercerita',
        'author': 'Leila S. Chudori',
        'image': 'assets/book/cover-laut-bercerita.webp',
        'color': Color(0xFF43A047),
      },
      {
        'title': 'Sesuk',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-sesuk.webp',
        'color': Color(0xFF1E88E5),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rekomendasi Buku',
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
            itemCount: books.length,
            itemBuilder: (context, index) {
              return Container(
                width: 320,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: books[index]['color'],
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
                          // Actual book cover image
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
                            // Using actual image from assets
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                books[index]['image'],
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
                                Text(
                                  books[index]['title'],
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
                                  'by ${books[index]['author']}',
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
                                    'Tandai',
                                    style: TextStyle(
                                      color: books[index]['color'],
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

  // 4. Grid 4 Buku Terbaik - Fixed to prevent overflow
  Widget _buildBestChoices() {
    final List<Map<String, dynamic>> bestBooks = [
      {
        'title': 'Sagaras',
        'author': 'Tere Liye',
        'rating': '4.8',
        'image': 'assets/book/cover-sagaras.webp',
      },
      {
        'title': 'Bumi',
        'author': 'Tere Liye',
        'rating': '4.7',
        'image': 'assets/book/cover-bumi.webp',
      },
      {
        'title': 'Dan Hujan Pun Berhenti',
        'author': 'Farida Susanti',
        'rating': '4.6',
        'image': 'assets/book/cover-dhpb.webp',
      },
      {
        'title': 'Senandung Talijiwo',
        'author': 'Sujiwo Tejo',
        'rating': '4.9',
        'image': 'assets/book/cover-senandung-talijiwo.webp',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buku Terbaik',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        // Using a ListView.builder instead of GridView for more flexibility on smaller screens
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: (bestBooks.length / 2).ceil(), // Calculate number of rows
          itemBuilder: (context, rowIndex) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  // First item in row
                  Expanded(
                    child: _buildBookCard(bestBooks[rowIndex * 2]),
                  ),
                  SizedBox(width: 16),
                  // Second item in row (if exists)
                  Expanded(
                    child: rowIndex * 2 + 1 < bestBooks.length
                        ? _buildBookCard(bestBooks[rowIndex * 2 + 1])
                        : Container(), // Empty container if no second item
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Helper method to build individual book cards
  Widget _buildBookCard(Map<String, dynamic> book) {
    return AspectRatio(
      aspectRatio: 0.75, // Keep same aspect ratio as before
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
                // Book cover image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    // Using actual image instead of placeholder
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
                          color: Colors.white,
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
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
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
                              color: Colors.white,
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
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF6E40F3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'BEST CHOICE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
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
            _buildNavItem(Icons.home_rounded, 'Home', true),
            _buildNavItem(Icons.explore_outlined, 'Explore', false),
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