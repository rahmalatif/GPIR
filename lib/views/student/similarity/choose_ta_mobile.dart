import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/ta_service.dart';
import '../../model/project_idea.dart';

class ChooseTAMobileView extends StatefulWidget {

  final ProjectIdea projectIdea;

  final dynamic doctor;

  const ChooseTAMobileView({

    super.key,

    required this.projectIdea,

    required this.doctor,
  });

  @override
  State<ChooseTAMobileView> createState() =>
      _ChooseTAMobileViewState();
}

class _ChooseTAMobileViewState
    extends State<ChooseTAMobileView> {

  int? selectedIndex;

  List<dynamic> tas = [];

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    loadTAs();
  }

  Future<void> loadTAs() async {

    tas =
    await TAService.getTAs();

    setState(() {

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFF0D0F1A),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFF0D0F1A),

        elevation: 0,

        title: const Text(

          "Choose TA",

          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),

          onPressed: () {

            context.pop();
          },
        ),
      ),

      body: Column(

        children: [

          const SizedBox(height: 16),

          const Text(

            "Select the TA for your Idea",

            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(

            child:

            isLoading

                ? const Center(
              child:
              CircularProgressIndicator(),
            )

                : ListView.builder(

              itemCount:
              tas.length,

              itemBuilder:
                  (context, index) {

                final ta =
                tas[index];

                return TAContainer(

                  ta: ta,

                  isSelected:
                  selectedIndex == index,

                  onTap: () {

                    setState(() {

                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),

          SizedBox(

            width: 300,

            child: ElevatedButton(

              onPressed: () {

                if (selectedIndex == null) {

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(

                    const SnackBar(

                      content: Text(
                        "Please select a TA",
                      ),

                      backgroundColor:
                      Colors.red,
                    ),
                  );

                  return;
                }

                context.go(

                  '/confirmSubmission',

                  extra: {

                    'projectIdea':
                    widget.projectIdea,

                    'doctor':
                    widget.doctor,

                    'ta':
                    tas[selectedIndex!],
                  },
                );
              },

              style:
              ElevatedButton.styleFrom(

                backgroundColor:
                const Color(0xFF0D0F1A),

                side: const BorderSide(

                  color:
                  Color(0xff4699A8),

                  width: 2,
                ),

                shape:
                RoundedRectangleBorder(

                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),

              child: const Text(

                "Select",

                style: TextStyle(

                  fontSize: 16,

                  fontWeight:
                  FontWeight.bold,

                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class TAContainer
    extends StatelessWidget {

  final dynamic ta;

  final bool isSelected;

  final VoidCallback onTap;

  const TAContainer({

    super.key,

    required this.ta,

    required this.isSelected,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        margin:
        const EdgeInsets.symmetric(

          horizontal: 16,
          vertical: 6,
        ),

        padding:
        const EdgeInsets.all(12),

        decoration: BoxDecoration(

          color: isSelected

              ? const Color(
              0xff4699A8)
              .withOpacity(.15)

              : Colors.transparent,

          border: Border.all(

            color: isSelected

                ? const Color(
                0xff4699A8)

                : Colors.white24,

            width:
            isSelected ? 2 : 1,
          ),

          borderRadius:
          BorderRadius.circular(12),
        ),

        child: Row(

          children: [

            const CircleAvatar(

              radius: 24,

              backgroundColor:
              Colors.transparent,

              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    ta['name'],

                    style:
                    const TextStyle(

                      fontSize: 18,

                      color: Colors.white,

                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(

                    ta['specialization'] ??
                        '',

                    style:
                    const TextStyle(

                      color: Colors.grey,

                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}