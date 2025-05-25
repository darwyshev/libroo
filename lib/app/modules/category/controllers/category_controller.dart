import 'package:get/get.dart';

class CategoryController extends GetxController {
  // Receive category data from arguments
  Map<String, dynamic>? categoryData;
  
  // Observable list for books in this category
  final RxList<Map<String, dynamic>> categoryBooks = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredBooks = <Map<String, dynamic>>[].obs;
  
  // Loading state
  final RxBool isLoading = false.obs;
  
  // View mode toggle (true = grid, false = list)
  final RxBool isGridView = true.obs;
  
  // Filter options
  final RxString selectedFilter = 'Semua'.obs;
  final RxString selectedSort = 'Terbaru'.obs;
  
  @override
  void onInit() {
    super.onInit();
    categoryData = Get.arguments;
    loadCategoryBooks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  
  void loadCategoryBooks() {
    isLoading.value = true;
    
    Future.delayed(Duration(seconds: 1), () {
      categoryBooks.value = _getDummyBooks();
      applyFiltersAndSort();
      isLoading.value = false;
    });
  }
  
  List<Map<String, dynamic>> _getDummyBooks() {
    return [
      {
        'title': 'Dona Dona',
        'author': 'Toshikazu Kawaguchi',
        'rating': '4.8',
        'image': 'assets/book/cover-donadona.webp',
        'year': '2005',
        'pages': '529',
        'isPopular': true,
      },
      {
        'title': 'Laut Bercerita',
        'author': 'Leila S. Chudori',
        'rating': '4.7',
        'image': 'assets/book/cover-laut-bercerita.webp',
        'year': '2006',
        'pages': '342',
        'isPopular': true,
      },
      {
        'title': 'Teman',
        'author': 'Jounatan dan Guntur Alam',
        'rating': '4.5',
        'image': 'assets/book/cover-teman.webp',
        'year': '2003',
        'pages': '268',
        'isPopular': false,
      },
      {
        'title': 'Hujan',
        'author': 'Tere Liye',
        'rating': '4.6',
        'image': 'assets/book/cover-hujan.webp',
        'year': '2004',
        'pages': '418',
        'isPopular': true,
      },
      {
        'title': '7 Prajurit Bapak',
        'author': 'Wulan Nur Amalia',
        'rating': '4.4',
        'image': 'assets/book/cover-7pb.webp',
        'year': '2009',
        'pages': '456',
        'isPopular': false,
      },
      {
        'title': 'Dawn',
        'author': 'Irfan Mahardika',
        'rating': '4.7',
        'image': 'assets/book/cover-dawn.webp',
        'year': '2009',
        'pages': '423',
        'isPopular': true,
      },
      {
        'title': 'Life at the Monster Apartment',
        'author': 'Hinowa Kouzuki',
        'rating': '4.6',
        'image': 'assets/book/cover-latma.webp',
        'year': '2010',
        'pages': '312',
        'isPopular': false,
      },
      {
        'title': 'Border v1',
        'author': 'Yua Kotegawa',
        'rating': '4.8',
        'image': 'assets/book/cover-border.webp',
        'year': '2011',
        'pages': '289',
        'isPopular': true,
      },
      {
        'title': 'Sesuk',
        'author': 'Tere Liye',
        'rating': '4.5',
        'image': 'assets/book/cover-sesuk.webp',
        'year': '2012',
        'pages': '378',
        'isPopular': false,
      },
      {
        'title': 'Rumah Untuk Alie',
        'author': 'Lenn Liu',
        'rating': '4.4',
        'image': 'assets/book/cover-rua.webp',
        'year': '2013',
        'pages': '450',
        'isPopular': false,
      },
      {
        'title': "Yang Telah Lama Pergi",
        "author": "Tere Liye",
        "rating": "4.6",
        "image": "assets/book/cover-ytlp.webp",
        "year": "2014",
        "pages": "500",
        "isPopular": true,
      },
      {
        "title": "Namaku Alam",
        "author": "Leila S. Chudori",
        "rating": "4.7",
        "image": "assets/book/cover-na.webp",
        "year": "2015",
        "pages": "420",
        "isPopular": true,
      }
    ];
  }
  
  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }
  
  void changeFilter(String filter) {
    selectedFilter.value = filter;
    applyFiltersAndSort();
  }
  
  void changeSort(String sort) {
    selectedSort.value = sort;
    applyFiltersAndSort();
  }
  
  void applyFiltersAndSort() {
    List<Map<String, dynamic>> books = List.from(categoryBooks);
    
    // Apply filters
    switch (selectedFilter.value) {
      case 'Terpopuler':
        books = books.where((book) => book['isPopular'] == true).toList();
        break;
      case 'Rating Tinggi':
        books = books.where((book) => double.parse(book['rating']) >= 4.6).toList();
        break;
      case 'Terbaru':
        books = books.where((book) => int.parse(book['year']) >= 2010).toList();
        break;
      case 'Semua':
      default:
        // Show all books
        break;
    }
    
    // Apply sorting
    switch (selectedSort.value) {
      case 'Terbaru':
        books.sort((a, b) => int.parse(b['year']).compareTo(int.parse(a['year'])));
        break;
      case 'Terlama':
        books.sort((a, b) => int.parse(a['year']).compareTo(int.parse(b['year'])));
        break;
      case 'A-Z':
        books.sort((a, b) => a['title'].toString().compareTo(b['title'].toString()));
        break;
      case 'Z-A':
        books.sort((a, b) => b['title'].toString().compareTo(a['title'].toString()));
        break;
      case 'Rating':
        books.sort((a, b) => double.parse(b['rating']).compareTo(double.parse(a['rating'])));
        break;
    }
    
    filteredBooks.value = books;
  }
}