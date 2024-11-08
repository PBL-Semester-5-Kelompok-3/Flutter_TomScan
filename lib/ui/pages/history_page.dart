import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHistoryItem(
          date: 'Today, Dec 23, 2024',
          imageUrl:
              'https://i5.walmartimages.com/asr/9f8b7456-81d0-4dc2-b422-97cf63077762.0ddba51bbf14a5029ce82f5fce878dee.jpeg',
          title: 'Abiotic',
          tags: ['Nutrisi', 'Penyiraman', 'Penyakit'],
          description:
              'Abiotic diseases are caused by non-living factors, such as adverse environmental condit..',
        ),
        _buildHistoryItem(
          date: 'Yesterday, Dec 22, 2024',
          imageUrl:
              'https://i5.walmartimages.com/asr/9f8b7456-81d0-4dc2-b422-97cf63077762.0ddba51bbf14a5029ce82f5fce878dee.jpeg',
          title: 'Healthy Plant',
          tags: ['Penyiraman'],
          description: 'No health problems or diseases were detected',
        ),
        _buildHistoryItem(
          date: 'Dec 20, 2024',
          imageUrl:
              'https://i5.walmartimages.com/asr/9f8b7456-81d0-4dc2-b422-97cf63077762.0ddba51bbf14a5029ce82f5fce878dee.jpeg',
          title: 'Ascomycetes',
          tags: ['Nutrisi', 'Penyakit'],
          description:
              'Ascomycetes are a diverse group of fungi that includes plant pathogens causing vari..',
        ),
      ],
    );
  }

  Widget _buildHistoryItem({
    required String date,
    required String imageUrl,
    required String title,
    required List<String> tags,
    required String description,
  }) {
    return Column(
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
                      const SizedBox(width: 8),
                      ...tags.map((tag) => _buildTag(tag)).toList(),
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
