import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/send_documentayion_reminder.dart';

class LibraryProjectDetailsWebView extends StatelessWidget {
  final Map<String, dynamic> project;

  const LibraryProjectDetailsWebView({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: const Text(
          "Project Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWeb = constraints.maxWidth > 768;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(
                        children: [
                          Text(
                            project["title"] ?? project["title"] ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (isWeb) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _infoCard(
                              "Project Code",
                              project["project_code"] ?? "",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _infoCard(
                              "Year",
                              project["Year"] ?? "",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _infoCard(
                              "Status",
                              project["Status"] ?? "",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _infoCard(
                              "Doctor",
                              project["Doctor"] ?? "",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _infoCard(
                              "Teacher Assistant",
                              project["TA"] ?? "",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _infoCard(
                              "Specialization",
                              project["Specialization"] ?? "",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _infoCard(
                              "Tools",
                              project["Tools"] ?? "",
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      _infoCard(
                        "Project Code",
                        project["project_code"] ??
                            project["Project Code"] ??
                            project["﻿Project Code"] ??
                            "",
                      ),
                      _infoCard(
                        "Year",
                        project["Year"] ?? "",
                      ),
                      _infoCard(
                        "Status",
                        project["Status"] ?? "",
                      ),
                      _infoCard(
                        "Doctor",
                        project["Doctor"] ?? "",
                      ),
                      _infoCard(
                        "Teacher Assistant",
                        project["TA"] ?? "",
                      ),
                      _infoCard(
                        "Specialization",
                        project["Specialization"] ?? "",
                      ),
                      _infoCard(
                        "Tools",
                        project["Tools"] ?? "",
                      ),
                    ],
                    const SizedBox(height: 4),
                    _bigCard(
                      "Description",
                      project["description"] ?? project["Description"] ?? "",
                    ),
                    _bigCard(
                      "Future Work",
                      project["Future Work"] ?? project["FutureWork"] ?? "",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.cyan,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value.isEmpty ? "-" : value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bigCard(String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.cyan,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value.isEmpty ? "-" : value,
            style: const TextStyle(
              color: Colors.white,
              height: 1.6,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
