import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/intro_controller.dart';

class IntroView extends GetView<IntroController> {
  IntroView({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  final List<Map<String, String>> introData = [
    {
      "image": "assets/image/intro-1.png",
      "title": "Welcome to Libroo",
      "desc": "Your smart digital library experience",
    },
    {
      "image": "assets/image/intro-2.png",
      "title": "Read Anywhere",
      "desc": "Enjoy reading books from any device.",
    },
    {
      "image": "assets/image/intro-3.png",
      "title": "Manage Collection",
      "desc": "Organize your favorite books easily.",
    },
    {
      "image": "assets/image/intro-4.png",
      "title": "Track Progress",
      "desc": "Monitor your reading journey.",
    },
    {
      "image": "assets/image/intro-5.png",
      "title": "Let's Get Started!",
      "desc": "Sign in and explore now.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: introData.length,
                onPageChanged: controller.changePage,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        introData[index]["image"]!,
                        height: 160,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        introData[index]["title"]!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        introData[index]["desc"]!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  introData.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: controller.currentPage.value == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? Color(0xFF6E40F3)
                          : Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            Obx(() {
              final isLast = controller.currentPage.value == introData.length - 1;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6E40F3),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isLast ? "Get Started" : "Next",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        ),
                    ),
                    onPressed: () {
                      if (isLast) {
                        Get.offAllNamed('/home'); // ganti ke route final kamu
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.ease,
                        );
                      }
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
