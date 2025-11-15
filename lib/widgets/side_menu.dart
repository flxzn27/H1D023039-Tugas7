import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart'; // Untuk mendapatkan konstanta warna

class Sidemenu extends StatefulWidget {
  final String username;
  const Sidemenu({super.key, required this.username});

  @override
  State<Sidemenu> createState() => _SidemenuState();
}

class _SidemenuState extends State<Sidemenu> {
  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Hapus semua data sesi (isLoggedIn dan username)
    await prefs.clear();

    // Navigasi ke halaman login dan hapus semua rute sebelumnya
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header Kustom (Warna Hijau Kalem)
          DrawerHeader(
            decoration: const BoxDecoration(color: accentGreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.person, size: 50, color: Colors.black),
                const SizedBox(height: 5),
                Text(
                  'Halo, ${widget.username}!', // Menampilkan username
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Fansbase Member',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),

          // Menu Home
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),

          // Menu About
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              Navigator.pushNamed(context, '/about');
            },
          ),

          const Divider(), // Garis pemisah
          // Menu Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: _handleLogout,
          ),
        ],
      ),
    );
  }
}
