// screens/secure_account_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/auth/auth_bloc.dart';
import 'package:toma_scan/shared/themes.dart';

// constants.dart
class AppColors {
  static const green = Color(0xFF00A86B);
  static const grey = Color(0xFFF5F5F5);
  static const darkGrey = Color(0xFF666666);
}

// widgets/custom_text_field.dart

class CustomTextField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    this.isPassword = false,
    required this.controller,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.darkGrey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscureText,
          validator: widget.validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.grey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.darkGrey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

class SecureAccountScreen extends StatefulWidget {
  const SecureAccountScreen({super.key});

  @override
  State<SecureAccountScreen> createState() => _SecureAccountScreenState();
}

class _SecureAccountScreenState extends State<SecureAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _savePassword() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Memanggil AuthBloc untuk reset password
      BlocProvider.of<AuthBloc>(context).add(
        AuthResetPassword(
          _passwordController.text,
          _confirmPasswordController.text,
          _emailController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                // Menampilkan dialog loading
                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // Tidak dapat menutup dengan klik luar
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
              } else if (state is AuthResetPasswordSuccess) {
                // Menutup dialog loading dan navigasi ke layar success
                Navigator.pop(context); // Menutup dialog loading
                Navigator.pushNamed(context, '/success-screen');
              } else if (state is AuthResetPasswordFailed) {
                // Menutup dialog loading dan menampilkan pesan error
                Navigator.pop(context); // Menutup dialog loading
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Secure Your Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/icons/lock1.png',
                        width: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Almost there! Create a new password for your Plantify account to keep it secure. Remember to choose a strong and unique password.',
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: 'New Password',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Confirm New Password',
                    isPassword: true,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'Save New Password',
                    onPressed: _savePassword,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
