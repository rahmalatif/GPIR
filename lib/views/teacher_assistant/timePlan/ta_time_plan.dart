import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../services/get_time_plan_service.dart';

class TaTimePlanView extends StatefulWidget {
  final String projectId;

  const TaTimePlanView({
    super.key,
    required this.projectId,
  });

  @override
  State<TaTimePlanView> createState() => _TaTimePlanViewState();
}

class _TaTimePlanViewState extends State<TaTimePlanView> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  bool isLoading = true;

  String status = '';
  String planId = '';

  List<Map<String, dynamic>> tasks = [];

  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTimePlan();
  }

  Future<void> getTimePlan() async {
    try {
      final data =
      await GetTimePlanService.getTimePlan(widget.projectId);

      if (data != null) {
        setState(() {
          status = data.status;
          planId = data.id;

          tasks = data.tasks.map((e) {
            return {
              "title": e.title,
              "description": e.description,
              "deadline": DateTime.parse(e.deadline),
            };
          }).toList();
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  Color getStatusColor() {
    switch (status) {
      case 'pending_ta':
        return Colors.orange;

      case 'approved_ta':
        return Colors.green;

      case 'rejected_ta':
        return Colors.red;

      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0D0F1A),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final selectedTasks = tasks.where((task) {
      return isSameDay(
        task['deadline'],
        selectedDay,
      );
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Time Plan Review",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 15),

            Chip(
              backgroundColor: getStatusColor(),
              label: Text(
                status.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TableCalendar(
              firstDay: DateTime(2024),
              lastDay: DateTime(2035),
              focusedDay: focusedDay,

              selectedDayPredicate: (day) =>
                  isSameDay(day, selectedDay),

              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDay = selected;
                  focusedDay = focused;
                });
              },

              eventLoader: (day) {
                return tasks.where((task) {
                  return isSameDay(
                    task['deadline'],
                    day,
                  );
                }).toList();
              },
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tasks",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            selectedTasks.isEmpty
                ? const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "No Tasks For This Day",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              itemCount: selectedTasks.length,
              itemBuilder: (context, index) {
                final task = selectedTasks[index];

                return Card(
                  color: const Color(0xFF1B1E2B),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(
                      task['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 8),

                        Text(
                          task['description'],
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Deadline : ${task['deadline'].toString().split(' ')[0]}",
                          style: const TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Write Comment",
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Approve API
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        "Approve",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Reject API
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "Reject",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}