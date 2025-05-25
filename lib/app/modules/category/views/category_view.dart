import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilterSection(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF6E40F3),
                    ),
                  );
                }
                return controller.isGridView.value 
                  ? _buildBooksGrid() 
                  : _buildBooksList();
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Top bar with back button and category name
          Row(
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
              Expanded(
                child: Text(
                  controller.categoryData?['name'] ?? 'Kategori',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
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
                    size: 24,
                  ),
                  onPressed: () {
                    Get.toNamed('/search');
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Category image banner
          if (controller.categoryData?['image'] != null)
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xFF2A2E43),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      controller.categoryData!['image'],
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
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
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.categoryData?['name'] ?? '',
                          style: TextStyle(
                            color: Color(0xFFF7F7F7),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Obx(() => Text(
                          '${controller.filteredBooks.length} buku tersedia',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    final List<String> filters = ['Semua', 'Terbaru', 'Terpopuler', 'Rating Tinggi'];
    final List<String> sortOptions = ['Terbaru', 'Terlama', 'A-Z', 'Z-A', 'Rating'];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelected = controller.selectedFilter.value == filters[index];
                  return GestureDetector(
                    onTap: () => controller.changeFilter(filters[index]),
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected 
                          ? Color(0xFF6E40F3) 
                          : Color(0xFF2A2E43),
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected 
                          ? null 
                          : Border.all(color: Colors.white24),
                      ),
                      child: Text(
                        filters[index],
                        style: TextStyle(
                          color: isSelected ? Color(0xFFF7F7F7) : Colors.white70,
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          SizedBox(height: 12),
          // Sort dropdown and view toggle
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFF2A2E43),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedSort.value,
                      isExpanded: true,
                      dropdownColor: Color(0xFF2A2E43),
                      style: TextStyle(color: Color(0xFFF7F7F7)),
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                      items: sortOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            'Urutkan: $value',
                            style: TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.changeSort(newValue);
                        }
                      },
                    ),
                  )),
                ),
              ),
              SizedBox(width: 12),
              Obx(() => Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2A2E43),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: IconButton(
                  icon: Icon(
                    controller.isGridView.value 
                      ? Icons.grid_view_rounded 
                      : Icons.view_list_rounded,
                    color: Color(0xFF6E40F3),
                  ),
                  onPressed: () {
                    controller.toggleViewMode();
                  },
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBooksGrid() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Obx(() => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.45,
        ),
        itemCount: controller.filteredBooks.length,
        itemBuilder: (context, index) {
          return _buildBookGridCard(controller.filteredBooks[index]);
        },
      )),
    );
  }

  Widget _buildBooksList() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Obx(() => ListView.builder(
        itemCount: controller.filteredBooks.length,
        itemBuilder: (context, index) {
          return _buildBookListCard(controller.filteredBooks[index]);
        },
      )),
    );
  }

  Widget _buildBookGridCard(Map<String, dynamic> book) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/book-detail', arguments: book);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2A2E43),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    book['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Book info
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book['title'],
                      style: TextStyle(
                        color: Color(0xFFF7F7F7),
                        fontSize: 14,
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
                    Spacer(),
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
                            color: Color(0xFFF7F7F7),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          book['year'],
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/book-reader', arguments: book);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6E40F3),
                          padding: EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Tandai',
                          style: TextStyle(
                            color: Color(0xFFF7F7F7),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookListCard(Map<String, dynamic> book) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/book-detail', arguments: book);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF2A2E43),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Book cover
            Container(
              width: 80,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  book['image'],
                  fit: BoxFit.cover,
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
                    book['title'],
                    style: TextStyle(
                      color: Color(0xFFF7F7F7),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6),
                  Text(
                    book['author'],
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
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
                          color: Color(0xFFF7F7F7),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        '${book['pages']} hal',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      Text(
                        book['year'],
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/bookmark', arguments: book);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6E40F3),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Tandai',
                            style: TextStyle(
                              color: Color(0xFFF7F7F7),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(8),
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
    );
  }

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
            _buildNavItem(Icons.home_rounded, 'Home', false, () {
              Get.offNamed('/home');
            }),
            _buildNavItem(Icons.explore_outlined, 'Explore', false, () {
              Get.offNamed('/explore');
            }),
            _buildNavItem(Icons.bookmark_border_rounded, 'Bookmarks', false, () {
              Get.offNamed('/bookmark');
            }),
            _buildNavItem(Icons.person_outline_rounded, 'Profile', false, () {
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