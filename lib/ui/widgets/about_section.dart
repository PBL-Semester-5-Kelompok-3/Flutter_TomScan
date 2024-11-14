import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tentang',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.description_outlined, color: Colors.black54),
            title: const Text('Syarat dan Ketentuan'),
            trailing: const Icon(Icons.chevron_right, color: Colors.black54),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shield_outlined, color: Colors.black54),
            title: const Text('Kebijakan Privasi'),
            trailing: const Icon(Icons.chevron_right, color: Colors.black54),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.black54),
            title: const Text('Pusat Bantuan'),
            trailing: const Icon(Icons.chevron_right, color: Colors.black54),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}