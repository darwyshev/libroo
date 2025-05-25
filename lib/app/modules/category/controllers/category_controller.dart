import 'package:get/get.dart';

class CategoryController extends GetxController {
  // Receive category data from arguments
  Map<String, dynamic>? categoryData;
  
  // Observable list for books in this category
  final RxList<Map<String, dynamic>> categoryBooks = <Map<String, dynamic>>[].obs;
  
  // Loading state
  final RxBool isLoading = false.obs;
  
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
      },
      {
        'title': 'Laut Bercerita',
        'author': 'Leila S. Chudori',
        'rating': '4.7',
        'image': 'assets/book/cover-laut-bercerita.webp',
        'year': '2006',
        'pages': '342',
      },
      {
        'title': 'Teman',
        'author': 'Jounatan dan Guntur Alam',
        'rating': '4.5',
        'image': 'assets/book/cover-teman.webp',
        'year': '2003',
        'pages': '268',
      },
      {
        'title': 'Hujan',
        'author': 'Tere Liye',
        'rating': '4.6',
        'image': 'assets/book/cover-hujan.webp',
        'year': '2004',
        'pages': '418',
      },
      {
        'title': '7 Prajurit Bapak',
        'author': 'Wulan Nur Amalia',
        'rating': '4.4',
        'image': 'assets/book/cover-7pb.webp',
        'year': '2009',
        'pages': '456',
      },
      {
        'title': 'Dawn',
        'author': 'Irfan Mahardika',
        'rating': '4.7',
        'image': 'assets/book/cover-dawn.webp',
        'year': '2009',
        'pages': '423',
      },
      {
        'title': 'Life at the Monster Apartment',
        'author': 'Hinowa Kouzuki',
        'rating': '4.6',
        'image': 'assets/book/cover-latma.webp',
        'year': '2010',
        'pages': '312',
      },
      {
        'title': 'Border v1',
        'author': 'Yua Kotegawa',
        'rating': '4.8',
        'image': 'assets/book/cover-border.webp',
        'year': '2011',
        'pages': '289',
      },
      {
        'title': 'Sesuk',
        'author': 'Tere Liye',
        'rating': '4.5',
        'image': 'assets/book/cover-sesuk.webp',
        'year': '2012',
        'pages': '378',
      },
      {
        'title': 'Rumah Untuk Alie',
        'author': 'Lenn Liu',
        'rating': '4.4',
        'image': 'assets/book/cover-rua.webp',
        'year': '2013',
        'pages': '450',
      },
      {
        'title': "Yang Telah Lama Pergi",
        "author": "Tere Liye",
        "rating": "4.6",
        "image": "assets/book/cover-ytlp.webp",
        "year": "2014",
        "pages": "500",
      },
      {
        "title": "Namaku Alam",
        "author": "Leila S. Chudori",
        "rating": "4.7",
        "image": "assets/book/cover-na.webp",
        "year": "2015",
        "pages": "420",
      }
    ];
  }
  
  void changeFilter(String filter) {
    selectedFilter.value = filter;
    // Apply filter logic here
  }
  
  void changeSort(String sort) {
    selectedSort.value = sort;
    // Apply sort logic here
  }
}