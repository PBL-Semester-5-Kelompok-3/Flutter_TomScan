import 'package:flutter/material.dart';

class ViewPests extends StatelessWidget {
  final String name;
  final String description;
  final String warning;
  final String genus;
  final String scientificName;
  final String aliases;
  final String symptoms;
  final List<String> solutions;
  final String source;

  const ViewPests({
    required this.name,
    required this.description,
    required this.warning,
    required this.genus,
    required this.scientificName,
    required this.aliases,
    required this.symptoms,
    required this.solutions,
    required this.source,
  });

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
          Expanded(
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
                const SizedBox(height: 4),
                Text(
                  warning,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
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
                          source,
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
                          Text(
                            'Genus: $genus',
                            style: TextStyle(
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Scientific Name: $scientificName',
                            style: TextStyle(
                              color: Color(0xFF1B4332),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Also known as: "$aliases", "$genus".',
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
                          Text(
                            '$description',
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
