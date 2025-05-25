import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/intro/views/intro_view.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation controller
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    // Scale animation controller
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    // Pulse animation controller
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    // Setup animations
    _fadeAnimation = Tween<double>(
      begin: 0.0, 
      end: 1.0
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.3, 
      end: 1.0
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0, 
      end: 1.1
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Start animations sequence
    _startAnimations();
  }

  void _startAnimations() async {
    // Start fade and scale simultaneously
    _fadeController.forward();
    _scaleController.forward();
    
    // Wait a bit then start pulse animation
    await Future.delayed(Duration(milliseconds: 600));
    _pulseController.repeat(reverse: true);
    
    // Navigate after total 2.5 seconds
    await Future.delayed(Duration(milliseconds: 1900));
    
    if (mounted) {
      Get.offAllNamed('/intro');
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1F2334),
              Color(0xFF2A2E43),
              Color(0xFF1F2334),
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _fadeAnimation,
              _scaleAnimation,
              _pulseAnimation,
            ]),
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Transform.scale(
                  scale: _scaleAnimation.value * _pulseAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: Offset(0, 10),
                        ),
                        BoxShadow(
                          color: Color(0xFF4A5568).withOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/logo/logo-splash.png',
                        width: 160,
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}