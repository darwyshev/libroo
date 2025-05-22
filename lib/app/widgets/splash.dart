import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/intro/views/intro_view.dart'; // pastikan ini sesuai path kamu

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    // Jalankan perpindahan setelah animasi selesai + jeda 2 detik
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 2), () {
          Get.offAllNamed('/intro');
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Image.asset(
            'assets/logo/logo-splash.png',
            width: 160,
          ),
        ),
      ),
    );
  }
}