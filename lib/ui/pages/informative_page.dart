import 'package:flutter/material.dart';
import 'package:toma_scan/ui/pages/care_education_page.dart';
import 'package:toma_scan/ui/pages/pests_desease_page.dart';
import 'package:toma_scan/ui/pages/popular_article_page.dart';
import 'package:toma_scan/ui/pages/view_article.dart'; // Tambahkan import
import 'package:toma_scan/ui/pages/view_care.dart'; // Tambahkan import
import 'package:toma_scan/ui/pages/view_pests.dart'; // Tambahkan import

class InformativePage extends StatelessWidget {
  const InformativePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionHeader(
              title: 'Popular Article',
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PopularArticlePage()),
                );
              }),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ArticleCard(
                  imageUrl:
                      'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
                  title: "Croatia doubles tomato production with Podravka's...",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewArticle()),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ArticleCard(
                  imageUrl:
                      'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
                  title: "Croatia doubles tomato production with Podravka's...",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewArticle()),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionHeader(
              title: 'Care Education',
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CareEducationPage()),
                );
              }),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              EducationCard(
                icon: Icons.local_florist,
                title: 'Planting',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewCare()),
                ),
              ),
              EducationCard(
                icon: Icons.nature,
                title: 'Planting Training',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewCare()),
                ),
              ),
              EducationCard(
                icon: Icons.location_on,
                title: 'Site Selection',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewCare()),
                ),
              ),
              EducationCard(
                icon: Icons.agriculture,
                title: 'Field Preparation',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewCare()),
                ),
              ),
              EducationCard(
                icon: Icons.grass,
                title: 'Weeding',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewCare()),
                ),
              ),
              EducationCard(
                icon: Icons.water,
                title: 'Irrigation',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewCare()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionHeader(
              title: 'Pests & Diseases',
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PestsDeseasePage()),
                );
              }),
          const SizedBox(height: 8),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2,
            ),
            itemCount: 4,
            itemBuilder: (context, index) => ArticleCard(
              imageUrl:
                  'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
              title: "Croatia doubles tomato production with Podravka's...",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewPests()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
