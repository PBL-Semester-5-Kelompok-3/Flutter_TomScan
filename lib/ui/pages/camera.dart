import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:toma_scan/ui/pages/analysis_page.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(CameraApp(cameras: _cameras));
}

class CameraApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const CameraApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IdentifyLeafPage(cameras: cameras),
    );
  }
}

class IdentifyLeafPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const IdentifyLeafPage({super.key, required this.cameras});

  @override
  State<IdentifyLeafPage> createState() => _IdentifyLeafPageState();
}

class _IdentifyLeafPageState extends State<IdentifyLeafPage> {
  late CameraController _controller;
  final GlobalKey _cameraPreviewKey =
      GlobalKey(); // GlobalKey to access container

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    bool _showDialog = false;
    return Scaffold(
      backgroundColor: const Color(0xFFE5E2D3),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Back button
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
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/home'),
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
            const SizedBox(
              height: 100,
            ),
            // Camera preview area with rounded frame and padding
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Camera preview with padding inside the border
                    Padding(
                      padding: const EdgeInsets.all(20.0), // Adding padding
                      child: ClipRRect(
                        key: _cameraPreviewKey, // Use the GlobalKey here
                        borderRadius: BorderRadius.circular(24),
                        child: AspectRatio(
                          aspectRatio: 3 / 4,
                          child: CameraPreview(_controller),
                        ),
                      ),
                    ),
                    // Border overlay with only rounded corners
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
            // Bottom controls
            const SizedBox(
              height: 100,
            ),
            Container(
              color: const Color(0xffF3F2ED),
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Gallery button
                  Container(
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
                  // Capture button
                  GestureDetector(
                    onTap: () async {
                      try {
                        // Capture an image
                        final pickedFile = await _controller.takePicture();

                        // Pause the camera preview while the dialog is open
                        _controller.pausePreview();

                        setState(() {
                          _showDialog = true;
                        });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String labelText = '';
                            return AlertDialog(
                              title: const Text('Name the label?'),
                              content: TextField(
                                onChanged: (value) {
                                  labelText = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Type the label name...',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    // Close the dialog, reset the _showDialog state, and resume the camera
                                    setState(() {
                                      _showDialog = false;
                                    });
                                    Navigator.of(context).pop();
                                    _controller
                                        .resumePreview(); // Resume preview on Cancel
                                  },
                                ),
                                TextButton(
                                  child: const Text('Accept'),
                                  onPressed: () {
                                    setState(() {
                                      _showDialog = false;
                                    });
                                    Navigator.of(context).pop();
                                    _controller
                                        .resumePreview(); // Resume preview on Accept
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailAnalysisPage(
                                          title: labelText,
                                          tags: [
                                            'Nutrisi',
                                            'Penyiraman',
                                            'Penyakit'
                                          ],
                                          imageUrl: pickedFile.path,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
                  Container(
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
                    child: const Icon(Icons.flash_off),
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

    // Draw top-left corner
    canvas.drawLine(const Offset(0, radius), const Offset(0, length), paint);
    canvas.drawLine(const Offset(radius, 0), const Offset(length, 0), paint);

    // Draw top-right corner
    canvas.drawLine(
        Offset(width - length, 0), Offset(width - radius, 0), paint);
    canvas.drawLine(Offset(width, radius), Offset(width, length), paint);

    // Draw bottom-left corner
    canvas.drawLine(
        Offset(0, height - length), Offset(0, height - radius), paint);
    canvas.drawLine(Offset(radius, height), Offset(length, height), paint);

    // Draw bottom-right corner
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
