import 'package:flutter/material.dart';

class ViewPests extends StatelessWidget {
  const ViewPests({super.key});

  Widget _buildWarningBox() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red[600], size: 24),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Warning!',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'While not known to be toxic, the Peppermint Parachute should not be consumed unless positively identified by an expert. It can be mistaken for other mushrooms, some of which may be harmful. Handle with caution, and avoid consumption unless verified by a mycologist.',
                  style: TextStyle(
                    color: Color(0xFF1B4332),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            child: Icon(
              Icons.eco,
              size: 20,
              color: Colors.green[700],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B4332),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF1B4332),
                    height: 1.5,
                  ),
                ),
              ],
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Image and Back Button
                    Stack(
                      children: [
                        Image.network(
                          'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
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

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Peppermint Parachute',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          const Text(
                            '(Mint Plant Mushroom)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          _buildWarningBox(),
                          const Text(
                            'Genus: ',
                            style: TextStyle(
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          const Text(
                            'Marasmius',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Scientific Name: ',
                            style: TextStyle(
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          const Text(
                            'Marasmius cohaerens',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Also known as: "Marasmius mushroom", "Peppermint Parachute".',
                            style: TextStyle(
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'The Peppermint Parachute is a delicate mushroom with a cap that resembles a parachute, typically white or pale with a minty fragrance when crushed. The stem is slender, often dark brown or black at the base. It is commonly found in mint fields or near plants in the Lamiaceae family, growing on decaying plant matter like dead leaves and wood chips.',
                            style: TextStyle(
                              color: Color(0xFF1B4332),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Solutions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSolutionItem(
                            'Remove Infected Leaves:',
                            'At the first sign of infection, remove and dispose of infected leaves to prevent the spread of rust spores. Do not compost these leaves, as the spores can survive and re-infect plants.',
                          ),
                          _buildSolutionItem(
                            'Improve Air Circulation:',
                            'Ensure proper spacing between plants to promote good airflow, reducing moisture levels around the plants.',
                          ),
                          _buildSolutionItem(
                            'Watering Practices:',
                            'Water the plants at the base, keeping the leaves dry.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Got It Button
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
