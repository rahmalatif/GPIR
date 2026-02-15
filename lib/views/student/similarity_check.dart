import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/new_idea_services.dart';
import '../model/project.dart';

class SimilarityCheckView extends StatefulWidget {
  final ProjectIdea projectIdea;

  const SimilarityCheckView({
    super.key,
    required this.projectIdea,
  });

  @override
  State<SimilarityCheckView> createState() => _SimilarityCheckViewState();
}

class _SimilarityCheckViewState extends State<SimilarityCheckView> {

  final IdeaServices _ideaService = IdeaServices();

  double similarityPercent = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSimilarity();
  }

  Future<void> fetchSimilarity() async {
    try {
      final result =
      await _ideaService.checkSimilarity(widget.projectIdea);

      setState(() {
        similarityPercent = result;
        isLoading = false;
      });

      if (result >= 80) {
        Future.delayed(const Duration(seconds: 5), () {
          context.go('/studentDashboard');
        });
      }

    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Similarity error: $e");
    }
  }

  Widget buildResultUI() {

    if (isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: Color(0xff4699A8),
            strokeWidth: 8,
          ),
          SizedBox(height: 20),
          Text(
            "Analyzing your project...",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      );
    }

    if (similarityPercent <= 0.01) {
      return const Text(
        "✅ Not Found Before",
        style: TextStyle(fontSize: 30, color: Colors.white),
      );
    }

    return Column(
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: CircularProgressIndicator(
            value: similarityPercent / 100,
            strokeWidth: 12,
            color: similarityPercent >= 80
                ? Colors.red
                : Colors.green,
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
            color: similarityPercent >= 80
                ? Colors.red
                : Colors.green,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/haveIdea'),
        ),
        title: const Text(
          "Similarity Check",
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            const Text(
              "Check if your project has done before",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            Container(
              width: 350,
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xff4699A8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      widget.projectIdea.name,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.projectIdea.introduction,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 50),

            buildResultUI(),

            const Spacer(),

            if (!isLoading && similarityPercent < 60)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4699A8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  context.go(
                    '/chooseSupervisor',
                    extra: widget.projectIdea,
                  );
                },
                child: const Text(
                  "Submit Idea",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
