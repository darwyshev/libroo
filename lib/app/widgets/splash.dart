import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage('assets/logo/logo-splash.png'), context);
    });
    _controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      reverseDuration: Duration(milliseconds: 900),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    // Delay 3 detik, lalu fade out dan pindah ke halaman home
    Timer(Duration(seconds: 3), () async {
      await _controller.reverse();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
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
      backgroundColor: Colors.black, // Atau warna sesuai tema kamu
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ganti dengan logo kamu
              Image.asset('assets/logo/logo-splash.png', height: 100),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}