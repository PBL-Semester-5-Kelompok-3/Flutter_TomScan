// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:toma_scan/ui/pages/informative_page.dart';

class PestsDeseasePage extends StatelessWidget {
  const PestsDeseasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pests & Diseases'),
        centerTitle: true,
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
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 16),
            // Article Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: 5, // Replace with your dynamic item count
                itemBuilder: (context, index) {
                  if (index == 4) {
                    return GestureDetector(
                      onTap: () {
                        // Handle "Add New Article" button
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        child: const Center(
                          child: Icon(Icons.add, size: 40, color: Colors.black),
                        ),
                      ),
                    );
                  }

                  return ArticleCard(
                    imageUrl:
                        'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
                    title: "Croatia doubles tomato production with Podravka's...",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
