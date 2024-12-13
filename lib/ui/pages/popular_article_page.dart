import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/informative/informative_bloc.dart'; // Assuming you have InformativeBloc for popular articles
import 'package:toma_scan/models/informatifs_model.dart';
import 'package:toma_scan/services/informatif_service.dart';
import 'package:toma_scan/ui/pages/view_article.dart'; // Assuming ViewArticle page exists

class PopularArticlePage extends StatefulWidget {
  const PopularArticlePage({super.key});

  @override
  _PopularArticlePageState createState() => _PopularArticlePageState();
}

class _PopularArticlePageState extends State<PopularArticlePage> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InformativeBloc(InformatifsService())..add(FetchInformatives()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Popular Article'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search Article...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              // BlocBuilder to listen to state changes in InformativeBloc
              Expanded(
                child: BlocBuilder<InformativeBloc, InformativeState>(
                  builder: (context, state) {
                    if (state is InformativeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is InformativeSuccess) {
                      final informatifs = state.informatives;

                      // Filter informatifs based on search query
                      final filteredInformatives = informatifs
                          .where((informative) => informative.title
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()))
                          .toList();

                      if (filteredInformatives.isEmpty) {
                        return const Center(child: Text('No articles found'));
                      }

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: filteredInformatives.length,
                        itemBuilder: (context, index) {
                          return ArticleCard(
                            imageUrl: filteredInformatives[index].image,
                            title: filteredInformatives[index].title,
                            onTap: () => _onArticleTap(
                                context, filteredInformatives[index]),
                          );
                        },
                      );
                    } else if (state is InformativeError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return const Center(child: Text('No articles found'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onArticleTap(BuildContext context, Informative informative) {
    // Navigate to the article view page with article details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewArticle(
          title: informative.title,
          tag: informative.type,
          imageUrl: informative.image,
          content: informative.content,
        ),
      ),
    );
  }
}

// ArticleCard widget to display each article
class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap;

  const ArticleCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
