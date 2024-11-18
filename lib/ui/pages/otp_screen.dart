// otp_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:toma_scan/ui/pages/secure_password.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final Function(String) onSubmit;

  const OtpScreen({
    super.key,
    required this.email,
    required this.onSubmit,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  Timer? _timer;
  int _remainingTime = 56;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _navigateToSecureAccount() {
    String otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == 4) {
      // Panggil onSubmit atau arahkan ke halaman Secure Password
      widget.onSubmit(otp); // Atau langsung navigasi
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SecureAccountScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Enter OTP Code',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/icons/lock.png',
                  width: 35,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Please check your email inbox for a message from Plantify. Enter the one-time verification code below.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => OtpDigitField(
                  controller: _controllers[index],
                  onChanged: (value) {
                    if (value.length == 1 && index < 3) {
                      FocusScope.of(context).nextFocus();
                    } else if (value.isEmpty && index > 0) {
                      FocusScope.of(context).previousFocus();
                    }

                    // Cek apakah semua kolom sudah terisi
                    if (index == 3 && value.isNotEmpty) {
                      _navigateToSecureAccount();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    'You can resend the code in $_remainingTime seconds',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _remainingTime == 0
                        ? () {
                            setState(() {
                              _remainingTime = 56;
                            });
                            startTimer();
                          }
                        : null,
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Colors.green[400],
                        fontSize: 16,
                      ),
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

class OtpDigitField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const OtpDigitField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
