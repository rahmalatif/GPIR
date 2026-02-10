import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LibraryDashboardView extends StatelessWidget {
  const LibraryDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: Text("Library Dashboard" , style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),),
      ),
body: Column(
  children: [
    Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _projectcard('Total Projects' , '540'),
          SizedBox(width: 15,),
          _projectcard("This Year projects", "120"),
        ],
      ),
    ),
    SizedBox(height: 30,),
    Column(
      children: [
        _buttons(
          title: "Add old Project",
          onTap: () {
            context.push('/libraryAddProject');
          },
        ),

        const SizedBox(height: 12),

        _buttons(
          title: "View All Project",
          onTap: () {
            context.go('/libraryAllProject');
          },
        ),
      ],
    )

  ],
),
    );
  }
}

Widget _projectcard(String projectType, String number) {
  return Center(
    child: Container(
      height: 130,
      width: 170,
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
                color: Colors.cyan, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            projectType,
            style: TextStyle(
                color: Colors.cyan, fontSize: 14, fontWeight: FontWeight.bold),
          ),

        ],
      ),
    ),
  );
}


Widget _buttons({
  required String title,
  required VoidCallback onTap,
}) {
  return SizedBox(
    width: double.infinity,
    height: 48,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff6EC6D9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 0,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
