import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddIdeaWebView
    extends StatefulWidget {
  const AddIdeaWebView({
    super.key,
  });

  @override
  State<AddIdeaWebView>
  createState() =>
      _AddIdeaWebViewState();
}

class _AddIdeaWebViewState
    extends State<AddIdeaWebView> {
  final _formKey =
  GlobalKey<FormState>();

  final TextEditingController
  ideaController =
  TextEditingController();

  final TextEditingController
  descController =
  TextEditingController();

  final TextEditingController
  fieldController =
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

            child: Form(
              key: _formKey,

              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons
                              .arrow_back,
                          color: Colors
                              .white,
                        ),

                        onPressed:
                            () =>
                            context
                                .pop(),
                      ),

                      const SizedBox(
                          width: 10),

                      const Text(
                        "Add Idea",

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

                  _input(
                    ideaController,
                    "Project Idea",
                  ),

                  const SizedBox(
                      height: 20),

                  _input(
                    descController,
                    "Project Description",
                    maxLines: 5,
                  ),

                  const SizedBox(
                      height: 20),

                  _input(
                    fieldController,
                    "Fields",
                  ),

                  const Spacer(),

                  SizedBox(
                    width:
                    double.infinity,
                    height: 55,

                    child:
                    ElevatedButton(
                      style:
                      ElevatedButton
                          .styleFrom(
                        backgroundColor:
                        const Color(
                            0xFF4FB6C1),

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              14),
                        ),
                      ),

                      onPressed:
                      _submit,

                      child:
                      const Text(
                        "Add Idea",

                        style:
                        TextStyle(
                          color: Colors
                              .black,

                          fontSize: 18,

                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(
      TextEditingController
      controller,
      String hint, {
        int maxLines = 1,
      }) {
    return TextFormField(
      controller: controller,

      maxLines: maxLines,

      style: const TextStyle(
        color: Colors.white,
      ),

      validator: (value) =>
      value == null ||
          value.isEmpty
          ? "This field is required"
          : null,

      decoration: InputDecoration(
        hintText: hint,

        hintStyle:
        const TextStyle(
          color: Colors.grey,
        ),

        filled: true,

        fillColor:
        const Color(
            0xFF1A1D2E),

        border:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(
              14),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!
        .validate()) {
      ScaffoldMessenger.of(
          context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Idea submitted successfully",
          ),

          backgroundColor:
          Colors.green,
        ),
      );

      Future.delayed(
        const Duration(
            seconds: 1),
            () {
          context.pop();
        },
      );
    }
  }
}