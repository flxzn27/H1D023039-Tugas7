import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/side_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = 'Pengguna'; // Default value

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Ambil username yang tersimpan saat login
      _username = prefs.getString('username') ?? 'Pengguna';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Fansbase')),
      // Side Menu (Drawer) yang menggunakan username
      drawer: Sidemenu(username: _username),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hallo $_username', // Tampilkan username dari Local Storage
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Foto home.png
            Image.asset(
              'assets/home.png', // Pastikan nama file sesuai
              height: MediaQuery.of(context).size.height * 0.5,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
