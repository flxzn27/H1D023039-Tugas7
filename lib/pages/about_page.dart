import 'package:flutter/material.dart';
import '../widgets/side_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Pengguna';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      drawer: Sidemenu(username: _username),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tentang Aplikasi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Aplikasi Fansbase sederhana yang didedikasikan untuk para penggemar setia Shaun the Sheep. Aplikasi ini dibuat sebagai tugas praktikum Pemrograman Mobile, mengimplementasikan Local Storage, Named Routes, dan Side Menu kustom.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 40),
            Text(
              'Nama Pengembang',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Alfan Fauzan Ridlo', style: TextStyle(fontSize: 16)),
            Text(
              'Universitas Jenderal Soedirman',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
