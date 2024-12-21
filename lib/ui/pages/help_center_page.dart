import 'package:flutter/material.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final List<Map<String, String>> _items = [
    {
      'title': 'Cara Menggunakan Aplikasi',
      'content':
          'Untuk mendeteksi penyakit pada daun tomat, ikuti langkah-langkah berikut:\n- Ambil foto daun tomat menggunakan aplikasi.\n- Aplikasi akan menganalisis gambar dan memberikan diagnosis penyakit yang mungkin ada pada daun.\n- Ikuti rekomendasi perawatan yang diberikan.'
    },
    {
      'title': 'Masalah dengan Pengambilan Gambar',
      'content':
          'Jika aplikasi tidak dapat mendeteksi daun dengan baik:\n- Pastikan pencahayaan cukup terang.\n- Pastikan daun tomat terlihat jelas dan tidak ada bagian lain yang menghalangi.\n- Gunakan kamera dengan kualitas yang baik untuk mendapatkan hasil yang lebih akurat.'
    },
    {
      'title': 'Masalah Login atau Pengguna',
      'content':
          'Jika Anda mengalami masalah saat login atau menggunakan akun, coba langkah-langkah berikut:\n- Pastikan Anda memasukkan informasi login dengan benar.\n- Jika Anda lupa kata sandi, pilih opsi "Lupa Kata Sandi" di layar login.\n- Jika masalah berlanjut, hubungi tim dukungan kami di [email@example.com].'
    },
    {
      'title': 'Mengenai Deteksi Penyakit',
      'content':
          'Aplikasi ini menggunakan algoritma untuk mendeteksi penyakit pada daun tomat berdasarkan gambar yang diambil. Namun, hasil deteksi ini bersifat referensial dan kami menyarankan agar Anda selalu berkonsultasi dengan ahli pertanian untuk diagnosa yang lebih akurat.'
    },
    {
      'title': 'Dukungan Pelanggan',
      'content':
          'Jika Anda memerlukan bantuan lebih lanjut atau ingin memberikan masukan, Anda dapat menghubungi kami melalui:\n- Email: [email@example.com]\n- Telepon: [nomor telepon]\n- Media sosial: [akun media sosial]'
    },
    {
      'title': 'Pengaturan Akun',
      'content':
          'Untuk mengelola akun Anda:\n- Masuk ke menu "Pengaturan".\n- Pilih "Akun" untuk memperbarui informasi pribadi Anda.\n- Jangan lupa untuk menyimpan perubahan setelah selesai.'
    },
    {
      'title': 'Notifikasi Aplikasi',
      'content':
          'Jika Anda tidak menerima notifikasi aplikasi:\n- Periksa pengaturan notifikasi di perangkat Anda.\n- Pastikan notifikasi aplikasi diaktifkan.\n- Coba restart aplikasi untuk memastikan pengaturan terbaru telah diterapkan.'
    },
    {
      'title': 'Keamanan Data',
      'content':
          'Kami memastikan bahwa data Anda aman:\n- Semua data dienkripsi selama transmisi.\n- Data Anda hanya digunakan untuk keperluan aplikasi dan tidak akan dibagikan kepada pihak ketiga tanpa izin Anda.'
    },
    {
      'title': 'Masalah Pembaruan Aplikasi',
      'content':
          'Jika Anda mengalami masalah saat memperbarui aplikasi:\n- Pastikan perangkat Anda terhubung ke internet.\n- Periksa ruang penyimpanan di perangkat Anda.\n- Coba unduh ulang aplikasi dari toko aplikasi resmi.'
    },
    {
      'title': 'Bantuan Lainnya',
      'content':
          'Jika Anda membutuhkan bantuan tambahan:\n- Kunjungi situs web resmi kami untuk panduan dan FAQ.\n- Hubungi layanan pelanggan kami melalui email atau telepon.\n- Pastikan untuk menyertakan detail masalah yang Anda hadapi untuk respons yang lebih cepat.'
    },
  ];

  late List<Map<String, String>> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = _items
          .where((item) =>
              item['title']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF00BF63),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Cari bantuan...',
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(12),
                ),
                onChanged: _filterItems,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return _buildListItem(
                          context,
                          title: _filteredItems[index]['title']!,
                          content: _filteredItems[index]['content']!,
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'Tidak ada hasil yang ditemukan.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context,
      {required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00BF63),
            ),
          ),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00BF63),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFDFF2E0),
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                  ),
                ),
              ),
            );
          },
        ),
        const Divider(height: 1, thickness: 1, color: Colors.grey),
      ],
    );
  }
}
