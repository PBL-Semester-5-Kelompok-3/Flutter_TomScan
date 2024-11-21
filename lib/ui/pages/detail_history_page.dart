import 'package:flutter/material.dart';

class DetailHistoryPage extends StatelessWidget {
  final String title;
  final List<String> tags;
  final String imageUrl;

  const DetailHistoryPage({
    super.key,
    required this.title,
    required this.tags,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  // <-- Ganti bagian ini
                  imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.arrow_back),
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
                  Text(
                    '$title a species of',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: tags.map((tag) => _buildTag(tag)).toList(),
                  ),
                  const SizedBox(height: 24),
                  _buildScheduleSection(),
                  const SizedBox(height: 24),
                  _buildPestsAndDiseases(),
                  const SizedBox(height: 24),
                  _buildSolutions(),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Got it',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    Color bgColor;
    Color textColor;

    switch (tag) {
      case 'Nutrisi':
        bgColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        break;
      case 'Penyiraman':
        bgColor = Colors.yellow[100]!;
        textColor = Colors.yellow[800]!;
        break;
      case 'Penyakit':
        bgColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        break;
      default:
        bgColor = Colors.grey[200]!;
        textColor = Colors.grey[800]!;
    }

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        tag,
        style: TextStyle(color: textColor, fontSize: 12),
      ),
    );
  }

  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Schedule',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildScheduleItem('Jum\n5', 'Pemulihan Awal', '07.00 - 09.00'),
        const SizedBox(height: 8),
        _buildScheduleItem('Sab\n2', 'Pemulihan dan Nutrisi Tambahan', 'ddd'),
        const SizedBox(height: 8),
        _buildScheduleItem(
            'Min\n3', 'Perawatan Rutin dan Pemantauan', '07.00 - 09.00'),
      ],
    );
  }

  Widget _buildScheduleItem(String date, String title, String time) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPestsAndDiseases() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.bug_report, color: Colors.green),
            SizedBox(width: 8),
            Text(
              'Pests & Diseases',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPestDiseaseSection(
                  'Pests', ['Scale insects', 'Mealybugs', 'Spider mites']),
              const SizedBox(height: 16),
              _buildPestDiseaseSection('Diseases', ['Stem rot', 'Root rot']),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPestDiseaseSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: title == 'Pests' ? Colors.red : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(item),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildSolutions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Solutions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSolutionItem(
          'Remove Infected Leaves:',
          'At the first sign of infection, remove and dispose of infected leaves to prevent the spread of rust spores. Do not compost these leaves, as the spores can survive and re-infect plants.',
        ),
        _buildSolutionItem(
          'Improve Air Circulation:',
          'Ensure proper spacing between plants to promote good airflow, reducing moisture levels around the plants. Prune any overcrowded areas to maintain air circulation.',
        ),
        _buildSolutionItem(
          'Watering Practices:',
          'Water the plants at the base, keeping the leaves dry. Watering in the early morning helps the plant dry out during the day, reducing the chances of fungal growth.',
        ),
        _buildSolutionItem(
          'Sanitize Garden Tools:',
          'Regularly clean and disinfect gardening tools, especially after handling infected plants, to prevent the spread of rust spores to healthy plants.',
        ),
      ],
    );
  }

  Widget _buildSolutionItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/leaf_icon.png', width: 24, height: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
