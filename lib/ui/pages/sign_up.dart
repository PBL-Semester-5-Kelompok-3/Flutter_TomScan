import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/auth/auth_bloc.dart';
import 'package:toma_scan/blocs/auth/auth_event.dart';
import 'package:toma_scan/blocs/auth/auth_state.dart';
import 'package:toma_scan/shared/themes.dart';
import 'package:toma_scan/services/user_service.dart';

// Reusable text field component
class CustomTextField extends StatelessWidget {
  final String label;
  final String icon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    this.isPassword = false,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            prefixIcon: Image.asset(icon),
            suffixIcon: isPassword
                ? IconButton(
                    icon: const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      // Toggle password visibility
                    },
                  )
                : null,
          ),
          validator: validator,
        ),
      ],
    );
  }
}

// Reusable social login button
class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          minimumSize: const Size(double.infinity, 60),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 24,
              width: 24,
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingModal extends StatelessWidget {
  const LoadingModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 150,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                'Sign Up Process',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Text(
                    'Join TomaScan Today',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Image.asset(
                      'assets/icons/user.png',
                      width: 32,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const Text(
                'Create Your Blooming Account',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                icon: 'assets/icons/email.png',
                label: 'Email',
                controller: _emailController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  // Add regex for email validation here if needed
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                icon: 'assets/icons/password.png',
                label: 'Password',
                isPassword: true,
                controller: _passwordController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password';
                  }
                  // You can add additional password validation rules here
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign-in');
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(color: Color(0xff77CEAE)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SocialLoginButton(
                text: 'Continue with Google',
                iconPath: 'assets/icons/google.png',
                onPressed: () {},
              ),
              const SizedBox(height: 5),
              SocialLoginButton(
                text: 'Continue with Apple',
                iconPath: 'assets/icons/apple.png',
                onPressed: () {},
              ),
              const SizedBox(height: 5),
              SocialLoginButton(
                text: 'Continue with Facebook',
                iconPath: 'assets/icons/facebook.png',
                onPressed: () {},
              ),
              const SizedBox(height: 24),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const LoadingModal();
                      },
                    );
                  } else if (state is AuthAuthenticated) {
                    Navigator.pop(context); // Close loading modal
                    Navigator.pushReplacementNamed(context, '/home');
                  } else if (state is AuthFailure) {
                    Navigator.pop(context); // Close loading modal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<AuthBloc>().add(
                            AuthSignUpEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
