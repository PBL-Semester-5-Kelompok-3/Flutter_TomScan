import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const ViewCare(),
        '/informative_page': (context) => const InformativePage(),
      },
    );
  }
}

class ViewCare extends StatelessWidget {
  const ViewCare({Key? key}) : super(key: key);

  Widget _buildCareItem(
      int number, String title, String description, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D6A4F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imagePath,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1B4332),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Material(
                    color: Colors.transparent,
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
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Planting',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B4332),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCareItem(
                        1,
                        'Baking Soda Spray',
                        'Mix baking soda with water and spray it on the infected mint leaves every 7-10 days to alter the plant\'s surface pH and inhibit fungal growth.',
                        'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
                      ),
                      _buildCareItem(
                        2,
                        'Neem Oil',
                        'Apply neem oil on leaves to act as a natural insecticide and antifungal treatment.',
                        'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
                      ),
                      _buildCareItem(
                        3,
                        'Pruning',
                        'Remove infected leaves to prevent the spread of fungi or pests.',
                        'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
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

class InformativePage extends StatelessWidget {
  const InformativePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informative Page'),
        backgroundColor: const Color(0xFF2D6A4F),
      ),
      body: const Center(
        child: Text(
          'This is the Informative Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
