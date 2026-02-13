
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  double similarityPercent = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        similarityPercent = 70;
        isLoading = false;
      });

      if (similarityPercent >= 60) {
        Future.delayed(const Duration(seconds: 10), () {
          context.go('/studentDashboard');
        });
      }
    });
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

    if (similarityPercent == 0) {
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
            color: similarityPercent >= 60
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
          similarityPercent >= 60
              ? "❌ High similarity — Project rejected"
              : "✅ Low similarity — You can submit",
          style: TextStyle(
            color: similarityPercent >= 60
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
              height: 130,
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
                      widget.projectIdea.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
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
