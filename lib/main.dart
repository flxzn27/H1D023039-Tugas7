import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/registration_page.dart';
import 'pages/about_page.dart';

// Definisi Warna Hijau Kalem
const Color accentGreen = Color(0xFFA5D6A7); // Hijau Kalem (Form/Side Menu BG)
const Color buttonGreen = Color(0xFF66BB6A); // Hijau Lebih Gelap (Tombol)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shaun The Sheep Fansbase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 🔹 Cara aman: pakai ColorScheme.fromSeed, tidak perlu MaterialColor custom
        colorScheme: ColorScheme.fromSeed(
          seedColor: accentGreen,
          primary: accentGreen,
          secondary: buttonGreen,
        ),
        useMaterial3: false, // boleh true kalau mau gaya Material 3
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: accentGreen,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CheckAuth(), // Cek status login
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/home': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}

// Widget untuk mengecek status login (Persisted Login)
class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Cek apakah 'isLoggedIn' bernilai true
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Arahkan ke rute yang sesuai
    if (!mounted)
      return; // 🔹 jaga-jaga biar Navigator gak dipanggil kalau widget sudah dispose

    if (isLoggedIn) {
      // Jika sudah login, langsung ke Home
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Jika belum login, ke Login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan loading screen sementara
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color: buttonGreen)),
    );
  }
}
