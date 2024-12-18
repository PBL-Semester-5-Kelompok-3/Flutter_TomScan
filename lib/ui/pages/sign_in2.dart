// // custom_text_field.dart
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'package:quickalert/quickalert.dart';
// import 'package:toma_scan/blocs/auth/auth_bloc.dart';
// import 'package:toma_scan/models/sign_in_form_model.dart';
// import 'package:toma_scan/shared/themes.dart';

// class CustomTextField extends StatefulWidget {
//   final String label;
//   final String icon;
//   final bool isPassword;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;

//   const CustomTextField({
//     super.key,
//     required this.icon,
//     required this.label,
//     this.isPassword = false,
//     required this.controller,
//     this.validator,
//   });

//   @override
//   // ignore: library_private_types_in_public_api
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   bool _isPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: widget.controller,
//           obscureText: widget.isPassword && !_isPasswordVisible,
//           decoration: InputDecoration(
//             hintText: widget.label,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide.none,
//             ),
//             filled: true,
//             fillColor: Colors.grey[100],
//             prefixIcon: Image.asset(widget.icon),
//             suffixIcon: widget.isPassword
//                 ? IconButton(
//                     icon: Icon(
//                       _isPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: Colors.grey,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isPasswordVisible = !_isPasswordVisible;
//                       });
//                     },
//                   )
//                 : null,
//           ),
//           validator: widget.validator,
//         ),
//       ],
//     );
//   }
// }

// // social_button.dart
// class SocialLoginButton extends StatelessWidget {
//   final String text;
//   final String iconPath;
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final Color textColor;

//   const SocialLoginButton({
//     super.key,
//     required this.text,
//     required this.iconPath,
//     required this.onPressed,
//     this.backgroundColor = Colors.white,
//     this.textColor = Colors.black87,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           foregroundColor: textColor,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(50),
//             side: BorderSide(color: Colors.grey.shade300),
//           ),
//           minimumSize: const Size(double.infinity, 60),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         ),
//         child: Row(
//           children: [
//             Image.asset(
//               iconPath,
//               height: 24,
//               width: 24,
//             ),
//             Expanded(
//               child: Center(
//                 child: Text(
//                   text,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LoadingModal extends StatelessWidget {
//   const LoadingModal({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//       child: Dialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           height: 150,
//           child: const Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Sign In Process',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // login_screen.dart
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isRememberMeChecked = false;

//   bool validate() {
//     if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
//       return false;
//     }
//     return true;
//   }


//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(color: Colors.black),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: BlocConsumer<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is AuthLoading) {
//             setState(() {
//               const LoadingIndicator(
//                   indicatorType: Indicator.ballPulse,

//                   /// Required, The loading type of the widget
//                   colors: [Colors.white],

//                   /// Optional, The color collections
//                   strokeWidth: 2,

//                   /// Optional, The stroke of the line, only applicable to widget which contains line
//                   backgroundColor: Colors.black,

//                   /// Optional, Background of the widget
//                   pathBackgroundColor: Colors.black

//                   /// Optional, the stroke backgroundColor
//                   );
//             });
//           } else if (state is AuthSuccess) {
//             QuickAlert.show(
//               context: context,
//               type: QuickAlertType.success,
//               text: 'Transaction Completed Successfully!',
//             );
//           } else if (state is AuthFailed) {
//             if (state.e.isEmpty) {
//               state = const AuthFailed('Unknown error occurred');
//             }
//             QuickAlert.show(
//               context: context,
//               type: QuickAlertType.error,
//               title: 'Oops...',
//               text: state.e,
//             );
//             debugPrint(state.e);
//           }
//         },
//         builder: (context, state) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Welcome Back! 👋',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const Text(
//                     'Let\'s Continue Your Green Journey',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   CustomTextField(
//                     icon: 'assets/icons/email.png',
//                     label: 'Email',
//                     controller: _emailController,
//                     validator: (value) {
//                       if (value?.isEmpty ?? true) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextField(
//                     icon: 'assets/icons/password.png',
//                     label: 'Password',
//                     isPassword: true,
//                     controller: _passwordController,
//                     validator: (value) {
//                       if (value?.isEmpty ?? true) {
//                         return 'Please enter your password';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: _isRememberMeChecked, // Bind ke state
//                         onChanged: (value) {
//                           setState(() {
//                             _isRememberMeChecked =
//                                 value ?? false; // Update state
//                           });
//                         },
//                         activeColor: primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                       const Text('Remember Me'),
//                       const Spacer(),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/forgot-password');
//                         },
//                         child: const Text(
//                           'Forgot Password?',
//                           style: TextStyle(
//                             color: Colors.green,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     children: [
//                       const Expanded(child: Divider()),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Text(
//                           'or',
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                       ),
//                       const Expanded(child: Divider()),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   SocialLoginButton(
//                     text: 'Continue with Google',
//                     iconPath: 'assets/icons/google.png',
//                     onPressed: () {},
//                   ),
//                   SocialLoginButton(
//                     text: 'Continue with Facebook',
//                     iconPath: 'assets/icons/facebook.png',
//                     onPressed: () {},
//                   ),
//                   const SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_emailController.text.isNotEmpty &&
//                           _passwordController.text.isNotEmpty) {
//                         final signInData = SignInFormModel(
//                           email: _emailController.text,
//                           password: _passwordController.text,
//                         );
//                         context.read<AuthBloc>().add(AuthLogin(signInData));
//                       } else {
//                         debugPrint('Error sign In process');
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: primaryColor,
//                       minimumSize: const Size(double.infinity, 56),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                     ),
//                     child: const Text(
//                       'Log in',
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
