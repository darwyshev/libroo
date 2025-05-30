import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libroo/app/routes/app_pages.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final PageController _controller = PageController();
  int _currentPage = 0;

  // INGPO UMUM
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  // INGPO PROFIL
  File? _profileImage;
  final fullNameController = TextEditingController();
  final nisnController = TextEditingController();
  DateTime? birthDate;

  // INGPO KELASS
  String? selectedGrade;
  String? selectedClass;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // addListener UNTUK UPDATE UI SETELAH ADA INGPO BOLO
    usernameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    fullNameController.addListener(() => setState(() {}));
    nisnController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    nisnController.dispose();
    super.dispose();
  }

  // VALIDASI FORM
  bool _isPage1Valid() {
    return usernameController.text.trim().isNotEmpty &&
           emailController.text.trim().isNotEmpty &&
           emailController.text.contains('@') &&
           passwordController.text.trim().isNotEmpty &&
           passwordController.text.length >= 6;
  }

  bool _isPage2Valid() {
    return fullNameController.text.trim().isNotEmpty &&
           nisnController.text.trim().isNotEmpty &&
           birthDate != null;
  }

  bool _isPage3Valid() {
    return selectedGrade != null && selectedClass != null;
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return _isPage1Valid();
      case 1:
        return _isPage2Valid();
      case 2:
        return _isPage3Valid();
      default:
        return false;
    }
  }

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
              onPrimary: Color(0xFFF7F7F7),
              surface: Color(0xFF1F2334),
              onSurface: Color(0xFFF7F7F7),
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

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      try {
        // PENDAFTARAN BERHASIL
        await Future.delayed(Duration(seconds: 2));
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrasi berhasil!'),
            backgroundColor: Colors.green,
          )
        );
        Get.offAllNamed(Routes.LOGIN);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Terjadi kesalahan. Coba lagi nanti.'),
            backgroundColor: Colors.red,
          )
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
  
  void nextPage() {
    if (!_canProceed()) {
      // PESAN ERROR BERDASARKAN HALAMAN
      String errorMessage = '';
      switch (_currentPage) {
        case 0:
          errorMessage = 'Mohon lengkapi semua data akun dengan benar';
          break;
        case 1:
          errorMessage = 'Mohon lengkapi semua data profil';
          break;
        case 2:
          errorMessage = 'Mohon pilih kelas Anda';
          break;
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.orange,
        )
      );
      return;
    }

    if (_currentPage < 2) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage++);
    } else {
      registerUser();
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage--);
    } else {
      Get.back();
    }
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(right: 10, left: 10),
            child: IconButton(
              onPressed: previousPage,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFF7F7F7),
                size: 20,
              ),
            ),
          ),
          
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [0, 1, 2].map((index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 80,
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
          ),
          
          SizedBox(width: 60),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      style: TextStyle(color: Color(0xFFF7F7F7)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: icon != null ? Icon(icon, color: Colors.white54) : null,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white54,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white38),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF7F7F7)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label tidak boleh kosong';
        }
        if (label == 'Email' && !value.contains('@')) {
          return 'Email tidak valid';
        }
        if (label == 'Password' && value.length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }

  Widget _buildButton({required String text, required VoidCallback? onPressed}) {
    bool isEnabled = _canProceed() && !_isLoading;
    
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? Color(0xFF6E40F3) : Color(0xFF6E40F3).withOpacity(0.5),
        disabledBackgroundColor: Color(0xFF6E40F3).withOpacity(0.5),
        minimumSize: Size(double.infinity, 50),
      ),
      child: _isLoading && text == 'Lanjut' && _currentPage == 2
          ? CircularProgressIndicator(color: Color(0xFFF7F7F7))
          : Text(
              text,
              style: TextStyle(
                color: isEnabled ? Color(0xFFF7F7F7) : Color(0xFFF7F7F7).withOpacity(0.7),
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
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: Color(0xFF23263A),
      hint: Text(hint, style: TextStyle(color: Colors.white70)),
      style: TextStyle(color: Color(0xFFF7F7F7)),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white38),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF7F7F7)),
        ),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                '$prefix $item',
                style: TextStyle(color: Color(0xFFF7F7F7))
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      iconEnabledColor: Colors.white70,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2334),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildStepIndicator(),
              Expanded(
                child: PageView(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    // STEP 1
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Daftar",
                              style: TextStyle(
                                fontSize: 28,
                                color: Color(0xFFF7F7F7),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 32),
                            _buildInputField(
                              controller: usernameController,
                              label: 'Username',
                              icon: Icons.person,
                            ),
                            SizedBox(height: 20),
                            _buildInputField(
                              controller: emailController,
                              label: 'Email',
                              icon: Icons.email,
                            ),
                            SizedBox(height: 20),
                            _buildInputField(
                              controller: passwordController,
                              label: 'Password',
                              isPassword: true,
                              icon: Icons.lock,
                            ),
                            SizedBox(height: 32),
                            _buildButton(text: 'Lanjut', onPressed: nextPage),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sudah memiliki akun? ',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed(Routes.LOGIN);
                                  },
                                  child: Text(
                                    'Masuk',
                                    style: TextStyle(
                                      color: Color(0xFFF7F7F7),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // STEP 2
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Profil Siswa",
                              style: TextStyle(
                                fontSize: 28,
                                color: Color(0xFFF7F7F7),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 32),
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
                                        backgroundColor: Color(0xFFF7F7F7),
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
                                          color: Color(0xFFF7F7F7),
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
                            SizedBox(height: 20),
                            _buildInputField(
                              controller: nisnController,
                              label: 'NISN',
                              icon: Icons.numbers,
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: pickDate,
                              child: Container(
                                padding: EdgeInsets.symmetric(
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
                                        color: Color(0xFFF7F7F7),
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

                    // STEP 3
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Data Kelas",
                              style: TextStyle(
                                fontSize: 28,
                                color: Color(0xFFF7F7F7),
                                fontWeight: FontWeight.bold
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
                            SizedBox(height: 20),
                            _buildDropdownField(
                              hint: 'Pilih Huruf Kelas',
                              items: List.generate(
                                10,
                                (i) => String.fromCharCode(65 + i),
                              ),
                              value: selectedClass,
                              onChanged: (val) => setState(() => selectedClass = val),
                              prefix: 'Kelas',
                            ),
                            SizedBox(height: 32),
                            _buildButton(
                              text: 'Lanjut',
                              onPressed: nextPage,
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
      ),
    );
  }
}