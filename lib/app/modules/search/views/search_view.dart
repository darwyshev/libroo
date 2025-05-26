import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart' as my_search;

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final my_search.SearchController controller = Get.find<my_search.SearchController>();
    final TextEditingController searchTextController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchHeader(controller, searchTextController),
            Expanded(
              child: Obx(() {
                if (controller.searchQuery.value.isEmpty) {
                  return _buildSearchSuggestions(controller, searchTextController);
                } else if (controller.isLoading.value) {
                  return _buildLoadingState();
                } else if (controller.searchResults.isEmpty) {
                  return _buildNoResults(controller.searchQuery.value);
                } else {
                  return _buildSearchResults(controller);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  // HEADER WIDGET UNTUK SEARCH BAR
  Widget _buildSearchHeader(my_search.SearchController controller, TextEditingController searchTextController) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFF7F7F7)),
            onPressed: () => Get.back(),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF1F2334),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF6E40F3).withOpacity(0.3)),
              ),
              child: TextField(
                controller: searchTextController,
                autofocus: true,
                style: TextStyle(color: Color(0xFFF7F7F7)),
                decoration: InputDecoration(
                  hintText: 'Cari buku, penulis, atau kategori...',
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Colors.white54),
                  suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.white54),
                          onPressed: () {
                            searchTextController.clear();
                            controller.clearSearch();
                          },
                        )
                      : SizedBox.shrink()),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) {
                  controller.performSearch(value);
                },
                onSubmitted: (value) {
                  controller.performSearch(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SEARCH SUGGESTIONS WIDGET
  Widget _buildSearchSuggestions(my_search.SearchController controller, TextEditingController searchTextController) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SEARCH TERBARU
          Obx(() {
            if (controller.searchHistory.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pencarian Terakhir',
                        style: TextStyle(
                          color: Color(0xFFF7F7F7),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => controller.clearAllHistory(),
                        child: Text(
                          'Hapus Semua',
                          style: TextStyle(
                            color: Color(0xFF6E40F3),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ...controller.searchHistory.map((query) => _buildHistoryItem(
                    query, 
                    controller, 
                    searchTextController,
                  )),
                  SizedBox(height: 24),
                ],
              );
            }
            return SizedBox.shrink();
          }),

          // SEARCH POPULAR
          Text(
            'Pencarian Populer',
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.popularSearches.map((search) => _buildPopularSearchChip(
              search, 
              controller, 
              searchTextController,
            )).toList(),
          ),
          SizedBox(height: 24),

          // KATEGORI
          Text(
            'Cari berdasarkan Kategori',
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildCategoryGrid(controller, searchTextController),
        ],
      ),
    );
  }

  // ITEM WIDGET UNTUK SEARCH HISTORY
  Widget _buildHistoryItem(String query, my_search.SearchController controller, TextEditingController searchTextController) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.history, color: Colors.white54, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                searchTextController.text = query;
                controller.performSearch(query);
              },
              child: Text(
                query,
                style: TextStyle(color: Color(0xFFF7F7F7), fontSize: 16),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white54, size: 20),
            onPressed: () => controller.removeFromHistory(query),
          ),
        ],
      ),
    );
  }

  // SEARCH CHIP POPULAR
  Widget _buildPopularSearchChip(String search, my_search.SearchController controller, TextEditingController searchTextController) {
    return GestureDetector(
      onTap: () {
        searchTextController.text = search;
        controller.performSearch(search);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFF6E40F3).withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF6E40F3).withOpacity(0.3)),
        ),
        child: Text(
          search,
          style: TextStyle(
            color: Color(0xFF6E40F3),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // GRID KATEGORI
  Widget _buildCategoryGrid(my_search.SearchController controller, TextEditingController searchTextController) {
    final categories = [
      'Kesusastraan',
      'Ilmu Sosial', 
      'Geografi & Sejarah',
      'Ilmu Murni',
      'Karya Umum',
      'Ilmu Terapan',
      'Bahasa',
      'Filsafat',
      'Ilmu Agama',
      'Kesenian Hiburan',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            searchTextController.text = categories[index];
            controller.performSearch(categories[index]);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF2A2E43),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Center(
              child: Text(
                categories[index],
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  // LOADING STATE WIDGET
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6E40F3)),
          ),
          SizedBox(height: 16),
          Text(
            'Mencari...',
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // TIDAK ADA HASIL
  Widget _buildNoResults(String query) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.white54,
          ),
          SizedBox(height: 16),
          Text(
            'Tidak ada hasil untuk "$query"',
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Coba kata kunci yang berbeda atau\nperiksa ejaan Anda',
            style: TextStyle(color: Colors.white54, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // HASIL SEARCH
  Widget _buildSearchResults(my_search.SearchController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Ditemukan ${controller.searchResults.length} hasil',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.searchResults.length,
            itemBuilder: (context, index) {
              final book = controller.searchResults[index];
              return _buildSearchResultItem(book);
            },
          ),
        ),
      ],
    );
  }

  // SEARCH ITEM 
  Widget _buildSearchResultItem(Map<String, dynamic> book) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/book-detail', arguments: book);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF2A2E43),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  book['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
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
                    'oleh ${book['author']}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color(0xFF6E40F3).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          book['category'],
                          style: TextStyle(
                            color: Color(0xFF6E40F3),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            book['rating'],
                            style: TextStyle(
                              color: Color(0xFFF7F7F7),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}