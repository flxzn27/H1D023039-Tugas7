import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async'; // Import library Timer
import '../main.dart'; // Untuk mendapatkan konstanta warna

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variabel untuk Carousel Otomatis
  final List<String> _imageAssets = [
    'assets/login1.png',
    'assets/login2.png',
    'assets/login3.png',
  ];
  int _currentPage = 0;
  Timer? _timer;

  // Akun Hardcode
  final String correctUsername = 'shaun';
  final String correctPassword = 'sheep123';

  @override
  void initState() {
    super.initState();
    // Inisialisasi Timer untuk mengganti gambar setiap 5 detik
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (mounted) {
        setState(() {
          // Logika untuk siklus 0 > 1 > 2 > 0
          _currentPage = (_currentPage + 1) % _imageAssets.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _timer?.cancel(); // Batalkan timer saat widget di-dispose
    super.dispose();
  }

  void _saveLoginSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Simpan status login dan username
    prefs.setBool('isLoggedIn', true);
    prefs.setString('username', _usernameController.text);
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      if (_usernameController.text == correctUsername &&
          _passwordController.text == correctPassword) {
        // 1. Simpan sesi
        _saveLoginSession();

        // 2. Navigasi ke Home Page
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Tampilkan Alert Gagal Login
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login Gagal!'),
              content: const Text('Username atau Password salah.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selamat Datang di Fansbase\nShaun the Sheep',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Image Carousel Otomatis (Persegi)
              AspectRatio(
                aspectRatio: 1 / 1, // Memastikan gambar berbentuk persegi
                child: AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 800,
                  ), // Durasi transisi
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        // Transisi Fade
                        return FadeTransition(opacity: animation, child: child);
                      },
                  child: ClipRRect(
                    key: ValueKey<int>(_currentPage), // Key unik untuk Animasi
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      _imageAssets[_currentPage], // Gambar saat ini
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Form Login
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_usernameController, 'Username', false),
                    _buildTextField(_passwordController, 'Password', true),
                    const SizedBox(height: 20),

                    // Tombol Login
                    ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonGreen, // Warna Hijau Lebih Gelap
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Link Registrasi
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Belum login? Registrasi disini',
                  style: TextStyle(
                    color: buttonGreen,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    bool isPassword,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: accentGreen.withOpacity(0.3), // Warna Form Hijau Kalem
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hint tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }
}
