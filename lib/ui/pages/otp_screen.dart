import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/forgot/bloc/forgot_bloc.dart';
import 'package:toma_scan/ui/pages/secure_password.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final Function(String) onSubmit;

  const OtpScreen({
    super.key,
    required this.email,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(),
      child: OtpScreenBody(email: email, onSubmit: onSubmit),
    );
  }
}

class OtpScreenBody extends StatelessWidget {
  final String email;
  final Function(String) onSubmit;

  const OtpScreenBody({
    super.key,
    required this.email,
    required this.onSubmit,
  });

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
            BlocBuilder<OtpBloc, OtpState>(
              builder: (context, state) {
                if (state is OtpResendState) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'You can resend the code in ${state.remainingTime} seconds',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: state.remainingTime == 0
                              ? () {
                                  context.read<OtpBloc>().add(OtpResendEvent());
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
                  );
                }
                return const SizedBox
                    .shrink(); // Empty state if not OtpResendState
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OtpDigitField extends StatelessWidget {
  final Function(String) onChanged;

  const OtpDigitField({
    super.key,
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
