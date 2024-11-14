import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebijakan Privasi'),
        backgroundColor: const Color(0xFF00BF63),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informasi yang Kami Kumpulkan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Aplikasi ini mengumpulkan informasi yang diperlukan untuk menyediakan layanan yang lebih baik. Ini termasuk:\n- Informasi perangkat (misalnya, model ponsel dan versi sistem operasi).\n- Data lokasi jika diaktifkan oleh pengguna.\n- Data penggunaan aplikasi untuk meningkatkan kinerja aplikasi.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Penggunaan Informasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Kami menggunakan informasi yang kami kumpulkan untuk:\n- Menyediakan layanan deteksi penyakit yang akurat.\n- Menyempurnakan dan memperbarui aplikasi.\n- Menghubungi Anda jika diperlukan untuk perbaikan atau pembaruan aplikasi.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Keamanan Informasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Kami berkomitmen untuk menjaga keamanan data Anda. Semua informasi yang Anda berikan akan dilindungi dengan menggunakan langkah-langkah keamanan yang sesuai. Namun, kami tidak dapat menjamin sepenuhnya keamanan data selama transmisi melalui internet.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Berbagi Informasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Kami tidak akan membagikan data pribadi Anda kepada pihak ketiga tanpa izin Anda, kecuali jika diwajibkan oleh hukum.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
