import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/informative/informative_bloc.dart';
import 'package:toma_scan/services/informatif_service.dart';
<<<<<<< Updated upstream
import 'package:toma_scan/ui/pages/care_education_page.dart';
import 'package:toma_scan/ui/pages/pests_desease_page.dart';
import 'package:toma_scan/ui/pages/popular_article_page.dart';
=======
>>>>>>> Stashed changes
import 'package:toma_scan/ui/pages/view_article.dart';
import 'package:toma_scan/ui/pages/view_care.dart';
import 'package:toma_scan/ui/pages/view_pests.dart';


class InformativePage extends StatelessWidget {
  const InformativePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informatifs'),
      ),
      body: BlocProvider(
        create: (context) =>
            InformativeBloc(InformatifsService())..add(FetchInformatives()),
        child: BlocBuilder<InformativeBloc, InformativeState>(
          builder: (context, state) {
            if (state is InformativeError &&
                state.message.contains('Failed to load informatifs data')) {
              debugPrint('1');
              debugPrint(state.message);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/sign-in', (route) => false);
            }
            if (state is InformativeLoading) {
              debugPrint('2');
              return const Center(child: CircularProgressIndicator());
            } else if (state is InformativeSuccess) {
              debugPrint('3');
              final informatifs = state.informatives;
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SectionHeader(
                    title: 'Informativs',
                    onViewAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PestsDeseasePage()),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2,
                    ),
                    itemCount: informatifs.length,
                    itemBuilder: (context, index) => ArticleCard(
                      imageUrl: informatifs[index].image,
                      title: informatifs[index].title,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewArticle(
                            title: informatifs[index].title,
                            tag: informatifs[index].type,
                            imageUrl: informatifs[index].image,
                            content: informatifs[index].content,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is InformativeError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No data found'));
            }
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:toma_scan/ui/pages/care_education_page.dart';
// import 'package:toma_scan/ui/pages/pests_desease_page.dart';
// import 'package:toma_scan/ui/pages/popular_article_page.dart';
// import 'package:toma_scan/ui/pages/view_article.dart'; // Tambahkan import
// import 'package:toma_scan/ui/pages/view_care.dart'; // Tambahkan import
// import 'package:toma_scan/ui/pages/view_pests.dart'; // Tambahkan import

// class InformativePage extends StatelessWidget {
//   const InformativePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           SectionHeader(
//               title: 'Popular Article',
//               onViewAll: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const PopularArticlePage()),
//                 );
//               }),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 child: ArticleCard(
//                   imageUrl:
//                       'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
//                   title: "Croatia doubles tomato production with Podravka's...",
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ViewArticle()),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: ArticleCard(
//                   imageUrl:
//                       'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
//                   title: "Croatia doubles tomato production with Podravka's...",
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ViewArticle()),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           SectionHeader(
//               title: 'Care Education',
//               onViewAll: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const CareEducationPage()),
//                 );
//               }),
//           const SizedBox(height: 8),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: [
//               EducationCard(
//                 icon: Icons.local_florist,
//                 title: 'Planting',
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ViewCare()),
//                 ),
//               ),
//               EducationCard(
//                 icon: Icons.nature,
//                 title: 'Planting Training',
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ViewCare()),
//                 ),
//               ),
//               EducationCard(
//                 icon: Icons.location_on,
//                 title: 'Site Selection',
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ViewCare()),
//                 ),
//               ),
//               EducationCard(
//                 icon: Icons.agriculture,
//                 title: 'Field Preparation',
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ViewCare()),
//                 ),
//               ),
//               EducationCard(
//                 icon: Icons.grass,
//                 title: 'Weeding',
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ViewCare()),
//                 ),
//               ),
//               EducationCard(
//                 icon: Icons.water,
//                 title: 'Irrigation',
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ViewCare()),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           SectionHeader(
//               title: 'Pests & Diseases',
//               onViewAll: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const PestsDeseasePage()),
//                 );
//               }),
//           const SizedBox(height: 8),
//           GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 8,
//               crossAxisSpacing: 8,
//               childAspectRatio: 2,
//             ),
//             itemCount: 4,
//             itemBuilder: (context, index) => ArticleCard(
//               imageUrl:
//                   'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
//               title: "Croatia doubles tomato production with Podravka's...",
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ViewPests()),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const SectionHeader(
      {super.key, required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: const Text(
            'View all',
            style: TextStyle(fontSize: 14, color: Colors.green),
          ),
        ),
      ],
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap; // Tambahkan parameter onTap

  const ArticleCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap, // Tambahkan required parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap dengan GestureDetector
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

class EducationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap; // Tambahkan parameter onTap

  const EducationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap, // Tambahkan required parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap dengan GestureDetector
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 4),
            Text(
              title,
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:toma_scan/blocs/informatif/bloc/informatif_bloc.dart';
// import 'package:toma_scan/models/informatif_model.dart';
// import 'package:toma_scan/services/informatif_service.dart';
// import 'package:toma_scan/ui/pages/care_education_page.dart';
// import 'package:toma_scan/ui/pages/pests_desease_page.dart';
// import 'package:toma_scan/ui/pages/popular_article_page.dart';
// import 'package:toma_scan/ui/pages/view_article.dart';
// import 'package:toma_scan/ui/pages/view_care.dart';
// import 'package:toma_scan/ui/pages/view_pests.dart';

// class InformativePage extends StatelessWidget {
//   const InformativePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => InformatifsBloc(InformatifsService()),
//       child: BlocBuilder<InformatifsBloc, InformatifsState>(
//         builder: (context, state) {
//           if (state is InformatifsLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is InformatifsSuccessState) {
//             return Scaffold(
//               body: ListView(
//                 padding: const EdgeInsets.all(16),
//                 children: [
//                   SectionHeader(
//                     title: 'Popular Articleeee',
//                     onViewAll: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const PopularArticlePage()),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: state.informatifsData.map((informatif) {
//                       if (informatif.type == 'article') {
//                         return Expanded(
//                           child: ArticleCard(
//                             imageUrl: informatif.imageUrl,
//                             title: informatif.title,
//                             onTap: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const ViewArticle()),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return const SizedBox.shrink();
//                       }
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 16),
//                   SectionHeader(
//                     title: 'Care Education',
//                     onViewAll: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const CareEducationPage()),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 8),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: state.informatifsData.map((informatif) {
//                       if (informatif.type == 'education') {
//                         return EducationCard(
//                           icon: Icons.local_florist,
//                           title: informatif.title,
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const ViewCare()),
//                           ),
//                         );
//                       } else {
//                         return const SizedBox.shrink();
//                       }
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 16),
//                   SectionHeader(
//                     title: 'Pests & Diseases',
//                     onViewAll: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const PestsDeseasePage()),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 8),
//                   GridView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 8,
//                       crossAxisSpacing: 8,
//                       childAspectRatio: 2,
//                     ),
//                     itemCount: state.informatifsData.length,
//                     itemBuilder: (context, index) {
//                       final informatif = state.informatifsData[index];
//                       if (informatif.type == 'pests') {
//                         return ArticleCard(
//                           imageUrl: informatif.imageUrl,
//                           title: informatif.title,
//                           onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const ViewPests()),
//                           ),
//                         );
//                       } else {
//                         return const SizedBox.shrink();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is InformatifsErrorState) {
//             return Center(child: Text('Error: ${state.error}'));
//           } else {
//             return const SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
// }

// class SectionHeader extends StatelessWidget {
//   final String title;
//   final VoidCallback onViewAll;

//   const SectionHeader({
//     super.key,
//     required this.title,
//     required this.onViewAll,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         GestureDetector(
//           onTap: onViewAll,
//           child: const Text(
//             'View all',
//             style: TextStyle(fontSize: 14, color: Colors.green),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ArticleCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final VoidCallback onTap;

//   const ArticleCard({
//     super.key,
//     required this.imageUrl,
//     required this.title,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 100,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           image: DecorationImage(
//             image: NetworkImage(imageUrl),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.75),
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(8),
//                 bottomRight: Radius.circular(8),
//               ),
//             ),
//             child: Text(
//               title,
//               style: const TextStyle(fontSize: 12),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class EducationCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;

//   const EducationCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.green[100],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, color: Colors.green),
//             const SizedBox(width: 4),
//             Text(
//               title,
//               style: const TextStyle(color: Colors.green),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
