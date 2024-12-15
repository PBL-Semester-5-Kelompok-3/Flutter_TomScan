import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toma_scan/ui/pages/analysis_page.dart';
import 'package:http/http.dart' as http;

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(CameraApp(cameras: _cameras));
}

class CameraApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraApp({super.key, required this.cameras});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp>
    with SingleTickerProviderStateMixin {
  late CameraController _controller;
  final GlobalKey _cameraPreviewKey = GlobalKey();
  bool _isFlashOn = false;
// Added state variable for dialog
  final storage = const FlutterSecureStorage();

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void handleGallerySelection() async {
    try {
      // Pilih gambar dari galeri
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final imagePath = pickedFile.path;

        // Tampilkan dialog loading
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );

        // Kirim gambar ke API pertama
        final response = await _sendImageToAPI(imagePath);

        // Tutup dialog loading
        if (mounted) Navigator.of(context).pop();

        // Ambil token dari secure storage
        String? token = await storage.read(key: 'token');

        if (response != null) {
          final predictedClass = response['predicted_class'];
          final confidence = response['confidence'];

          // Kirim hasil prediksi ke API kedua untuk mendapatkan data tambahan
          final additionalData =
              await _sendPredictResultToAPI(predictedClass, token ?? '');

          if (additionalData != null) {
            // Navigasikan ke DetailAnalysisPage dengan data tambahan
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailAnalysisPage(
                  title: predictedClass,
                  tags: [
                    'Confidence: ${(confidence * 100).toStringAsFixed(2)}%'
                  ],
                  imageUrl: imagePath,
                  schedule: additionalData['schedule'],
                  solutions: additionalData['solutions'],
                  pests: additionalData['pest'],
                ),
              ),
            );
          } else {
            // Tampilkan pesan error jika API kedua gagal
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Failed to fetch additional data. Please try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          // Tampilkan pesan error jika API pertama gagal
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to process the image. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error selecting image from gallery: $e');
    }
  }

  Future<Map<String, dynamic>?> _sendImageToAPI(String imagePath) async {
    try {
      final uri =
          Uri.parse('https://deb5-180-248-25-27.ngrok-free.app/predict/');
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'ngrok-skip-browser-warning': 'true', // Untuk ngrok
      });

      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        debugPrint('Error: ${response.statusCode}');
        debugPrint('Error: {$response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error sending image: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> _sendPredictResultToAPI(
      String disease, String token) async {
    final uri =
        Uri.parse('https://tomascan.nurulmustofa.my.id/api/getAfterScan');
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'disease': disease}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        debugPrint(
            'Success fetching additional data: ${jsonResponse.toString()}');
        return jsonResponse;
      } else {
        debugPrint(
            'Failed to fetch additional data 1. Status code: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching additional data: $e');
      return null;
    }
  }

  void handleCapture() async {
    try {
      final pickedFile = await _controller.takePicture();
      final imagePath = pickedFile.path;

      // Tampilkan dialog loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      // Kirim gambar ke API pertama
      final response = await _sendImageToAPI(imagePath);

      // Tutup dialog loading
      if (mounted) Navigator.of(context).pop();

      String? token = await storage.read(key: 'token');
      if (response != null) {
        final predictedClass = response['predicted_class'];
        final confidence = response['confidence'];
        // Kirim hasil prediksi ke API kedua untuk mendapatkan data tambahan
        final additionalData =
            await _sendPredictResultToAPI(predictedClass, token ?? '');

        if (additionalData != null) {
          // Navigasikan ke DetailAnalysisPage dengan data tambahan
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailAnalysisPage(
                title: predictedClass,
                tags: ['Confidence: ${(confidence * 100).toStringAsFixed(2)}%'],
                imageUrl: imagePath,
                schedule: additionalData['schedule'],
                solutions: additionalData['solutions'],
                pests: additionalData['pest'],
              ),
            ),
          );
        } else {
          // Tampilkan pesan error jika API kedua gagal
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Failed to fetch additional data. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Tampilkan pesan error jika API pertama gagal
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to process the image. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error capturing image: $e');
    }
  }

  void _toggleFlash() async {
    if (_controller.value.isInitialized) {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      await _controller.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
    }
  }

  Future<void> _openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      debugPrint('Selected image path: ${pickedFile.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE5E2D3),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
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
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Scan Your',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Plant',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        key: _cameraPreviewKey,
                        borderRadius: BorderRadius.circular(24),
                        child: AspectRatio(
                          aspectRatio: 3 / 4,
                          child: CameraPreview(_controller),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        final animationValue = _animation.value *
                            MediaQuery.of(context).size.height *
                            0.5;
                        return Positioned(
                          top: animationValue,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            color: Colors.greenAccent.withOpacity(0.8),
                          ),
                        );
                      },
                    ),
                    Positioned.fill(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          final height = constraints.maxHeight;
                          return CustomPaint(
                            painter:
                                BorderPainter(width: width, height: height),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
            Container(
              color: const Color(0xffF3F2ED),
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: handleGallerySelection,
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
                      child: const Icon(Icons.photo_library_outlined),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        // Capture an image
                        final pickedFile = await _controller.takePicture();

                        // Pause the camera preview while the dialog is open
                        _controller.pausePreview();
                        setState(() {});
                        handleCapture();
                        // showDialog(
                        //   // ignore: use_build_context_synchronously
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     String labelText = '';
                        //     return AlertDialog(
                        //       title: const Text('Name the label?'),
                        //       content: TextField(
                        //         onChanged: (value) {
                        //           labelText = value;
                        //         },
                        //         decoration: const InputDecoration(
                        //           hintText: 'Type the label name...',
                        //         ),
                        //       ),
                        //       actions: [
                        //         TextButton(
                        //           child: const Text('Cancel'),
                        //           onPressed: () {
                        //             // Close the dialog, reset the _showDialog state, and resume the camera
                        //             setState(() {});
                        //             Navigator.of(context).pop();
                        //             _controller.resumePreview();
                        //           },
                        //         ),
                        //         TextButton(
                        //           child: const Text('Accept'),
                        //           onPressed: () {
                        //             setState(() {});
                        //             Navigator.of(context).pop();
                        //             _controller
                        //                 .resumePreview(); // Resume preview on Accept
                        //             // Navigator.push(
                        //             //   context,
                        //             //   MaterialPageRoute(
                        //             //     builder: (context) =>
                        //             //         DetailAnalysisPage(
                        //             //       title: labelText,
                        //             //       tags: const [
                        //             //         'Nutrisi',
                        //             //         'Penyiraman',
                        //             //         'Penyakit'
                        //             //       ],
                        //             //       imageUrl: pickedFile.path,
                        //             //     ),
                        //             //   ),
                        //             // );
                        //           },
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // );

                        // Pause the camera preview while the dialog is open
                        _controller.pausePreview();
                      } catch (e) {
                        print('Error capturing image: $e');
                      }
                    },
                    child: Container(
                      height: 72,
                      width: 72,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black12,
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleFlash,
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
                      child:
                          Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
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
}

class BorderPainter extends CustomPainter {
  final double width;
  final double height;

  BorderPainter({required this.width, required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const radius = 24.0;
    const length = 40.0;

    canvas.drawLine(const Offset(0, radius), const Offset(0, length), paint);
    canvas.drawLine(const Offset(radius, 0), const Offset(length, 0), paint);

    canvas.drawLine(
        Offset(width - length, 0), Offset(width - radius, 0), paint);
    canvas.drawLine(Offset(width, radius), Offset(width, length), paint);

    canvas.drawLine(
        Offset(0, height - length), Offset(0, height - radius), paint);
    canvas.drawLine(Offset(radius, height), Offset(length, height), paint);

    canvas.drawLine(
        Offset(width - length, height), Offset(width - radius, height), paint);
    canvas.drawLine(
        Offset(width, height - length), Offset(width, height - radius), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
