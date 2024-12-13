import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/PestAndDisease/pestanddisease_bloc.dart'; // Import PestAndDiseaseBloc
import 'package:toma_scan/models/informatifs_model.dart';
import 'package:toma_scan/services/informatif_service.dart'; // Assuming PestAndDiseaseService exists
import 'package:toma_scan/ui/pages/view_pests.dart'; // Assuming you have a view for pests

class PestsDeseasePage extends StatefulWidget {
  const PestsDeseasePage({super.key});

  @override
  State<PestsDeseasePage> createState() => _PestsDeseasePageState();
}

class _PestsDeseasePageState extends State<PestsDeseasePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PestAndDiseaseBloc(InformatifsService())..add(FetchPestAndDiseases()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pests & Diseases'),
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
                  hintText: 'Search Pests and Diseases...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              // BlocBuilder to listen to state changes in PestAndDiseaseBloc
              Expanded(
                child: BlocBuilder<PestAndDiseaseBloc, PestAndDiseaseState>(
                  builder: (context, state) {
                    if (state is PestAndDiseaseLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PestAndDiseaseSuccess) {
                      // Filter pestsDiseases based on search query
                      final pestsDiseases = state.pestAndDiseases
                          .where((pest) => pest.name
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()))
                          .toList();

                      if (pestsDiseases.isEmpty) {
                        return const Center(child: Text('No results found'));
                      }

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: pestsDiseases.length,
                        itemBuilder: (context, index) {
                          return ArticleCard(
                            imageUrl: pestsDiseases[index]
                                .source, // Assuming `source` is an image URL
                            title: pestsDiseases[index].name,
                            onTap: () =>
                                _onPestTap(context, pestsDiseases[index]),
                          );
                        },
                      );
                    } else if (state is PestAndDiseaseError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return const Center(
                          child: Text('No pests and diseases found'));
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

  void _onPestTap(BuildContext context, PestAndDisease pest) {
    // Navigate to the pests' details page with pest information
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewPests(
          name: pest.name,
          description: pest.description,
          warning: pest.warning,
          genus: pest.genus,
          scientificName: pest.scientificName,
          aliases: pest.aliases,
          symptoms: pest.symptoms,
          solutions: pest.solutions,
          source: pest.source,
        ),
      ),
    );
  }
}

// ArticleCard widget to display each pest/disease
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
