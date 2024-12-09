import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final Function(String) onSubmit;

  const OtpScreen({
    super.key,
    required this.email,
    required this.onSubmit,
  });

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // State for OTP input
  final _otpControllers = List.generate(4, (index) => TextEditingController());
  int _remainingTime = 60;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
        _startResendTimer();
      } else {
        setState(() {
          _isResendEnabled = true;
        });
      }
    });
  }

  void _resendCode() {
    setState(() {
      _remainingTime = 60;
      _isResendEnabled = false;
    });
    _startResendTimer();
    // Here you can add the code to resend the OTP to the email
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
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
                  controller: _otpControllers[index],
                  onChanged: (value) {
                    if (value.length == 1 && index < 3) {
                      FocusScope.of(context).nextFocus();
                    } else if (value.isEmpty && index > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            _isResendEnabled
                ? Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _resendCode,
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
                  )
                : Center(
                    child: Text(
                      'You can resend the code in $_remainingTime seconds',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Join the OTP digits and pass to onSubmit
                final otp =
                    _otpControllers.map((controller) => controller.text).join();
                widget.onSubmit(otp);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Submit OTP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
    super.key,
    required this.controller,
    required this.onChanged,
  });

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
