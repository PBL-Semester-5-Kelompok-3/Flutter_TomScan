import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Syarat dan Ketentuan',
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
                title: 'Publisher',
                content:
                    'Kelompok 3 TI-3A Teknik Informatika\nJurusan Teknologi Informasi, Politeknik Negeri Malang\nJl. Soekarno Hatta No.9, Kota Malang\nJawa Timur 65141',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Contact',
                content:
                    'Tel.: +62 857 3229 0931\nFax.: +62 857 3229 0931\nUntuk informasi lebih lanjut, jangan ragu untuk menghubungi kami. Kami selalu siap membantu kebutuhan Anda.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Regulatory agency',
                content:
                    'Aplikasi ini berada di bawah pengawasan Direktorat Jenderal Informasi dan Komunikasi Publik Republik Indonesia. Kami mematuhi regulasi yang berlaku untuk memastikan kualitas layanan dan privasi pengguna.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Used software libraries',
                content:
                    'Aplikasi ini menggunakan pustaka perangkat lunak terbaru untuk memastikan kinerja yang optimal dan kompatibilitas lintas platform. Pustaka utama yang digunakan adalah Flutter SDK dan pustaka pihak ketiga untuk integrasi API.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Only IOS',
                content:
                    'Versi aplikasi yang dirancang khusus untuk perangkat iOS memanfaatkan ekosistem Apple untuk memberikan pengalaman pengguna yang lebih halus dan terintegrasi. Fitur seperti dukungan Face ID dan ekosistem iCloud dioptimalkan untuk aplikasi ini.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Only Android',
                content:
                    'Aplikasi ini telah dioptimalkan untuk berbagai perangkat Android, memastikan kompatibilitas dengan berbagai ukuran layar dan fitur. Dukungan untuk notifikasi push berbasis Firebase serta integrasi dengan Google Play Services telah diterapkan.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'User responsibilities',
                content:
                    'Pengguna diwajibkan untuk menjaga kerahasiaan akun mereka dan menggunakan aplikasi ini sesuai dengan hukum yang berlaku. Setiap pelanggaran akan ditindak sesuai kebijakan kami.',
              ),
              const Divider(height: 40, thickness: 1, color: Colors.grey),
              _buildSection(
                title: 'Terms of service changes',
                content:
                    'Kami berhak untuk memodifikasi syarat dan ketentuan ini kapan saja. Kami akan memberikan pemberitahuan melalui email atau pengumuman di dalam aplikasi jika ada perubahan besar.',
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
