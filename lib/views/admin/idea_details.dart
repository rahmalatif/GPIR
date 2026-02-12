import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/model/DR_project.dart';

import '../model/admin_project.dart';

class AdminIdeaDetailsView extends StatelessWidget {

  final AdminProject project;
  const AdminIdeaDetailsView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0F1A),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            "Admin View Idea Details",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Team: ${project.team.join(', ')}",
                style: const TextStyle(
                  color: Color(0xff4699A8),
                  fontSize: 13,
                ),
              ),
      
      
              const SizedBox(height: 14),
              _card(
                title: "Problem",
                text: project.name,
              ),
      
      
      
              const SizedBox(height: 10),
      
              _card(
                title: "Description",
                text: project.description,
              ),
      
              const SizedBox(height: 10),
      
              _featuresCard(),
      
              const SizedBox(height: 10),
      
              _teamCard(),
      
              const Spacer(),
      
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/projectId');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4699A8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Accept Project",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }

  Widget _card({required String title, required String text}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff4699A8),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _featuresCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Features",
            style: TextStyle(
              color: Color(0xff4699A8),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text("• Student QR scanner", style: TextStyle(color: Colors.grey,fontSize: 12)),
          Text("• Secure backend API", style: TextStyle(color: Colors.grey,fontSize: 12)),
          Text("• Multi-role login", style: TextStyle(color: Colors.grey,fontSize: 12)),
          Text("• Admin attendance dashboard", style: TextStyle(color: Colors.grey,fontSize: 12)),
          Text("• Student analytics", style: TextStyle(color: Colors.grey,fontSize: 12)),
        ],
      ),
    );
  }

  Widget _teamCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Team Members",
            style: TextStyle(
              color: Color(0xff4699A8),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text("• Ahmed", style: TextStyle(color: Colors.grey,fontSize: 12)),
          Text("• Sara", style: TextStyle(color: Colors.grey,fontSize: 12)),
          Text("• Omar", style: TextStyle(color: Colors.grey,fontSize: 12)),
        ],
      ),
    );
  }
}
