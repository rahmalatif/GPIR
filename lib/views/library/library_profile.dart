import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/library.dart';

class LibraryProfileView extends StatelessWidget {
  const LibraryProfileView({super.key, required this.library});
final Library library;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 16),


            Center(
              child: Text(
                library.name ,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 4),



            const SizedBox(height: 30),

            _infoItem("ID", library.id),
            const SizedBox(height: 16),
            _infoItem("Email", library.email ),
            SizedBox(height: 15,),
            IconButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              context.go('/roleSelection');

            },
                icon: Icon(Icons.logout , color: Colors.white,))
          ],
        ),
      ),
    );  }
}

Widget _infoItem(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
