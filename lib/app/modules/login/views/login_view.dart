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

  @override
  void initState() {
    super.initState();
    // addListener BUAT UPDATE UI SETELAH ADA INGPO
    emailOrUsernameController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailOrUsernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // CEK APAKAH LOGIN VALID
  bool _isFormValid() {
    return emailOrUsernameController.text.trim().isNotEmpty &&
           passwordController.text.trim().isNotEmpty;
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void login() {
    // CEK APAKAH LOGIN VALID
    if (!_isFormValid()) {
      Get.snackbar(
        "Error", 
        "Mohon isi email/username dan password",
        backgroundColor: Colors.orange,
        colorText: Color(0xFFF7F7F7),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });
    
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      // NOTIF BERHASIL LOGIN
      Get.snackbar(
        "Login", 
        "Berhasil login",
        backgroundColor: Colors.green,
        colorText: Color(0xFFF7F7F7),
      );

      Get.offAllNamed('/home');
    });
  }

  void toRegister() {
    Get.toNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    bool isFormValid = _isFormValid();
    
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Masuk", 
              style: TextStyle(
                fontSize: 28, 
                color: Color(0xFFF7F7F7), 
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 32),

            TextField(
              controller: emailOrUsernameController,
              style: TextStyle(color: Color(0xFFF7F7F7)),
              decoration: InputDecoration(
                labelText: 'Email atau Username',
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.person, color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF7F7F7))
                ),
                // STYLE ERROR BORDER
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
                ),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              style: TextStyle(color: Color(0xFFF7F7F7)),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.lock, color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF7F7F7))
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility, 
                    color: Colors.white54
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
            ),

            SizedBox(height: 32),

            ElevatedButton(
              onPressed: (isFormValid && !_isLoading) ? login : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFormValid 
                    ? Color(0xFF6E40F3) 
                    : Color(0xFF6E40F3).withOpacity(0.5),
                disabledBackgroundColor: Color(0xFF6E40F3).withOpacity(0.5),
                minimumSize: Size(double.infinity, 50),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Color(0xFFF7F7F7))
                  : Text(
                      "Masuk", 
                      style: TextStyle(
                        color: isFormValid 
                            ? Color(0xFFF7F7F7) 
                            : Color(0xFFF7F7F7).withOpacity(0.7),
                      )
                    ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum punya akun? ", 
                  style: TextStyle(color: Colors.white70)
                ),
                GestureDetector(
                  onTap: toRegister,
                  child: Text(
                    "Daftar", 
                    style: TextStyle(
                      color: Color(0xFFF7F7F7), 
                      fontWeight: FontWeight.bold
                    )
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}