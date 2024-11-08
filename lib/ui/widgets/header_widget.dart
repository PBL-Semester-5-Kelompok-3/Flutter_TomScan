import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          // Logo dan Nama Aplikasi
          Image.asset(
            'assets/icon2.png', // Ganti dengan path logo TomaScan yang benar
            height: 24,
            width: 24,  // Tambahkan width jika perlu agar logo tampil proporsional
            fit: BoxFit.contain, // Menjaga rasio logo agar tidak terdistorsi
          ),
          const SizedBox(width: 8),
          const Text(
            'TomaScan',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        // Ikon Notifikasi
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {
            // Tambahkan aksi untuk notifikasi
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
