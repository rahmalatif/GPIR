import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/services/idea_service.dart';

import '../../../services/new_project_service.dart';
import '../../model/project_idea.dart';

class SimilarityCheckWebView
    extends StatefulWidget {
  final ProjectIdea projectIdea;

  const SimilarityCheckWebView({
    super.key,
    required this.projectIdea,
  });

  @override
  State<SimilarityCheckWebView>
  createState() =>
      _SimilarityCheckWebViewState();
}

class _SimilarityCheckWebViewState
    extends State<SimilarityCheckWebView> {

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
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: Center(
        child: SizedBox(
          width: 900,
          child: buildResultUI(),
        ),
      ),
    );
  }

  Future<void> fetchSimilarity() async {
    try {
      final result =
      await IdeaServices;

      setState(() {
        similarityPercent =100;
           // result.similarity.toDouble();

        isLoading = false;
      });
    } catch (e) {
      print("ERROR: $e");

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  }

  Widget buildResultUI() {
    if (isLoading) {
      return Column(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: const [
          CircularProgressIndicator(
            color: Color(0xff4699A8),
            strokeWidth: 10,
          ),

          SizedBox(height: 30),

          Text(
            "Analyzing your project...",

            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ],
      );
    }

    if (similarityPercent <= 1) {
      return Column(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [
          const Text(
            "✅ Not Found Before",

            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          SizedBox(
            width: 250,

            child: ElevatedButton(
              onPressed: () {
                context.go(
                  '/chooseSupervisor',
                  extra:
                  widget.projectIdea,
                );
              },

              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                const Color(
                    0xff4699A8),

                padding:
                const EdgeInsets
                    .symmetric(
                  vertical: 18,
                ),
              ),

              child: const Text(
                "Continue",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,

      children: [
        SizedBox(
          width: 200,
          height: 200,

          child:
          CircularProgressIndicator(
            value:
            similarityPercent / 100,

            strokeWidth: 14,

            color: similarityPercent >= 80
                ? Colors.red
                : Colors.green,
          ),
        ),

        const SizedBox(height: 30),

        Text(
          "${similarityPercent.toInt()}% Similarity",

          style: const TextStyle(
            fontSize: 34,
            color: Colors.white,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          similarityPercent >= 80
              ? "❌ High similarity — Project rejected"
              : "✅ Low similarity — You can submit",

          style: TextStyle(
            color:
            similarityPercent >= 80
                ? Colors.red
                : Colors.green,

            fontSize: 20,
          ),
        ),

        const SizedBox(height: 40),

        if (similarityPercent < 80)
          SizedBox(
            width: 250,

            child: ElevatedButton(
              onPressed: () {
                context.go(
                  '/chooseSupervisor',
                  extra:
                  widget.projectIdea,
                );
              },

              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                const Color(
                    0xff4699A8),

                padding:
                const EdgeInsets
                    .symmetric(
                  vertical: 18,
                ),
              ),

              child: const Text(
                "Continue",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
      ],
    );
  }
}