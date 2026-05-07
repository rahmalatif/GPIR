import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RejectIdeaWebView
    extends StatefulWidget {
  const RejectIdeaWebView({
    super.key,
  });

  @override
  State<RejectIdeaWebView>
  createState() =>
      _RejectIdeaWebViewState();
}

class _RejectIdeaWebViewState
    extends State<
        RejectIdeaWebView> {
  final TextEditingController
  reasonController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: Center(
        child: SizedBox(
          width: 700,

          child: Padding(
            padding:
            const EdgeInsets.all(
                30),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [
                Row(
                  children: [
                    IconButton(
                      icon:
                      const Icon(
                        Icons
                            .arrow_back,
                        color: Colors
                            .white,
                      ),

                      onPressed:
                          () {
                        if (context
                            .canPop()) {
                          context
                              .pop();
                        }
                      },
                    ),

                    const SizedBox(
                        width: 10),

                    const Text(
                      "Reject Idea",

                      style:
                      TextStyle(
                        color: Colors
                            .white,

                        fontSize:
                        30,

                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                    height: 40),

                const Text(
                  "Reason",

                  style: TextStyle(
                    color:
                    Colors.white,

                    fontSize: 18,
                  ),
                ),

                const SizedBox(
                    height: 14),

                TextField(
                  controller:
                  reasonController,

                  maxLines: 5,

                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                  ),

                  decoration:
                  InputDecoration(
                    hintText:
                    "Enter the reason for rejecting the idea",

                    hintStyle:
                    const TextStyle(
                      color:
                      Colors.grey,
                    ),

                    filled: true,

                    fillColor:
                    const Color(
                        0xFF1A1D2E),

                    border:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(
                          16),

                      borderSide:
                      BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(
                    height: 25),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,

                  children: [
                    _reasonButton(
                      "Not enough details",
                    ),

                    _reasonButton(
                      "Similar to previous project",
                    ),

                    _reasonButton(
                      "Out of scope",
                    ),

                    _reasonButton(
                      "Needs improvement",
                    ),
                  ],
                ),

                const Spacer(),

                GestureDetector(
                  onTap: () {
                    if (reasonController
                        .text
                        .isEmpty) {
                      ScaffoldMessenger
                          .of(
                          context)
                          .showSnackBar(
                        const SnackBar(
                          content:
                          Text(
                            "Please enter rejection reason",
                          ),

                          backgroundColor:
                          Colors.red,
                        ),
                      );

                      return;
                    }

                    context.go(
                      '/doctorDashboard',
                    );

                    ScaffoldMessenger
                        .of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "You have rejected the idea successfully",
                        ),

                        backgroundColor:
                        Colors.red,
                      ),
                    );
                  },

                  child: Container(
                    height: 55,

                    decoration:
                    BoxDecoration(
                      color:
                      Colors.red,

                      borderRadius:
                      BorderRadius.circular(
                          16),
                    ),

                    child:
                    const Center(
                      child: Text(
                        "Reject",

                        style:
                        TextStyle(
                          color: Colors
                              .white,

                          fontSize: 18,

                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _reasonButton(
      String text) {
    return GestureDetector(
      onTap: () {
        reasonController.text =
            text;
      },

      child: Container(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color:
          const Color(
              0xFF1A1D2E),

          borderRadius:
          BorderRadius.circular(
              20),
        ),

        child: Text(
          text,

          style:
          const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}