import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  void nextPage() {
    if (_currentPage < 2) {
      _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _currentPage++);
    } else {
      // Submit logic here
      Get.snackbar(
        "Sukses", 
        "Registrasi berhasil!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(8),
        borderRadius: 8,
      );
    }
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [0, 1, 2].map((index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: 90,
            height: 5,
            decoration: BoxDecoration(
              color: _currentPage >= index 
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
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon, color: Color(0xFF6E40F3)) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF6E40F3), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          labelStyle: TextStyle(color: Colors.grey.shade700),
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF6E40F3),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
        hint: Text(hint),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF6E40F3), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        items: items.map((item) => 
          DropdownMenuItem(
            value: item, 
            child: Text('$prefix $item')
          )
        ).toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pendaftaran Siswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF6E40F3),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
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
                              color: Color(0xFF1F2334),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Silakan masukkan detail informasi akun Anda',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
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
                              color: Color(0xFF1F2334),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Silakan lengkapi data diri Anda',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
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
                                      backgroundColor: Colors.grey.shade200,
                                      backgroundImage: _profileImage != null 
                                          ? FileImage(_profileImage!) 
                                          : null,
                                      child: _profileImage == null 
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
                          InkWell(
                            onTap: pickDate,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                                color: Colors.grey.shade50,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, color: Color(0xFF6E40F3)),
                                  SizedBox(width: 12),
                                  Text(
                                    birthDate == null 
                                        ? 'Pilih Tanggal Lahir' 
                                        : '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}',
                                    style: TextStyle(
                                      color: birthDate == null 
                                          ? Colors.grey.shade700 
                                          : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
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
                              color: Color(0xFF1F2334),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Silakan pilih kelas Anda',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 32),
                          _buildDropdownField(
                            hint: 'Pilih Jenjang Kelas',
                            items: ['7', '8', '9'],
                            value: selectedGrade,
                            onChanged: (val) => setState(() => selectedGrade = val),
                            prefix: 'Kelas',
                          ),
                          _buildDropdownField(
                            hint: 'Pilih Huruf Kelas',
                            items: List.generate(10, (i) => String.fromCharCode(65 + i)),
                            value: selectedClass,
                            onChanged: (val) => setState(() => selectedClass = val),
                            prefix: 'Kelas',
                          ),
                          SizedBox(height: 32),
                          _buildButton(text: 'Daftar', onPressed: nextPage),
                          SizedBox(height: 24),
                          if (_currentPage == 2)
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Sudah memiliki akun?',
                                    style: TextStyle(color: Colors.grey.shade700),
                                  ),
                                  SizedBox(height: 8),
                                  TextButton(
                                    onPressed: () {
                                      // Navigation to login page would go here
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}