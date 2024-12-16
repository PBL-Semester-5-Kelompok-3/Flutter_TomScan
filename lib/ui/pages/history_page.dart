import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/history/history_bloc.dart';
import 'package:toma_scan/blocs/history/history_event.dart';
import 'package:toma_scan/blocs/history/history_state.dart';
import 'package:toma_scan/models/history_model.dart';
import 'package:toma_scan/services/history_service.dart';

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
          date: history.createdAt.toString(),
          imageUrl: history.imagePath,
          title: history.disease.toString(),
          description: history.schedule[0].description,
          history: history,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HistoryBloc>(
          create: (context) => HistoryBloc(
              historyService: HistoryService(
                  baseUrl: 'https://tomascan.nurulmustofa.my.id'))
            ..add(LoadHistoriesEvent()),
        ),
        // Tambahkan provider lainnya jika diperlukan
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryLoadedState) {
              return _buildHistoryList(context, state.histories);
            } else if (state is HistoryErrorState) {
              // return Center(child: Text('Error: ${state.message}'));
              return const Center(child: Text('No recent detections found.'));
            } else {
              return const Center(child: Text('No history found'));
            }
          },
        ),
      ),
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
    required History history,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHistoryPage(
              title: history.disease, // Nama penyakit
              imageUrl: history.imagePath, // URL gambar
              disease: history.disease, // Penyakit (String)
              schedule: history.schedule, // Daftar jadwal (List<Schedule>)
              solutions: history.solutions, // Daftar solusi (List<Solution>)
              pests: history.pest, // Daftar hama (List<Pest>)
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
              // Gambar dengan ukuran tetap
              Image.network(
                imageUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8), // Jarak antara gambar dan teks

              // Expanded untuk title dan description agar fleksibel
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Tambahkan elipsis untuk teks panjang
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Tambahkan elipsis untuk description
                      maxLines: 2, // Batasi hingga 2 baris
                    ),
                  ],
                ),
              ),

              // Icon dengan ukuran tetap
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
  final String disease;
  final List<Schedule> schedule;
  final List<Solution> solutions;
  final List<Pest> pests;

  const DetailHistoryPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.disease,
    required this.schedule,
    required this.solutions,
    required this.pests,
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
                    disease,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Schedule'),
                  _buildScheduleSection(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Pests & Diseases'),
                  _buildPestsAndDiseases(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Solutions'),
                  _buildSolutions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildScheduleSection() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: schedule.length,
      itemBuilder: (context, index) {
        final item = schedule[index];
        return ListTile(
          leading: const Icon(Icons.schedule, color: Colors.blue),
          title: Text(item.description),
          subtitle: Text('Disease ID: ${item.idDisease}'),
        );
      },
    );
  }

  Widget _buildPestsAndDiseases() {
    return pests.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pests.length,
            itemBuilder: (context, index) {
              final pest = pests[index];
              return ListTile(
                leading: const Icon(Icons.bug_report, color: Colors.red),
                title: Text(pest.name),
                subtitle: Text('Related Disease ID: ${pest.idDisease}'),
              );
            },
          )
        : const Text('No pests reported for this history.');
  }

  Widget _buildSolutions() {
    return solutions.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: solutions.length,
            itemBuilder: (context, index) {
              final solution = solutions[index];
              return ListTile(
                leading: const Icon(Icons.lightbulb, color: Colors.green),
                title: Text(solution.title),
                subtitle: Text(solution.description),
              );
            },
          )
        : const Text('No solutions available for this history.');
  }
}
