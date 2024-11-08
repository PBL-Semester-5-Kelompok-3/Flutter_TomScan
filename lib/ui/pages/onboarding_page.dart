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
    'Identify the Green World Around You',
    'You All-in-One Plant Care Companion',
    'My Plants - A Green Diary Just For You',
  ];

  List<String> subtitles = [
    'Turn your smartphone into a plant expert. Scan any plant using your camera and let Plantify identify it for you.',
    'Tomato Doctor helps you care for your plants, set reminders, document their growth, and diagnose diseases with a quick camera scan',
    'Bring your garden to life! Add your favorite plants, set care reminders, snap progress photos, & explore your planting history.',
  ];

  List<String> images = [
    'assets/iPhone_gray.png',
    'assets/iPhone_gray.png',
    'assets/iPhone_gray.png',
  ];

  void _onContinue() {
    setState(() {
      if (currentIndex < titles.length - 1) {
        currentIndex++;
        _carouselController.nextPage(); // Move to next slide
      }
    });
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

  const OnboardingOverlay({
    super.key,
    required this.currentIndex,
    required this.title,
    required this.subtitle,
    required this.onContinue,
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
                    onPressed: () {},
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
                            context, '/home', (route) => false);
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
