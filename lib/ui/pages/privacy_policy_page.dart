import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kebijakan Privasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF00BF63),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildSection(
                title: 'Jenis Informasi yang Dikumpulkan',
                content:
                    'Kami mengumpulkan berbagai jenis informasi untuk meningkatkan kualitas layanan kami, termasuk:\n- Informasi perangkat seperti model ponsel, sistem operasi, dan pengaturan bahasa.\n- Data lokasi, apabila diaktifkan oleh pengguna.\n- Statistik penggunaan aplikasi untuk membantu kami mengoptimalkan pengalaman pengguna.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Tujuan Penggunaan Informasi',
                content:
                    'Informasi yang dikumpulkan digunakan untuk:\n- Memberikan layanan deteksi penyakit yang lebih akurat.\n- Melakukan analisis untuk meningkatkan performa aplikasi.\n- Menghubungi pengguna terkait pembaruan aplikasi atau fitur baru.\n- Memenuhi kewajiban hukum yang berlaku.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Keamanan Data',
                content:
                    'Kami berkomitmen untuk menjaga privasi pengguna dengan menerapkan langkah-langkah keamanan yang ketat, seperti enkripsi data dan pembatasan akses pada informasi sensitif. Namun, pengguna juga disarankan untuk menjaga kerahasiaan data pribadi mereka.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Berbagi Informasi',
                content:
                    'Informasi pribadi pengguna tidak akan dibagikan kepada pihak ketiga tanpa persetujuan, kecuali dalam kasus berikut:\n- Kewajiban hukum yang mengharuskan kami untuk melakukannya.\n- Pencegahan ancaman keamanan atau penipuan.\n- Operasional teknis yang melibatkan penyedia layanan tepercaya.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Hak Pengguna',
                content:
                    'Pengguna memiliki hak untuk:\n- Mengakses informasi pribadi yang telah dikumpulkan.\n- Memperbarui atau mengoreksi informasi pribadi mereka.\n- Meminta penghapusan data mereka dari sistem kami, sesuai dengan ketentuan hukum yang berlaku.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Penggunaan Cookie',
                content:
                    'Kami menggunakan cookie untuk meningkatkan pengalaman pengguna di aplikasi kami. Cookie membantu kami memahami bagaimana aplikasi digunakan dan memungkinkan kami memberikan layanan yang lebih baik.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Perubahan Kebijakan Privasi',
                content:
                    'Kebijakan privasi ini dapat diubah sewaktu-waktu untuk mencerminkan perubahan layanan atau regulasi. Kami akan memberikan pemberitahuan kepada pengguna jika ada perubahan signifikan melalui pembaruan di aplikasi.',
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BF63),
                    shape: StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 16.0,
                    ),
                    shadowColor: Colors.black45,
                    elevation: 8,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Got It',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00BF63),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
