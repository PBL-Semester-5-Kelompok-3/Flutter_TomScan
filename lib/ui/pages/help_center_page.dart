import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan'),
        backgroundColor: const Color(0xFF00BF63),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cara Menggunakan Aplikasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Untuk mendeteksi penyakit pada daun tomat, ikuti langkah-langkah berikut:\n- Ambil foto daun tomat menggunakan aplikasi.\n- Aplikasi akan menganalisis gambar dan memberikan diagnosis penyakit yang mungkin ada pada daun.\n- Ikuti rekomendasi perawatan yang diberikan.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Masalah dengan Pengambilan Gambar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Jika aplikasi tidak dapat mendeteksi daun dengan baik:\n- Pastikan pencahayaan cukup terang.\n- Pastikan daun tomat terlihat jelas dan tidak ada bagian lain yang menghalangi.\n- Gunakan kamera dengan kualitas yang baik untuk mendapatkan hasil yang lebih akurat.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Masalah Login atau Pengguna',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Jika Anda mengalami masalah saat login atau menggunakan akun, coba langkah-langkah berikut:\n- Pastikan Anda memasukkan informasi login dengan benar.\n- Jika Anda lupa kata sandi, pilih opsi "Lupa Kata Sandi" di layar login.\n- Jika masalah berlanjut, hubungi tim dukungan kami di [email@example.com].',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Mengenai Deteksi Penyakit',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Aplikasi ini menggunakan algoritma untuk mendeteksi penyakit pada daun tomat berdasarkan gambar yang diambil. Namun, hasil deteksi ini bersifat referensial dan kami menyarankan agar Anda selalu berkonsultasi dengan ahli pertanian untuk diagnosa yang lebih akurat.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Dukungan Pelanggan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Jika Anda memerlukan bantuan lebih lanjut atau ingin memberikan masukan, Anda dapat menghubungi kami melalui:\n- Email: [email@example.com]\n- Telepon: [nomor telepon]\n- Media sosial: [akun media sosial]',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
