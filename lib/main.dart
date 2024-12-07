import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc
import 'package:toma_scan/ui/pages/forgot_password.dart';
import 'package:toma_scan/ui/pages/get_started.dart';
import 'package:toma_scan/ui/pages/home_page.dart';
import 'package:toma_scan/ui/pages/informative_page.dart';
import 'package:toma_scan/ui/pages/notification_page.dart';
import 'package:toma_scan/ui/pages/onboarding_page.dart';
import 'package:toma_scan/ui/pages/camera.dart';
import 'package:toma_scan/ui/pages/privacy_policy_page.dart';
import 'package:toma_scan/ui/pages/sign_in.dart';
import 'package:toma_scan/ui/pages/sign_up.dart';
import 'package:toma_scan/ui/pages/success_screen.dart';
import 'package:toma_scan/ui/pages/terms_page.dart';
import 'splash_screen.dart';
import 'blocs/auth/auth_bloc.dart'; // Import AuthBloc
import 'services/user_service.dart'; // Import UserService

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  // Buat instance UserService dan sesuaikan API URL
  final userService = UserService(
      apiUrl:
          'http://tomascan.nurulmustofa.my.id/api'); // Sesuaikan URL API dengan endpoint yang benar

  // Wrap MyApp dengan BlocProvider untuk menyediakan AuthBloc dengan UserService
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
          userService: userService), // Injeksi UserService ke dalam AuthBloc
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TomaScan',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/onboarding_page': (context) => const OnboardingPage(),
        '/camera': (context) => CameraApp(cameras: cameras),
        '/get-started': (context) => const GetStarted(),
        '/sign-up': (context) =>
            const SignUpScreen(), // SignUpScreen sekarang punya akses ke AuthBloc
        '/sign-in': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/success-screen': (context) => const SuccessScreenHome(),
        '/PrivacyPolicyPage': (context) => const PrivacyPolicyPage(),
        '/TermsPage': (context) => const TermsPage(),
        '/informative_page': (context) => const InformativePage(),
        '/notification': (context) => NotificationPage(),
      },
    );
  }
}
