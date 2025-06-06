import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Libroo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL, // LANGSUNG KE SPLASH SCREEN BOLO
      getPages: AppPages.routes,
    );
  }
}

// This is the main entry point of the application.