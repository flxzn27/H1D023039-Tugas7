# H1D023039 Tugas 7: Shaun the Sheep Fansbase App
Proyek ini adalah aplikasi mobile sederhana yang dibangun menggunakan Flutter sebagai pemenuhan Tugas Praktikum Pemrograman Mobile. Aplikasi ini mengimplementasikan konsep dasar dalam pengembangan aplikasi authenticated, termasuk Sistem Login, Navigasi (Routes), Menu Samping (Side Menu), dan Manajemen Sesi menggunakan Local Storage (shared_preferences).

## Data Diri

* *Nama:* Alfan Fauzan Ridlo
* *NIM:* H1D023039 
* *Shift:* B
* *Shift KRS:* C

## Video Demo
![tugas7vid](https://github.com/user-attachments/assets/6a4bb7fe-8f50-493e-a0c5-464789a10ee7)

## Fitur Utama Aplikasi
1.Login Sesi: Memeriksa kredensial terhadap akun hardcode (shaun/sheep123) dan menyimpan sesi aktif.

2. Registrasi Simulasi: Menyediakan form pendaftaran pengguna yang terpisah. Setelah registrasi, pengguna diarahkan kembali ke Login (data tidak disimpan).
  
3. Persisted Login: Menggunakan Local Storage untuk mempertahankan sesi. Pengguna tidak perlu login ulang setelah menutup aplikasi.
   
4. Side Menu (Drawer): Menyediakan navigasi cepat ke Home dan About, serta fungsi Logout untuk menghapus sesi.
   
5. Local Storage (shared_preferences): Digunakan untuk menyimpan status login (isLoggedIn: true) dan username pengguna.

### 1. `lib/main.dart`

File ini adalah entry point aplikasi dan memegang peran vital dalam navigasi.

| Bagian Kode                    | Penjelasan Fungsi                                                                                                   | Poin Kreatif                                                                                                      |
|--------------------------------|----------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| `accentGreen` & `buttonGreen`  | Mendefinisikan konstanta warna kustom (hijau kalem) untuk branding aplikasi.                                        | Menggunakan tema kustom (`ThemeData`) alih-alih hanya mengandalkan warna bawaan.                                 |
| `MaterialApp`                  | Mengatur tema global dan mendaftarkan semua Named Routes (`/`, `/login`, `/home`, `/register`, `/about`).          | Menggunakan Named Routes untuk navigasi yang terstruktur dan mudah dikelola (lebih rapi dibanding `MaterialPageRoute` di modul). |
| `initialRoute: '/'`            | Menentukan titik awal aplikasi yang diarahkan ke widget `CheckAuth`.                                                | Menyiapkan alur aplikasi yang selalu mengecek sesi login sebelum menampilkan halaman lain.                        |
| `class CheckAuth`              | Widget stateful pertama yang dijalankan. Memeriksa status login sebelum merender halaman apa pun.                  | Implementasi **Persisted Login** sehingga alur aplikasi terasa lebih profesional.                                 |
| `_checkLoginStatus()`          | Mengambil nilai `isLoggedIn` dari `SharedPreferences`. Jika `true` → ke `/home`, jika `false` → ke `/login`.        | Menunjukkan pemahaman manajemen sesi: user tidak dipaksa login ulang setiap kali membuka aplikasi.               |

### 2. `lib/pages/login_page.dart`

File ini berisi logika otentikasi dan carousel otomatis yang menjadi salah satu poin kreativitas utama.

| Bagian Kode                        | Penjelasan Fungsi                                                                                                                     | Poin Kreatif                                                                                                                     |
|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| `correctUsername` / `correctPassword` | Variabel untuk menyimpan akun hardcode yang valid: `'shaun'` / `'sheep123'`.                                                          | Memberi akun demo khusus bertema Shaun the Sheep, selaras dengan konsep fansbase aplikasi.                                      |
| `initState()` & `Timer.periodic`   | Saat halaman dimuat, `initState` memulai timer yang berjalan setiap beberapa detik untuk mengubah nilai `_currentPage` (indeks gambar).| Implementasi **carousel otomatis** berbasis waktu tanpa perlu swipe manual.                                                     |
| `_timer?.cancel()` di `dispose()`  | Membatalkan timer ketika widget dihancurkan (`dispose`) untuk mencegah adanya timer yang tetap hidup di background.                  | Menunjukkan pemahaman lifecycle widget stateful dan pencegahan **memory leak**.                                                 |
| `AspectRatio` & `AnimatedSwitcher` | `AspectRatio` memastikan gambar tetap rasio 1:1 (persegi). `AnimatedSwitcher` memberi efek transisi halus saat `_currentPage` berubah.| Mengganti gesture swipe di modul dengan animasi otomatis berbasis waktu → **poin kreativitas visual dan UX**.                  |
| `_handleLogin()`                   | Memvalidasi form. Jika benar, memanggil `_saveLoginSession()` untuk menyimpan `isLoggedIn: true` dan `username` ke Local Storage.    | Menjadi logika inti manajemen sesi login menggunakan `SharedPreferences`.                                                       |
| Link Registrasi                    | Menggunakan `GestureDetector` dan `Navigator.pushNamed(context, '/register')` untuk membuka halaman registrasi.                      | Menambah alur login → registrasi → kembali login, sehingga user flow terasa lebih lengkap.                   

|### 3. `lib/pages/registration_page.dart`

Halaman ini dibuat untuk memenuhi alur aplikasi yang lebih lengkap, meskipun datanya hanya disimulasikan.

| Bagian Kode           | Penjelasan Fungsi                                                                                                   | Poin Kreatif                                                                                               |
|-----------------------|----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| `_formKey`            | Mengelola state dan validasi seluruh form registrasi. Digunakan untuk memanggil `validate()` pada semua field sekaligus. | Menggunakan pendekatan form yang terstruktur, bukan input bebas tanpa validasi.                            |
| `_simulasiRegistrasi()` | Memeriksa apakah form valid (misalnya password dan konfirmasi password cocok). Jika valid, menampilkan dialog “Registrasi Berhasil”. | Implementasi **simulasi registrasi** yang jelas, walaupun data belum benar-benar disimpan ke backend.     |
| `Navigator.popUntil` & `pushNamed` | Setelah menekan OK pada dialog, navigasi diarahkan kembali ke halaman login (`/login`) dan membersihkan history seperlunya. | Menjaga **riwayat navigasi yang bersih**, sehingga user tidak bingung jika menekan tombol back.           |
| `TextFormField` + validator | Setiap field (Nama Panggilan, Username, Password, Konfirmasi Password) menggunakan validator, termasuk cek kecocokan password. | Implementasi **form validation** yang lebih baik dan ketat dibanding contoh minimal di modul.             |

### 4. `lib/pages/home_page.dart`

Halaman Home menampilkan data personal pengguna yang diambil dari Local Storage.

| Bagian Kode                           | Penjelasan Fungsi                                                                                     | Poin Kreatif                                                                                     |
|---------------------------------------|--------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| `_username`                           | Variabel state yang menyimpan nama pengguna yang berhasil login.                                      | Menyediakan dasar untuk personalisasi konten di halaman Home.                                   |
| `_loadUsername()`                     | Mengambil nilai `username` dari `SharedPreferences` dan memanggil `setState` untuk memperbarui UI.    | Menggunakan data dari Local Storage untuk mempersonalisasi tampilan, bukan data hardcode.       |
| `Scaffold(drawer: SideMenu(username: _username))` | Memuat komponen Side Menu dan mengirim nilai `_username` sebagai parameter ke drawer.                | Mengirim data personal ke komponen drawer → Side Menu terasa lebih hidup dan personal.          |
| `Text('Hallo $_username')`           | Menampilkan sapaan yang dipersonalisasi di Home.                                                       | Menjadi bukti bahwa Local Storage bekerja dengan benar dan sesi login benar-benar dipakai.      |

### 5. `lib/widgets/side_menu.dart`

Komponen Drawer kustom yang juga menangani manajemen sesi (logout).

| Bagian Kode          | Penjelasan Fungsi                                                                                                  | Poin Kreatif                                                                                                                         |
|----------------------|---------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| `widget.username`    | Menerima `username` dari `HomePage` melalui constructor, lalu menampilkannya di bagian header drawer.             | Side Menu kustom yang menampilkan data dari Local Storage sehingga terasa lebih personal dan interaktif.                           |
| `DrawerHeader`       | Menampilkan sapaan dan informasi singkat pengguna menggunakan `widget.username`.                                   | Memberi sentuhan UI yang “fansbase-like” (contoh: sapaan khusus fans Shaun the Sheep).                                             |
| `_handleLogout()`    | Fungsi utama untuk mengakhiri sesi: `prefs.clear()` menghapus semua data (`isLoggedIn`, `username`) di Local Storage. | Implementasi fitur **Logout** yang fungsional, bukan hanya sekedar berpindah halaman.                                              |
| `pushNamedAndRemoveUntil` | Setelah logout, menavigasi ke `/login` dan menghapus semua history rute sebelumnya `((Route route) => false)`. | Menunjukkan pemahaman navigasi yang benar untuk mengamankan sesi (user tidak bisa kembali ke Home dengan tombol back).             |

