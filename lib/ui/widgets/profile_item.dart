// profile_item.dart
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onEdit;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell( // Tambahkan InkWell di sini
        onTap: onEdit, // Seluruh area bisa diklik
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black54,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value.isEmpty ? '••••••••' : value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Color(0xFF00BF63),
                size: 20,
              ),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}