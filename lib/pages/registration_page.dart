import 'package:flutter/material.dart';
import '../main.dart'; // Untuk mendapatkan konstanta warna

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  void _simulasiRegistrasi() {
    if (_formKey.currentState!.validate()) {
      // Tampilkan dialog berhasil registrasi
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Registrasi Berhasil!'),
            content: const Text(
              'Silakan login menggunakan akun yang sudah ditentukan.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Kembali ke halaman login
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrasi Pengguna Baru')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gambar Registrasi
                Image.asset(
                  'assets/registrasi.png', // Pastikan nama file sesuai
                  height: 150,
                ),
                const SizedBox(height: 30),
                // Form Input
                _buildTextField('Nama Panggilan', false),
                _buildTextField('Username', false),
                _buildTextField('Password', true, controller: _passController),
                _buildTextField(
                  'Konfirmasi Password',
                  true,
                  controller: _confirmPassController,
                  isConfirm: true,
                ),
                const SizedBox(height: 30),

                // Tombol Registrasi
                ElevatedButton(
                  onPressed: _simulasiRegistrasi,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonGreen, // Warna Hijau Lebih Gelap
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Registrasi',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    bool isPassword, {
    TextEditingController? controller,
    bool isConfirm = false,
  }) {
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
          if (isConfirm && value != _passController.text) {
            return 'Konfirmasi password tidak cocok';
          }
          return null;
        },
      ),
    );
  }
}
