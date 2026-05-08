import 'package:flutter/material.dart';

import '../../model/project_idea.dart';

class ChooseTAWebView
    extends StatelessWidget {

  final ProjectIdea projectIdea;

  final dynamic doctor;

  const ChooseTAWebView({

    super.key,

    required this.projectIdea,

    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body: Center(

        child: Text(
          "TA Web View",
        ),
      ),
    );
  }
}