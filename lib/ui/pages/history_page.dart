import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/history/history_bloc.dart';
import 'package:toma_scan/blocs/history/history_state.dart';
import 'package:toma_scan/models/history_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  // Metode untuk membangun tampilan daftar history
  Widget _buildHistoryList(BuildContext context, List<History> histories) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: histories.length,
      itemBuilder: (context, index) {
        final history = histories[index];
        return _buildHistoryItem(
          context,
          date: history.,
          imageUrl: history.imagePath,
          title: history.title,
          description: history.description,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HistoryLoadedState) {
          return _buildHistoryList(context, state.histories);
        } else if (state is HistoryErrorState) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No history found'));
        }
      },
    );
  }
  //   return ListView(
  //     padding: const EdgeInsets.all(16),
  //     children: [
  //       _buildHistoryItem(
  //         context,
  //         date: 'Today, Dec 23, 2024',
  //         imageUrl:
  //             'https://i5.walmartimages.com/asr/9f8b7456-81d0-4dc2-b422-97cf63077762.0ddba51bbf14a5029ce82f5fce878dee.jpeg',
  //         title: 'Abiotic',
  //         description:
  //             'Abiotic diseases are caused by non-living factors, such as adverse environmental condit..',
  //       ),
  //       _buildHistoryItem(
  //         context,
  //         date: 'Yesterday, Dec 22, 2024',
  //         imageUrl:
  //             'https://i5.walmartimages.com/asr/9f8b7456-81d0-4dc2-b422-97cf63077762.0ddba51bbf14a5029ce82f5fce878dee.jpeg',
  //         title: 'Healthy Plant',
  //         description: 'No health problems or diseases were detected',
  //       ),
  //       _buildHistoryItem(
  //         context,
  //         date: 'Dec 20, 2024',
  //         imageUrl:
  //             'https://i5.walmartimages.com/asr/9f8b7456-81d0-4dc2-b422-97cf63077762.0ddba51bbf14a5029ce82f5fce878dee.jpeg',
  //         title: 'Ascomycetes',
  //         description:
  //             'Ascomycetes are a diverse group of fungi that includes plant pathogens causing vari..',
  //       ),
  //     ],
  //   );
  // }

  Widget _buildHistoryItem(
    BuildContext context, {
    required String date,
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHistoryPage(
              title: title,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const SizedBox(width: 8),
                        // ...tags.map((tag) => _buildTag(tag)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
          const Divider(height: 32),
        ],
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
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: TextStyle(color: textColor, fontSize: 10),
      ),
    );
  }
}

// Detail History Page class
class DetailHistoryPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  const DetailHistoryPage({
    super.key,
    required this.title,
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
                      // children: tags.map((tag) => _buildDetailTag(tag)).toList(),
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

  Widget _buildDetailTag(String tag) {
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
          style: const TextStyle(
            color: Colors.red,
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
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(right: 12),
            child: const Icon(
              Icons.eco,
              color: Colors.green,
              size: 24,
            ),
          ),
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
