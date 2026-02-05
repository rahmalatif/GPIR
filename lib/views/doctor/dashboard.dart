import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning,\nDr. Ahmed Ibrahim';
    if (hour < 17) return 'Good Afternoon,\nDr. Ahmed Ibrahim';
    return 'Good Evening,\nDr. Ahmed Ibrahim';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: Text(
          greeting(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                _projectcard("Pending projects", "7"),
                SizedBox(
                  width: 12,
                ),
                _projectcard("Accepted", '3')
              ],
            ),
            SizedBox(
              height: 15,
            ),
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
            Text(
              "Recent Ideas",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  _projects(
                    "Pending",
                    "Smart Attendance System",
                    "2024",
                    ["Ahmed", "Sara", "Omar"],
                  ),
                  SizedBox(height: 12),
                  _projects(
                    "Accepted",
                    "Health Tracker App",
                    "2024",
                    ["Laila", "Youssef"],
                  ),
                  SizedBox(height: 12),
                  _projects(
                    "Accepted",
                    "Health Tracker App",
                    "2024",
                    ["Laila", "Youssef"],
                  ),
                  SizedBox(height: 12),
                  _projects(
                    "Accepted",
                    "Health Tracker App",
                    "2024",
                    ["Laila", "Youssef"],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),

            Row(
              children: [
                Buttons("View Ideas"),
                const SizedBox(width: 12),
                Buttons("Add Ideas"),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

Widget _projectcard(String projectType, String number) {
  return Expanded(
    child: Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
                color: Colors.cyan, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            projectType,
            style: TextStyle(
                color: Colors.cyan, fontSize: 14, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

Widget _projects(String status, String name, String date, List<String> team) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1D2E),
      borderRadius: BorderRadius.circular(18),
    ),
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
      Text(team.join(", "), style: const TextStyle(color: Colors.grey)),
      Text("Date: $date", style: const TextStyle(color: Colors.grey)),
      Row(
        children: [
          Spacer(),
          TextButton(onPressed: () {}, child: Text("View" , style: TextStyle(
            color: Colors.cyan
          ),) ,),
        ],
      ),
    ],
  ),

  );
}

Widget Buttons(String text) {
  return Expanded(
    child: Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    ),
  );
}
