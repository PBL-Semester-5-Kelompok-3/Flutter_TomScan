// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class CareEducationPage extends StatelessWidget {
  const CareEducationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Care Education', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Education...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            // List of Care Education
            Expanded(
              child: ListView(
                children: [
                  _buildEducationItem(
                    context,
                    icon: Icons.local_florist,
                    title: 'Planting',
                    color: Colors.green[100]!,
                  ),
                  _buildEducationItem(
                    context,
                    icon: Icons.nature,
                    title: 'Planting Training',
                    color: Colors.green[100]!,
                  ),
                  _buildEducationItem(
                    context,
                    icon: Icons.location_on,
                    title: 'Site Selection',
                    color: Colors.green[100]!,
                  ),
                  _buildEducationItem(
                    context,
                    icon: Icons.agriculture,
                    title: 'Field Preparation',
                    color: Colors.green[100]!,
                  ),
                  _buildEducationItem(
                    context,
                    icon: Icons.grass,
                    title: 'Weeding',
                    color: Colors.green[100]!,
                  ),
                  _buildEducationItem(
                    context,
                    icon: Icons.water,
                    title: 'Irrigation',
                    color: Colors.green[100]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Aksi saat item ditekan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(title: title),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.green, size: 20),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Detail
class DetailPage extends StatelessWidget {
  final String title;

  const DetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Text(
          'Detail tentang $title',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
