import 'package:flutter/material.dart';

class PendingIdeasView extends StatelessWidget {
  const PendingIdeasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: Center(
          child: Text(
            "Pending Ideas",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1A1D2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView(
                children: [
                  _projects(
                    "Pending",
                    "Smart Attendance System",
                    "2024",
                    ["Ahmed", "Sara", "Omar"],
                    "A mobile app for QR-based student attendance system",
                  ),
                  SizedBox(height: 12),
                  _projects(
                    "Accepted",
                    "Health Tracker App",
                    "2024",
                    ["Laila", "Youssef"],
                    "A mobile app for QR-based student attendance system",
                  ),
                  SizedBox(height: 12),
                  _projects(
                    "Accepted",
                    "Health Tracker App",
                    "2024",
                    ["Laila", "Youssef"],
                    "A mobile app for QR-based student attendance system",
                  ),
                  SizedBox(height: 12),
                  _projects(
                    "Accepted",
                    "Health Tracker App",
                    "2024",
                    ["Laila", "Youssef"],
                    "A mobile app for QR-based student attendance system",
                  ),
                  _projects(
                    "Pending",
                    "Smart Attendance System",
                    "2024",
                    ["Ahmed", "Sara", "Omar"],
                    "A mobile app for QR-based student attendance system",
                  ),
                  SizedBox(height: 12),
                  _projects(
                    "Accepted",
                    "Health Tracker App",
                    "2024",
                    ["Laila", "Youssef"],
                    "A mobile app for QR-based student attendance system",
                  ),
                  SizedBox(height: 12),
                  _projects(
                    "Accepted",
                    "Health Tracker App",
                    "2024",
                    ["Laila", "Youssef"],
                    "A mobile app for QR-based student attendance system",
                  ),
                  SizedBox(height: 12),
                  _projects(
                    "Accepted",
                    "Health Tracker App",
                    "2024",
                    ["Laila", "Youssef"],
                    "A mobile app for QR-based student attendance system",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyan,
        onPressed: () {},
        label: const Text(
          "Add Idea",
          style: TextStyle(color: Colors.black),
        ),
        icon: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget _projects(String status, String name, String date, List<String> team, String description) {
  return Container(
    width: 320,
    height: 160,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(18),
        border: Border(
          top: BorderSide(color: Colors.grey),
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(name, style: TextStyle(color: Colors.white)),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: status == "Pending" ? Colors.orange : Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(status, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(team.join(", "), style: const TextStyle(color: Colors.grey)),
            SizedBox(
              width: 15,
            ),
            Text("Date: $date", style: const TextStyle(color: Colors.grey)),
          ],
        ),
        Text(
          description,
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        Row(
          children: [
            Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                "View",
                style: TextStyle(color: Colors.cyan),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
