import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/idea_service.dart';
import '../../../services/new_project_service.dart';
import '../../model/project_idea.dart';

class SimilarityCheckMobileView extends StatefulWidget {
  final ProjectIdea projectIdea;

  const SimilarityCheckMobileView({
    super.key,
    required this.projectIdea,
  });

  @override
  State<SimilarityCheckMobileView> createState() =>
      _SimilarityCheckMobileViewState();
}

class _SimilarityCheckMobileViewState extends State<SimilarityCheckMobileView> {

  double similarityPercent = 0;

  bool isLoading = true;

  List<dynamic> projects = [];

  @override
  void initState() {
    super.initState();
    fetchSimilarity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Similarity Check",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: buildResultUI(),
      ),
    );
  }

  Future<void> fetchSimilarity() async {

    try {

      final result = await IdeaServices()
          .checkSimilarity(widget.projectIdea);

      print("SIMILARITY RESPONSE: $result");

      setState(() {

        similarityPercent =
            (result['similarity'] ?? 0).toDouble();

        projects = result['projects'] ?? [];

        isLoading = false;
      });

    } catch (e) {

      print("ERROR: $e");

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  }


  Widget buildResultUI() {
    if (isLoading) {
      return Center(
        child: Column(
          children: const [
            CircularProgressIndicator(
              color: Color(0xff4699A8),
              strokeWidth: 8,
            ),
            SizedBox(height: 20),
            Text(
              "Analyzing your project...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    if (similarityPercent <= 1) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "✅ Not Found Before",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Container(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.go(
                    '/chooseSupervisor',
                    extra: widget.projectIdea,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4699A8),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: CircularProgressIndicator(
            value: similarityPercent / 100,
            strokeWidth: 12,
            color: similarityPercent >= 80 ? Colors.red : Colors.green,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "${similarityPercent.toInt()}% Similarity",
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          similarityPercent >= 80
              ? "❌ High similarity — Project rejected"
              : "✅ Low similarity — You can submit",
          style: TextStyle(
            color: similarityPercent >= 80 ? Colors.red : Colors.green,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
        if (projects.isNotEmpty)

          SizedBox(
            height: 250,

            child: ListView.builder(

              itemCount: projects.length,

              itemBuilder: (_, index) {

                final project = projects[index];

                return Card(

                  color: const Color(0xff1A1D2E),

                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),

                  child: ListTile(

                    title: Text(
                      project.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const SizedBox(height: 5),

                        Text(
                          "Doctor: ${project.doctor}",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        Text(
                          "Similarity: ${project.similarity}%",
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),

                        Text(
                          "Year: ${project.year}",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        if (similarityPercent < 80)
          ElevatedButton(
            onPressed: () {
              context.go(
                '/chooseSupervisor',
                extra: widget.projectIdea,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4699A8),
            ),
            child: const Text(
              "Continue",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
