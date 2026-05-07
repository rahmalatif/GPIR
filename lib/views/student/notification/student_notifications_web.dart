import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentNotificationsWebView
    extends StatelessWidget {
  const StudentNotificationsWebView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: Center(
        child: SizedBox(
          width: 900,

          child: Column(
            children: [
              const SizedBox(height: 30),

              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),

                    onPressed: () =>
                        context.go(
                          '/studentDashboard',
                        ),
                  ),

                  const SizedBox(width: 10),

                  const Text(
                    "Notifications",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: StreamBuilder<
                    QuerySnapshot>(
                  stream:
                  FirebaseFirestore
                      .instance
                      .collection(
                      "notifications")
                      .orderBy(
                    "createdAt",
                    descending:
                    true,
                  )
                      .snapshots(),

                  builder: (context,
                      snapshot) {
                    if (snapshot
                        .connectionState ==
                        ConnectionState
                            .waiting) {
                      return const Center(
                        child:
                        CircularProgressIndicator(),
                      );
                    }

                    if (snapshot
                        .hasError) {
                      return Center(
                        child: Text(
                          snapshot.error
                              .toString(),

                          style:
                          const TextStyle(
                            color: Colors
                                .white,
                          ),
                        ),
                      );
                    }

                    if (!snapshot
                        .hasData ||
                        snapshot
                            .data!
                            .docs
                            .isEmpty) {
                      return const Center(
                        child: Text(
                          "No notifications yet",

                          style:
                          TextStyle(
                            color: Colors
                                .white,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }

                    final docs =
                        snapshot
                            .data!.docs;

                    return ListView
                        .builder(
                      padding:
                      const EdgeInsets
                          .all(12),

                      itemCount:
                      docs.length,

                      itemBuilder:
                          (context,
                          i) {
                        final n =
                        docs[i];

                        final seen =
                            n["seen"] ??
                                false;

                        return GestureDetector(
                          onTap:
                              () async {
                            await FirebaseFirestore
                                .instance
                                .collection(
                                "notifications")
                                .doc(n.id)
                                .update({
                              "seen":
                              true
                            });

                            final assignedId = n
                                .data()
                                .toString()
                                .contains(
                                "assignedId")
                                ? n["assignedId"]
                                : null;

                            if (assignedId !=
                                null) {
                              context
                                  .push(
                                '/projectAssigned',

                                extra: {
                                  "projectId":
                                  assignedId,

                                  "status":
                                  "accepted",
                                },
                              );
                            }
                          },

                          child:
                          AnimatedContainer(
                            duration:
                            const Duration(
                              milliseconds:
                              400,
                            ),

                            margin:
                            const EdgeInsets.only(
                              bottom:
                              16,
                            ),

                            padding:
                            const EdgeInsets.all(
                              20,
                            ),

                            decoration:
                            BoxDecoration(
                              color: seen
                                  ? const Color(
                                  0xFF1A1D2E)
                                  : const Color(
                                  0xFF4699A8)
                                  .withOpacity(
                                  .15),

                              borderRadius:
                              BorderRadius.circular(
                                  20),
                            ),

                            child:
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [
                                Text(
                                  n["title"] ??
                                      "",

                                  style:
                                  TextStyle(
                                    color:
                                    Colors.white,

                                    fontSize:
                                    18,

                                    fontWeight: seen
                                        ? FontWeight.w400
                                        : FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                    10),

                                Text(
                                  n["body"] ??
                                      "",

                                  style:
                                  const TextStyle(
                                    color:
                                    Colors.grey,

                                    fontSize:
                                    15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}