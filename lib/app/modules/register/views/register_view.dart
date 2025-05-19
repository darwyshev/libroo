import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libroo/services/api_services.dart'; // Ganti dengan path yang sesuai

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  // Step 1 - General Info
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Step 2 - Profile Info
  File? _profileImage;
  final fullNameController = TextEditingController();
  final nisnController = TextEditingController();
  DateTime? birthDate;

  // Step 3 - Class Selection
  String? selectedGrade;
  String? selectedClass;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF6E40F3),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1F2334),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        birthDate = pickedDate;
      });
    }
  }

  void registerUser() async {
    try {
      var response = await ApiService.registerUser(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (response['status'] == 'success') {
        // Lanjut ke step 2
        setState(() {
          _currentPage = 1; // atau sesuai nama variabel step kamu
        });
      } else {
        Get.snackbar('Gagal', response['message']);
      }
  } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan saat menghubungi server');
    }
  }
  
    void nextPage() {
      if (_currentPage < 2) {
        _controller.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() => _currentPage++);
      } else {
        registerUser(); // ← kirim data ke backend
      }
    }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            [0, 1, 2].map((index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 90,
                height: 5,
                decoration: BoxDecoration(
                  color:
                      _currentPage >= index
                          ? Color(0xFF6E40F3)
                          : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          prefixIcon: icon != null ? Icon(icon, color: Colors.white54) : null,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white38),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF6E40F3),
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
    required String prefix,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: Color(0xFF23263A),
        hint: Text(hint, style: TextStyle(color: Colors.white70)),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white38),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        items:
            items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      '$prefix $item',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
                .toList(),
        onChanged: onChanged,
        iconEnabledColor: Colors.white70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pendaftaran Siswa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Changed for contrast
          ),
        ),
        backgroundColor: Color(0xFF6E40F3), // Primary color
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF1F2334), // Background color
        child: Column(
          children: [
            _buildStepIndicator(),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // Step 1
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informasi Akun',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Silakan masukkan detail informasi akun Anda',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 32),
                          _buildInputField(
                            controller: usernameController,
                            label: 'Username',
                            icon: Icons.person,
                          ),
                          _buildInputField(
                            controller: emailController,
                            label: 'Email',
                            icon: Icons.email,
                          ),
                          _buildInputField(
                            controller: passwordController,
                            label: 'Password',
                            isPassword: true,
                            icon: Icons.lock,
                          ),
                          SizedBox(height: 32),
                          _buildButton(text: 'Lanjut', onPressed: nextPage),
                          SizedBox(height: 24),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Sudah memiliki akun?',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                SizedBox(height: 8),
                                TextButton(
                                  onPressed: () {
                                    Get.offAllNamed('/login');
                                  },
                                  child: Text(
                                    'Masuk di sini',
                                    style: TextStyle(
                                      color: Color(0xFF6E40F3),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Step 2
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profil Siswa',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Silakan lengkapi data diri Anda',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 24),
                          Center(
                            child: GestureDetector(
                              onTap: pickImage,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF6E40F3),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xFF6E40F3),
                                        width: 3,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          _profileImage != null
                                              ? FileImage(_profileImage!)
                                              : null,
                                      child:
                                          _profileImage == null
                                              ? Icon(
                                                Icons.person,
                                                size: 60,
                                                color: Colors.grey.shade400,
                                              )
                                              : null,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF6E40F3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 32),
                          _buildInputField(
                            controller: fullNameController,
                            label: 'Nama Lengkap',
                            icon: Icons.badge,
                          ),
                          _buildInputField(
                            controller: nisnController,
                            label: 'NISN',
                            icon: Icons.numbers,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: InkWell(
                              onTap: pickDate,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white38,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.white54,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      birthDate == null
                                          ? 'Pilih Tanggal Lahir'
                                          : '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 32),
                          _buildButton(text: 'Lanjut', onPressed: nextPage),
                        ],
                      ),
                    ),
                  ),

                  // Step 3
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Data Kelas',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Silakan pilih kelas Anda',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 32),
                          _buildDropdownField(
                            hint: 'Pilih Jenjang Kelas',
                            items: ['7', '8', '9'],
                            value: selectedGrade,
                            onChanged:
                                (val) => setState(() => selectedGrade = val),
                            prefix: 'Kelas',
                          ),
                          _buildDropdownField(
                            hint: 'Pilih Huruf Kelas',
                            items: List.generate(
                              10,
                              (i) => String.fromCharCode(65 + i),
                            ),
                            value: selectedClass,
                            onChanged:
                                (val) => setState(() => selectedClass = val),
                            prefix: 'Kelas',
                          ),
                          SizedBox(height: 32),
                          _buildButton(text: 'Daftar', onPressed: nextPage),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
