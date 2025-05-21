import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailOrUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void login() {
    setState(() {
      _isLoading = true;
    });
    
    // Simulasi proses login
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      // Tampilkan snackbar dan arahkan ke halaman home
      Get.snackbar(
        "Login", 
        "Berhasil login",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Navigasi ke halaman home
      Get.offAllNamed('/home');
    });
  }

  void toRegister() {
    Get.toNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Masuk", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 32),

            TextField(
              controller: emailOrUsernameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email atau Username',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
                  onPressed: togglePasswordVisibility,
                ),
              ),
            ),

            SizedBox(height: 32),

            ElevatedButton(
              onPressed: _isLoading ? null : login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6E40F3),
                minimumSize: Size(double.infinity, 50),
                disabledBackgroundColor: Color(0xFF6E40F3).withOpacity(0.5),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Masuk", style: TextStyle(color: Colors.white)),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun? ", style: TextStyle(color: Colors.white70)),
                GestureDetector(
                  onTap: toRegister,
                  child: Text("Daftar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}