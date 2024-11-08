import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onEdit; // Buat opsional agar bisa dihilangkan

  const ProfileItem({super.key, 
    required this.icon,
    required this.label,
    required this.value,
    this.onEdit, // Ubah ke opsional
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileField(label, value, icon),
      ],
    );
  }

  // Method untuk menampilkan informasi profil
  Widget _buildProfileField(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.green[400],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (onEdit != null) // Tampilkan ikon edit hanya jika ada onEdit
                Icon(Icons.edit, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
