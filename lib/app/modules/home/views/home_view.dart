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
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // TOP BAR DENGAN JUDUL DAN NOTIF
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Libroo',
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
                Icons.notifications_outlined,
                color: Color(0xFFF7F7F7),
                size: 26,
              ),
              onPressed: () {
                Get.toNamed('/notification');
              },
            ),
          ),
        ],
      ),
    );
  }

  // BOX EVENT
  Widget _buildEventBox() {
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
                    color: Color(0xFFF7F7F7).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Terbaru',
                    style: TextStyle(
                      color: Color(0xFFF7F7F7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Lomba Membaca Cepat',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Ikuti lomba membaca cepat dan dapatkan hadiah menarik!',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7).withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Get.toNamed('/event'),
                  child: Row(
                    children: [
                      Text(
                        'Info Lebih Lanjut',
                        style: TextStyle(
                          color: Color(0xFFF7F7F7),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_forward_rounded, color: Color(0xFFF7F7F7)),
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

  // SLIDESHOW REKOMENDASI BUKU
  Widget _buildRecommendedBooks() {
    final List<Map<String, dynamic>> books = [
      {
        'title': 'Janji',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-janji.webp',
        'color': Color(0xFF5E35B1),
        'rating': '4.8',
        'genre': 'Fiksi',
        'description':
            'Sebuah cerita yang mengharukan tentang janji dan pengorbanan.',
        'pages': 320,
        'language': 'Indonesia',
        'publisher': 'Gramedia Pustaka Utama',
        'year': 2023,
      },
      {
        'title': 'Laut Bercerita',
        'author': 'Leila S. Chudori',
        'image': 'assets/book/cover-laut-bercerita.webp',
        'color': Color(0xFF43A047),
        'rating': '4.7',
        'genre': 'Sejarah',
        'description':
            'Novel yang mengisahkan perjuangan para aktivis di masa Orde Baru.',
        'pages': 394,
        'language': 'Indonesia',
        'publisher': 'Kepustakaan Populer Gramedia',
        'year': 2017,
      },
      {
        'title': 'Sesuk',
        'author': 'Tere Liye',
        'image': 'assets/book/cover-sesuk.webp',
        'color': Color(0xFF1E88E5),
        'rating': '4.6',
        'genre': 'Fiksi',
        'description': 'Kelanjutan petualangan dari serial Bumi Manusia.',
        'pages': 280,
        'language': 'Indonesia',
        'publisher': 'Gramedia Pustaka Utama',
        'year': 2022,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rekomendasi Buku',
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
                          color: Color(0xFFF7F7F7).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // COVER BUKU DENGAN NAVIGASI
                          GestureDetector(
                            onTap: () {
                              // BIAR KE HALAMAN DETAIL BOLO
                              Get.toNamed(
                                '/book-detail',
                                arguments: books[index],
                              );
                            },
                            child: Container(
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
                                  books[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      '/book-detail',
                                      arguments: books[index],
                                    );
                                  },
                                  child: Text(
                                    books[index]['title'],
                                    style: TextStyle(
                                      color: Color(0xFFF7F7F7),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'by ${books[index]['author']}',
                                  style: TextStyle(
                                    color: Color(0xFFF7F7F7).withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    // TANDAI BUKU KE BOOKMARK
                                    _showBookmarkNotification(
                                      books[index]['title'],
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFF7F7F7),
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

  // METODE UNTUK MENAMPILKAN NOTIFIKASI BOOKMARK
  void _showBookmarkNotification(String bookTitle) {
    Get.snackbar(
      'Berhasil Ditandai!',
      'Buku "$bookTitle" telah ditambahkan ke daftar bookmark Anda',
      backgroundColor: Color(0xFF2A2E43),
      colorText: Color(0xFFF7F7F7),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.bookmark_added, color: Color(0xFF6E40F3)),
      mainButton: TextButton(
        onPressed: () {
          Get.closeCurrentSnackbar();
          Get.toNamed('/bookmark'); // Navigate to bookmark page
        },
        child: Text(
          'Lihat',
          style: TextStyle(
            color: Color(0xFF6E40F3),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 4 GRID BUKU TERBAIK 
  Widget _buildBestChoices() {
    final List<Map<String, dynamic>> bestBooks = [
      {
        'title': 'Sagaras',
        'author': 'Tere Liye',
        'rating': '4.8',
        'image': 'assets/book/cover-sagaras.webp',
        'genre': 'Fiksi',
        'description': 
          'Pertanyaan-pertanyaan seperti “kemana orang tua Ali?”, “Apa orang tua Ali masih hidup?”, atau “dari Klan manakah Ali berasal?” akan terjawab di buku ini. Di buku ke-13 serial BUMI, akhirnya, siapa orang tua Ali dijawab di buku ini. Ali, bertahun-tahun, berusaha memecahkan misteri itu. Kali ini, Ali melupakan sekolah. Sudah 3 hari ia tidak hadir di sekolah, membolos. Raib dan Seli tentu tidak akan membiarkan Ali sendirian memecahkan misteri tersebut, seperti layaknya sahabat sejati. Memulai perjalanannya, mereka berusaha mencari orang tuanya dan letak klan SagaraS. Dan jangan lupakan, Batozar alias Master B, dengan segenap kalimat kasar, seolah tidak peduli, dia selalu siap membela. Diceritakan pula dalam buku ini, alasan mengapa Master B atau Batozoar memiliki wajah yang seram, serta munculnya kedekatan hubungan antara Master B dengan Ali, Seli, dan Raib. Penuh drama, perasaan yang dimainkan di dalam buku ini sangatlah beragam. Tapi bagaimana jika misteri itu terhadang tembok kokoh Sagaras? Dan mereka harus bertarung hidup-mati lima ronde melawan Ksatria SagaraS?',
        'pages': 356,
        'language': 'Indonesia',
        'publisher': 'Gramedia Pustaka Utama',
        'year': 2021,
      },
      {
        'title': 'Bumi',
        'author': 'Tere Liye',
        'rating': '4.7',
        'image': 'assets/book/cover-bumi.webp',
        'genre': 'Fiksi',
        'description':
          'Tere Liye kembali mengkreasikan imajinasinya kedalam kedalam beberapa rangkaian novel. Bumi, merupakan rangkaian awal dari kisah sekelompok anak remaja berkemampuan istimewa. Menceritakan tentang Raib, Ali, dan Seli yang bertualang ke dunia paralel. Mereka yang istimewa, mampu pergi ke dunia pararel bumi, bertemu dengan klan lain dan berhadapan dengan Tamus yang memiliki ambisi membebaskan si Tanpa Mahkota dan kemudian, menguasai bumi. Perkenalkan, Raib, seorang gadis belia berusia lima belas tahun yang tidak biasa. Dia bisa menghilang. Jangan beritahu siapapun, Itu adalah rahasia terbesar yang tak pernah ia ceritakan pada siapapun, termasuk kedua orangtuanya. Kehidupannya tetap berjalan normal, meskipun untuk dirinya sendiri. Tidak jarang Raib menjahili orang tuanya dengan tiba-tiba menghilang, lalu muncul kembali secara tiba-tiba membuat kaget kedua orangtuanya. Tidak hanya menyuguhkan cerita fantasi, novel ini juga memberikan pesan moral tentang keluarga, dan persahabatan. Tere Liye sukses membangun kisah persahabatan antara Raib, Ali, dan Seli terasa nyata. Hubungan antara Raib dan keluarganya membuat pembaca penasaran sekaligus tersadar akan cara berkomunikasi dengan orang tua. Tere Liye memberikan banyak kejutan di tiap halaman yang direpresentasikan oleh Raib, membuat pembaca dapat menikmati cerita yang seolah tidak akan ada habisnya. Tere Liye berhasil meracik buku ini sebagai bahan baca para pecinta novel sastra maupun fantasi.',
        'pages': 440,
        'language': 'Indonesia',
        'publisher': 'Gramedia Pustaka Utama',
        'year': 2014,
      },
      {
        'title': 'Dan Hujan Pun Berhenti',
        'author': 'Farida Susanti',
        'rating': '4.6',
        'image': 'assets/book/cover-dhpb.webp',
        'genre': 'Romance',
        'description':
            'Kamu mungkin tidak akan mengerti Leo yang tidak percaya pada siapa pun di dunia ini. Tapi mungkin Spiza, gadis yang mencoba bunuh diri di sekolahnya, bisa.',
        'pages': 336,
        'language': 'Indonesia',
        'publisher': 'Mizan Pustaka',
        'year': 2016,
      },
      {
        'title': 'Senandung Talijiwo',
        'author': 'Sujiwo Tejo',
        'rating': '4.9',
        'image': 'assets/book/cover-senandung-talijiwo.webp',
        'genre': 'Filosofi',
        'description': 
          'Ternyata mencintai bukanlah cara untuk berbahagia. Mencintai tak lain cuma percobaan-percobaan kecil untuk melukai diri agar kelak tabah menghadapi luka-luka yang lebih besar, Kekasih. Cinta bertanya "apa kabar?" kepada benci. Dan, sebaliknya. Setiap saat. Sampai kita tak bisa lagi membedakan, sejatinya siapa yang sedang bertanya kepada siapa, Kekasih. Manusia harus saling mengingatkan kepada kebaikan karena hutan, gunung, sawah, dan lautan hanya bisa mengingatkan kita kepada mantan. Demi itu buku ini ada. Aku mau mengajakmu duduk sebagai teman ngobrol. Sedang tren manusia tak butuh pasangan sesama insan. Ketimbang nanti berantem, ketimbang nanti saling melapor polisi, mending berumah tangga dengan hewan saja. Di beberapa negara Eropa, seperti Inggris, musim itu telah lama tiba. Banyak jalan menuju Roma, tapi setiap jalan menuju takdir. Saat dipamiti adik atau anak ke sekolah, kita menjelma sebagai kakak atau orang tua. Bertemu teman kuliah atau sejawat kantor, mendadak kita menjadi sohib atau saingan. Sepernano detik yang lalu, kamu kekasihnya, dan sekarang sudah menjadi mantannya. Begitulah hidup, selalu bergerak seperti kisah-kisah Talijiwo yang hendak aku obrolkan kepadamu. Aku akan mendengarmu. Dengar aku juga. Siapa tahu setiap kata yang diobrolkan mengandung senandung untuk kita nyanyikan berdua. Please, tak perlu lagi keluh kesah itu. Hidup hanya mengolah keluhan menjadi senandung.',
        'pages': 236,
        'language': 'Indonesia',
        'publisher': 'Bentang Pustaka',
        'year': 2019,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buku Terbaik',
          style: TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: (bestBooks.length / 2).ceil(),
          itemBuilder: (context, rowIndex) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Expanded(child: _buildBookCard(bestBooks[rowIndex * 2])),
                  SizedBox(width: 16),
                  Expanded(
                    child:
                        rowIndex * 2 + 1 < bestBooks.length
                            ? _buildBookCard(bestBooks[rowIndex * 2 + 1])
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

  // KARTU BUKU
  Widget _buildBookCard(Map<String, dynamic> book) {
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
                      child: Image.asset(book['image'], fit: BoxFit.cover),
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
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              book['rating'],
                              style: TextStyle(
                                color: Color(0xFFF7F7F7),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Color(0xFF6E40F3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'BEST CHOICE',
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BAR NAVIGASI BAWAH
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2A2E43),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home_rounded, 'Home', true, () {
              // KOSONGAN BOLO
            }),
            _buildNavItem(Icons.explore_outlined, 'Explore', false, () {
              Get.toNamed('/explore');
            }),
            _buildNavItem(
              Icons.bookmark_border_rounded,
              'Bookmarks',
              false,
              () {
                Get.toNamed('/bookmark');
              },
            ),
            _buildNavItem(Icons.person_outline_rounded, 'Profile', false, () {
              Get.toNamed('/profile');
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
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
