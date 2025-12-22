import 'package:flutter/material.dart';

class IdeaToDrView extends StatelessWidget {
  const IdeaToDrView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0F1A),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, '/similarityCheck');
          },
        ),
      ),
      backgroundColor: Color(0xFF0D0F1A),

    );
  }
}
