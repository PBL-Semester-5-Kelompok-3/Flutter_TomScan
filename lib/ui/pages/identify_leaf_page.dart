// import 'package:flutter/material.dart';
// import 'package:toma_scan/ui/pages/home_page.dart';

// class IdentifyLeafPage extends StatelessWidget {
//   const IdentifyLeafPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE8E8DE), // Light beige background
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header with back button and title
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   // Back button
//                   // Container(
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.white,
//                   //     borderRadius: BorderRadius.circular(12),
//                   //   ),
//                   //   child: IconButton(
//                   //     icon: const Icon(Icons.arrow_back),
//                   //     onPressed: () {
//                   //       Navigator.pushReplacementNamed(context, 'home');
//                   //     },
//                   //   ),
//                   // ),
//                   const Expanded(
//                     child: Column(
//                       children: [
//                         Text(
//                           'Scan Your',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'Plant',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Camera preview area
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Camera preview placeholder
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24),
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 2,
//                         ),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(24),
//                         child: Container(
//                           color: Colors.grey[300],
//                           // Add actual camera preview here
//                         ),
//                       ),
//                     ),
//                     // Scan frame overlay
//                     Container(
//                       margin: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24),
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 2,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Bottom controls
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   // Gallery button
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(Icons.photo_library_outlined),
//                   ),
//                   // Capture button
//                   Container(
//                     height: 72,
//                     width: 72,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.black12,
//                         width: 4,
//                       ),
//                     ),
//                   ),
//                   // Flash button
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(Icons.flash_off),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
