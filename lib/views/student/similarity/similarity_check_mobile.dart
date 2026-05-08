import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/project_idea.dart';

class SimilarityCheckMobileView extends StatefulWidget {
  final Map<String, dynamic> result;

  final ProjectIdea projectIdea;

  const SimilarityCheckMobileView({
    super.key,
    required this.result,
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

    loadData();
  }

  void loadData() {
    similarityPercent = double.tryParse(
          widget.result['similarity'].toString(),
        ) ??
        0;

    projects = widget.result['projects'] ??
        widget.result['similar_projects'] ??
        widget.result['matchedProjects'] ??
        (widget.result['similarProject'] != null
            ? [widget.result['similarProject']]
            : []);

    isLoading = false;

    print(
      "SIMILARITY RESULT: "
      "${widget.result}",
    );

    print(
      "SIMILAR PROJECTS: "
      "$projects",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: const Text(
          "Similarity Check",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff4699A8),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 170,
                    height: 170,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 170,
                          height: 170,
                          child: CircularProgressIndicator(
                            value: (similarityPercent.clamp(0, 100)) / 100,
                            strokeWidth: 14,
                            backgroundColor: Colors.white12,
                            color: similarityPercent >= 80
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${similarityPercent.toInt()}%",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Similarity",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: similarityPercent >= 80
                          ? Colors.red.withOpacity(.15)
                          : Colors.green.withOpacity(.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      similarityPercent >= 80
                          ? "❌ High similarity — Project rejected"
                          : "✅ Low similarity — You can continue",
                      style: TextStyle(
                        color:
                            similarityPercent >= 80 ? Colors.red : Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  if (projects.isNotEmpty)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Similar Projects",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  const SizedBox(height: 15),

                  if (projects.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: projects.length,
                      itemBuilder: (_, index) {
                        final project = projects[index];

                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff1A1D2E),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// TITLE
                                Text(
                                  project['title']?.toString() ??
                                      "Unknown Project",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                /// DOCTOR
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Doctor: "
                                        "${project['doctor'] ?? 'Unknown'}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                /// YEAR
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Year: "
                                      "${project['year'] ?? 'Unknown'}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                /// BAR
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    minHeight: 10,
                                    value: ((project['similarity'] ?? 0)
                                                .toDouble())
                                            .clamp(0, 100) /
                                        100,
                                    backgroundColor: Colors.white12,
                                    color: Colors.red,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${project['similarity'] ?? 0}% match",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                  /// EMPTY
                  if (projects.isEmpty)
                    const Text(
                      "No similar projects found",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),

                  const SizedBox(height: 30),

                  /// BUTTON
                  if (similarityPercent < 80)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go(
                            '/chooseSupervisor',
                            extra: widget.projectIdea,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4699A8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
