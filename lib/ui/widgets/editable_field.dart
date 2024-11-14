import 'package:flutter/material.dart';

class EditableField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool isEditing;
  final bool isPassword;

  const EditableField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    required this.isEditing,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            enabled: isEditing,
            obscureText: isPassword,
            decoration: InputDecoration(
              border: isEditing ? const UnderlineInputBorder() : InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}