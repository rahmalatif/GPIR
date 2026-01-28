import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/core/design/app_image.dart';
import 'package:intl/intl.dart';

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    List<TeamMember> members = [
      TeamMember(name: "Rahma Ahmed", role: "Mobile Developer"),
      TeamMember(name: "Kenzy Mohamed", role: "Backend Developer"),
      TeamMember(name: "AbdElrahman", role: "Backend Developer"),
      TeamMember(name: "Omar Zakaria", role: "AI Developer"),
      TeamMember(name: "Mohamed Ibrahim", role: "AI Developer"),
    ];

     haveAnIdeaOnTap(BuildContext context) {
       context.go(
         '/haveIdea',
       );
    }

    aiRecommendIdea(BuildContext context){
       context.go('/aiRecommend');
    }


    String today = DateFormat('dd MMM yyyy').format(DateTime.now());
    return Scaffold(
      backgroundColor: Color(0xFF0D0F1A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF0D0F1A),
        title: Text(
          "Good Morning, Rahma",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Date
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$today",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            // Details card

            Center(
              child: SizedBox(
                height: 160,
                width: 340,
                child: Card(
                  color: Color(0xff1D1D2E),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Text(
                          "Your Idea is Under Review",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "Supervised By: Dr. Ahmed",
                              style:
                              TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            Spacer(),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size(70, 35),
                                backgroundColor: Color(0xff4699A8),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Accepted",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff4699A8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "View Details",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //options(idea , AI)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => haveAnIdeaOnTap(context),
                  child: Container(
                    height: 120,
                    width: 130,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff4699A8)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: AppImage(image: 'assets/png/idea.png',),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Text("Have an Idea",
                            style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 50),

                GestureDetector(
                  onTap: () => aiRecommendIdea(context),
                  child: Container(
                    height: 120,
                    width: 130,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff4699A8)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: AppImage(image: 'assets/png/ai.png',),
                        ),
                        SizedBox(height: 5),
                        Text("Recommend Idea",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 30,
            ),

            //Team members card
            Center(
              child: SizedBox(

                width: 350,
                height: 300,
                child: Card(
                  color: Color(0xff1D1D2E),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Team Members",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),

                //Members Details
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      final member = members[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 8),
                        child: Row(
                          children: [
                            Text(
                              member.name,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "- ${member.role}",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0, right: 8),
                  child: Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text("Edit Team" , style: TextStyle(
                            color: Colors.white
                          ),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff4699A8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),

                          ),
                      ),
                  ]
                      )
                )
                  ]
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Center(
              child: SizedBox(
                width: 320,
                height: 170,
                child: Card(
                  color: Color(0xff1D1D2E),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //supervisor
                        Text(
                          'Your Supervisor',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Dr. Ahmed Ibrahim",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Spacer(),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xff4699A8),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.chat_bubble,
                                    color: Colors.white, size: 18),
                              ),
                            ),
                          ],
                        ),


                        SizedBox(
                          height: 15,
                        ),

                        //teaching assistant
                        Text(
                          'Your teaching Assestent',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Eng. Noha Ali",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Spacer(),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xff4699A8),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.chat_bubble,
                                    color: Colors.white, size: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMember {
  final String name;
  final String role;

  TeamMember({required this.name, required this.role});
}
