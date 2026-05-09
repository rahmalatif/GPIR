import 'package:flutter/material.dart';

import '../../model/project_idea.dart';

class ConfirmSubmissionWebView
    extends StatelessWidget {

  final dynamic doctor;

  final dynamic ta;

  final ProjectIdea projectIdea;

  const ConfirmSubmissionWebView({

    super.key,

    required this.doctor,

    required this.ta,

    required this.projectIdea,
  });

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body: Center(

        child: Text(
          "Confirm Submission Web",
        ),
      ),
    );
  }
}