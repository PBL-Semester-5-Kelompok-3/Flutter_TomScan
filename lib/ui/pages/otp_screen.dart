import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/auth/auth_bloc.dart';
import 'package:toma_scan/ui/pages/reset_password.dart'; // Pastikan ini diimpor dengan benar

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
    // Pemanggilan ulang event BLoC untuk pengiriman OTP
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("OTP code has been resent!")),
    );
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
              'Please check your email inbox for a message from TomaScan. Enter the one-time verification code below.',
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
                    child: TextButton(
                      onPressed: _resendCode,
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color: Colors.green[400],
                          fontSize: 16,
                        ),
                      ),
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
              onPressed: _otpControllers
                      .every((controller) => controller.text.isNotEmpty)
                  ? () {
                      // Gabungkan digit OTP menjadi satu string
                      final otp = _otpControllers
                          .map((controller) => controller.text)
                          .join();

                      // Kirimkan event BLoC untuk memverifikasi OTP
                      context
                          .read<AuthBloc>()
                          .add(AuthVerifyOTP(widget.email, otp));
                    }
                  : null,
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
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthVerifyOTPSuccess) {
                  // Tindakan setelah OTP berhasil diverifikasi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                  // Navigasi ke halaman reset password setelah OTP berhasil
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ResetPasswordScreen(), // Ganti dengan halaman reset password yang sesuai
                    ),
                  );
                } else if (state is AuthVerifyOTPFailed) {
                  // Jika OTP gagal diverifikasi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: Container(),
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
