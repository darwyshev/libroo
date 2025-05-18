import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/intro_controller.dart';
import '../../../routes/app_pages.dart';

class IntroView extends GetView<IntroController> {
  IntroView({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  final List<Map<String, String>> introData = [
    {
      "image": "assets/image/intro-1.webp",
      "title": "Selamat Datang Libroo",
      "desc": "Akses perpustakaan cuma dari smartphone kamu.",
    },
    {
      "image": "assets/image/intro-2.webp",
      "title": "Pinjam Buku Kapan Saja",
      "desc": "Kamu bisa pinjam buku kapan saja dan di mana saja.",
    },
    {
      "image": "assets/image/intro-3.webp",
      "title": "Cukup Konfirmasi dan Ambil",
      "desc": "Tidak perlu ribet, semua koleksi ada di sini.",
    },
    {
      "image": "assets/image/intro-4.webp",
      "title": "Gampang Digunakan",
      "desc": "Ramah pengguna dan mudah digunakan.",
    },
    {
      "image": "assets/image/intro-5.webp",
      "title": "Ayo Bergabung",
      "desc": "Daftar dan nikmati semua fitur Libroo.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: introData.length,
            onPageChanged: controller.changePage,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    introData[index]['image']!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.85),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          introData[index]['title']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          introData[index]['desc']!,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // 🟡 Bungkus indikator pakai Obx
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                introData.length,
                                (i) => AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: controller.currentPage.value == i ? 16 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: controller.currentPage.value == i
                                        ? Colors.white
                                        : Colors.white24,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 24),

                        // 🟡 Bungkus tombol juga pakai Obx
                        Obx(() => SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF6E40F3),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  controller.currentPage.value == introData.length - 1
                                      ? "Mulai"
                                      : "Lanjut",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  if (controller.currentPage.value ==
                                      introData.length - 1) {
                                    Get.offAllNamed(Routes.REGISTER); // arahkan ke page register
                                  } else {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                              ),
                            )),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
