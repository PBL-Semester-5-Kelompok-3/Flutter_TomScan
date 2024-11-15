import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat dan Ketentuan'),
        backgroundColor: const Color(0xFF00BF63),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Penerimaan Ketentuan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Dengan mengunduh dan menggunakan aplikasi ini, Anda setuju untuk mematuhi semua syarat dan ketentuan yang tercantum dalam dokumen ini. Jika Anda tidak setuju dengan syarat dan ketentuan ini, harap berhenti menggunakan aplikasi ini.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Penggunaan Aplikasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Aplikasi ini dirancang untuk mendeteksi penyakit pada daun tomat dengan menggunakan teknologi canggih. Anda hanya diperbolehkan menggunakan aplikasi ini untuk tujuan yang sah dan sesuai dengan instruksi yang ada.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Pembatasan Tanggung Jawab',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Kami tidak bertanggung jawab atas kerugian atau kerusakan yang timbul akibat penggunaan aplikasi ini. Deteksi penyakit yang dilakukan oleh aplikasi bersifat informatif dan tidak menggantikan saran medis atau konsultasi dengan ahli pertanian.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Perubahan Ketentuan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Kami berhak untuk mengubah atau memperbarui syarat dan ketentuan ini kapan saja tanpa pemberitahuan sebelumnya. Penggunaan aplikasi ini setelah perubahan berarti Anda menerima syarat dan ketentuan yang telah diperbarui.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Hukum yang Berlaku',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Syarat dan ketentuan ini diatur oleh hukum yang berlaku di Indonesia. Setiap sengketa yang timbul akan diselesaikan di pengadilan yang berwenang di Indonesia.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
