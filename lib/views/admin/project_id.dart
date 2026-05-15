import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/admin_project_details_services.dart';

class ProjectIdView
    extends StatefulWidget {

  final String projectId;

  const ProjectIdView({
    super.key,
    required this.projectId,
  });

  @override
  State<ProjectIdView>
  createState() =>
      _ProjectIdViewState();
}

class _ProjectIdViewState
    extends State<ProjectIdView> {

  final TextEditingController
  idController =
  TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFF0D0F1A),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFF0D0F1A),

        elevation: 0,

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),

          onPressed: () {

            context.pop();
          },
        ),

        title: const Text(

          "Assign Project ID",

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const SizedBox(
              height: 40,
            ),

            const Text(

              "Project Code",

              style: TextStyle(

                color: Colors.white,

                fontSize: 16,

                fontWeight:
                FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            TextField(

              controller:
              idController,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(

                hintText:
                "Ex: CS-2025-001",

                hintStyle:
                const TextStyle(
                  color: Colors.grey,
                ),

                filled: true,

                fillColor:
                const Color(
                  0xFF1A1D2E,
                ),

                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(
                    14,
                  ),

                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),

            const Spacer(),

            SizedBox(

              width: double.infinity,

              height: 50,

              child: ElevatedButton(

                onPressed:
                isLoading

                    ? null

                    : () async {

                  if (idController
                      .text
                      .trim()
                      .isEmpty) {

                    ScaffoldMessenger
                        .of(context)
                        .showSnackBar(

                      const SnackBar(

                        content: Text(
                          "Please enter project code",
                        ),
                      ),
                    );

                    return;
                  }

                  setState(() {

                    isLoading = true;
                  });

                  final success =

                  await
                  AdminProjectDetailsService
                      .approveProject(

                    widget.projectId,
                          idController.text.trim(),
                        );

                        setState(() {

                    isLoading = false;
                  });

                  if (success) {

                    if (context.mounted) {

                      ScaffoldMessenger
                          .of(context)
                          .showSnackBar(

                        const SnackBar(

                          content: Text(
                            "Project Approved Successfully ✅",
                          ),

                          backgroundColor:
                          Colors.green,
                        ),
                      );

                      context.go(
                        '/adminDashboard',
                      );
                    }

                  } else {

                    ScaffoldMessenger
                        .of(context)
                        .showSnackBar(

                      const SnackBar(

                        content: Text(
                          "Something went wrong",
                        ),
                      ),
                    );
                  }
                },

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  const Color(
                    0xff4699A8,
                  ),

                  shape:
                  RoundedRectangleBorder(

                    borderRadius:
                    BorderRadius.circular(
                      14,
                    ),
                  ),
                ),

                child:
                isLoading

                    ? const SizedBox(

                  height: 22,

                  width: 22,

                  child:
                  CircularProgressIndicator(

                    color: Colors.black,

                    strokeWidth: 2,
                  ),
                )

                    : const Text(

                  "Confirm Project ID",

                  style: TextStyle(

                    color: Colors.black,

                    fontSize: 15,

                    fontWeight:
                    FontWeight.w600,
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