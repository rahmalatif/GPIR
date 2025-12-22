import 'package:flutter/material.dart';

class HaveIdeaView extends StatelessWidget {
  const HaveIdeaView({super.key});

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
            Navigator.pop(context, '/studentDashboard');
          },
        ),
      ),
      backgroundColor: Color(0xFF0D0F1A),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 38.0, top: 18),
              child: Text(
                "Submit Your Idea",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 58.0),
              child: Text(
                "Enter Details about your Graduation project",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _InputText("Project name"),
            SizedBox(
              height: 20,
            ),
            _InputText("Project Description"),
            SizedBox(
              height: 20,
            ),
            _InputText("Project Specializations"),
            SizedBox(
              height: 20,
            ),
            _InputText("Project Features"),
            SizedBox(
              height: 20,
            ),
            _InputText("Project Technologies"),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff4699A8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/similarityCheck');
                },
                child: Text(
                  "Check Similarity",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
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

Widget _InputText(String Data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text("$Data",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
        ),
        SizedBox(height: 3,),
        Center(
          child: Container(
            width: 350,
           height: 40,
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xff4699A8), width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xff4699A8), width: 2.0),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}
