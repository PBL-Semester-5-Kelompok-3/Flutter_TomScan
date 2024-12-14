import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:toma_scan/shared/themes.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  List<String> titles = [
    'Tomato Leaf Disease Detection in an Instant',
    'Latest Articles, Reliable Solutions',
    'Save and Monitor Your Diagnosis Results',
  ];

  List<String> subtitles = [
    'Simply take a picture, and the system will accurately analyze the condition of your tomato leaves.',
    'Read useful information about plant diseases, treatments, and the best cultivation techniques.',
    'View identification history to monitor the progress of plant health over time.',
  ];

  List<String> images = [
    'assets/images/onboarding1.png',
    'assets/images/onboarding2.png',
    'assets/images/onboarding3.png',
  ];

  void _onContinue() {
    setState(() {
      if (currentIndex < titles.length - 1) {
        currentIndex++;
        _carouselController.nextPage(); // Move to next slide
      }
    });
  }

  void _onSkip() {
    // Navigasi ke halaman home
    Navigator.pushNamedAndRemoveUntil(
        context, '/get-started', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SafeArea(
                    child: CarouselSlider(
                      items: images
                          .map((image) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Image.asset(
                                  image,
                                  fit: BoxFit.fill,
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: double.infinity,
                        viewportFraction: 1,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      carouselController:
                          _carouselController, // Attach the controller
                    ),
                  ),
                  OnboardingOverlay(
                    currentIndex: currentIndex,
                    title: titles[currentIndex],
                    subtitle: subtitles[currentIndex],
                    onContinue: _onContinue,
                    onSkip: _onSkip, // Tambahkan parameter untuk onSkip
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

class OnboardingOverlay extends StatelessWidget {
  final int currentIndex;
  final String title;
  final String subtitle;
  final VoidCallback onContinue;
  final VoidCallback onSkip; // Tambahkan parameter untuk onSkip

  const OnboardingOverlay({
    super.key,
    required this.currentIndex,
    required this.title,
    required this.subtitle,
    required this.onContinue,
    required this.onSkip, // Tambahkan parameter ini
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(35.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, color: Color(0xff838383)),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: currentIndex == index ? 35 : 12,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? primaryColor
                        : const Color(0xffD9D9D9),
                    borderRadius: currentIndex == index
                        ? BorderRadius.circular(6)
                        : BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onSkip, // Panggil fungsi onSkip
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffEBF8F3),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xff19AD77),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentIndex == 2) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/get-started', (route) => false);
                      } else {
                        onContinue();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff19AD77),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
