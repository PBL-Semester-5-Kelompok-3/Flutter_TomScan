import 'package:flutter/material.dart';

class ViewArticle extends StatelessWidget {
  const ViewArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Image section
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Back button
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            // Title section with background color
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color(0xFFEAF1F1), // Light gray with a hint of green
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Whiteflies',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B4332),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Article tag
                    Row(
                      children: [
                        Icon(
                          Icons.eco,
                          size: 16,
                          color: Colors.green.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Article',
                          style: TextStyle(
                            color: Colors.green.shade400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Article content
                    const Text(
                      'Mint (Mentha) is a versatile herb widely used for its refreshing flavor and medicinal properties. It is commonly used in cooking to add flavor to dishes, teas, and beverages. In herbal medicine, mint helps with digestion, relieves headaches, and soothes cold symptoms.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1B4332),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Got it button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Got it',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
