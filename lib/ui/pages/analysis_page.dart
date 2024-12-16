import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/scan/scan_bloc.dart';
import 'package:toma_scan/blocs/scan/scan_event.dart';
import 'package:toma_scan/blocs/scan/scan_state.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toma_scan/ui/pages/camera.dart';
import 'package:toma_scan/ui/pages/home_page.dart';

class DetailAnalysisPage extends StatelessWidget {
  final String title;
  final List<String> tags;
  final String imageUrl;
  final int diseaseid;
  final List<dynamic> schedule;
  final List<dynamic> solutions;
  final List<dynamic> pests;

  const DetailAnalysisPage({
    super.key,
    required this.title,
    required this.tags,
    required this.diseaseid,
    required this.imageUrl,
    required this.schedule,
    required this.solutions,
    required this.pests,
  });
  final storage = const FlutterSecureStorage();
  // Show the save confirmation dialog
  Future<bool?> _showSaveConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5), // Creates blur effect
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Save this Change?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'This cannot be undone.\nAll your plants and care reminders will be lost.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show success notification
  void _showSuccessNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Analysis have been saved'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          left: 20,
          right: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // void _handleSave(BuildContext context) async {
  //   String? id_user = await storage.read(key: 'id');
  //   final userId = id_user; // Ganti sesuai ID user
  //   final diseaseId = diseaseid; // Ganti sesuai ID disease
  //   final label = title; // Gunakan judul penyakit sebagai label
  //   final imagePath = imageUrl; // Path gambar yang di-upload

  //   final bloc = BlocProvider.of<ScanBloc>(context);

  //   final result = await _showSaveConfirmation(context);

  //   if (result == true) {
  //     bloc.add(SaveHistoryEvent(
  //       userId: int.parse(userId ?? ''),
  //       diseaseId: diseaseId,
  //       label: label,
  //       imagePath: imagePath,
  //     ));

  //     bloc.stream.listen((state) {
  //       if (state is HistorySaving) {
  //         // Tampilkan loading
  //         showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (_) => const Center(child: CircularProgressIndicator()),
  //         );
  //       } else if (state is HistorySaved) {
  //         Navigator.of(context).pop(); // Tutup loading
  //         Navigator.pushNamed(context, '/home');
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('History saved successfully!'),
  //             backgroundColor: Colors.green,
  //           ),
  //         );
  //       } else if (state is HistorySaveError) {
  //         Navigator.of(context).pop(); // Tutup loading
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(state.message),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       }
  //     });
  //   }
  // }
  Future<Map<String, dynamic>?> sendDataWithImage(
      int idDisease, String imagePath) async {
    try {
      String? token = await storage.read(key: 'token');
      String? id = await storage.read(key: 'id');
      final uri =
          Uri.parse('https://tomascan.nurulmustofa.my.id/api/histories');
      final request = http.MultipartRequest('POST', uri);

      // Header untuk autentikasi atau kebutuhan tambahan
      request.headers.addAll({
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token',
      });

      // Menambahkan data form (field)
      request.fields['id_user'] = id.toString();
      request.fields['id_disease'] = idDisease.toString();

      // Menambahkan file gambar
      request.files
          .add(await http.MultipartFile.fromPath('image_path', imagePath));

      // Mengirim request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Menghandle respons
      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        print('Success: ${jsonResponse.toString()}');
        return jsonResponse;
      } else {
        print('Error: HTTP ${response.statusCode}');
        print('Response Body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error sending data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Image Path: $imageUrl');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.file(
                  File(imageUrl), // Gunakan path lokal
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        // Fetch the available cameras
                        final cameras = await availableCameras();

                        // Navigate to the CameraApp page with the available cameras
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraApp(cameras: cameras),
                          ),
                        );
                      } catch (e) {
                        debugPrint('Error accessing cameras: $e');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
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
                    '$title Disease',
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
                    onPressed: () async {
                      await sendDataWithImage(diseaseid, imageUrl);
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                      // _showSuccessNotification(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save to My Garden',
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

  // ... (rest of the widget methods remain the same)
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
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(schedule
              .map((scheduleItem) => scheduleItem['description'].toString())
              .join('\n')),
        ),
        // const SizedBox(height: 12),
        // _buildScheduleItem('Jum\n5', 'Pemulihan Awal', '07.00 - 09.00'),
        // const SizedBox(height: 8),
        // _buildScheduleItem('Sab\n2', 'Pemulihan dan Nutrisi Tambahan', 'ddd'),
        // const SizedBox(height: 8),
        // _buildScheduleItem(
        //     'Min\n3', 'Perawatan Rutin dan Pemantauan', '07.00 - 09.00'),
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
              _buildPestDiseaseSection('Pests',
                  pests.map((pest) => pest['name'].toString()).toList()),
              const SizedBox(height: 16),
              _buildPestDiseaseSection('Diseases', [title]),
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
        ...solutions.map((solution) {
          return _buildSolutionItem(
            solution['title'],
            solution['description'],
          );
        }),
      ],
    );
  }

  Widget _buildSolutionItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/leaf_icon.png', width: 50, height: 100),
          const SizedBox(width: 1),
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

Future<bool?> _showSaveConfirmation(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Save this Change?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'This cannot be undone.\nAll your plants and care reminders will be lost.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// void _showSuccessNotification(BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: const Row(
//         children: [
//           Icon(Icons.check_circle, color: Colors.white),
//           SizedBox(width: 8),
//           Text('Analysis has been saved'),
//         ],
//       ),
//       backgroundColor: Colors.green,
//       duration: const Duration(seconds: 3),
//       behavior: SnackBarBehavior.floating,
//       margin: EdgeInsets.only(
//         bottom: MediaQuery.of(context).size.height - 100,
//         left: 20,
//         right: 20,
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//     ),
//   );
// }
