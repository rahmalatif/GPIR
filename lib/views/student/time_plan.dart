import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../services/add_task_services.dart';
import '../../services/create_time_plan_service.dart';
import '../../services/get_time_plan_service.dart';

class TimePlanView extends StatefulWidget {
  final String projectId;

  const TimePlanView({super.key, required this.projectId});

  @override
  State<TimePlanView> createState() => _TimePlanScreenState();
}

class _TimePlanScreenState extends State<TimePlanView> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  bool isLoading = true;
  String status = '';
  String planId = '';
  List<Map<String, dynamic>> tasks = [];
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    getTimePlan();
  }

  Future<void> getTimePlan() async {
    try {
      final data = await GetTimePlanService.getTimePlan(widget.projectId);

      if (data != null) {
        print(
            "Data received in UI: ${data.status} - Tasks count: ${data.tasks.length}");

        if (!mounted) return;

        setState(() {
          status = data.status;
          planId = data.id;

          tasks = data.tasks.map<Map<String, dynamic>>((e) {
            return {
              "title": e.title,
              "description": e.description,
              "deadline": DateTime.parse(e.deadline),
            };
          }).toList();
        });

        print("Tasks mapped in state: ${tasks.length}");
      } else {
        status = '';
        tasks = [];
      }
    } catch (e) {
      print("Error in UI getTimePlan: $e");
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  void addTask() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime? deadline;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1B1E2B),
        title: const Text("Add Task", style: TextStyle(color: Colors.white)),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Task Title",
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descriptionController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          setDialogState(() {
                            deadline = pickedDate;
                          });
                        }
                      },
                      child: Text(
                        deadline == null
                            ? "Choose Deadline"
                            : deadline.toString().split(' ')[0],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isEmpty ||
                  descriptionController.text.isEmpty ||
                  deadline == null) {
                return;
              }

              if (planId.isEmpty) {
                setState(() {
                  tasks.add({
                    "title": titleController.text,
                    "description": descriptionController.text,
                    "deadline": deadline,
                  });
                });

                Navigator.of(context).pop();
                return;
              }

              final success = await AddTaskService.addTask(
                planId: planId,
                title: titleController.text,
                description: descriptionController.text,
                deadline: deadline!.toIso8601String(),
              );

              if (!mounted) return;

              Navigator.of(context).pop();

              if (success) {
                await getTimePlan();
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),
        body:
            Center(child: CircularProgressIndicator(color: Colors.tealAccent)),
      );
    }

    final selectedTasks = tasks.where((task) {
      return isSameDay(task['deadline'], selectedDay);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        leading: IconButton(
            onPressed: () {
              context.go('/studentDashboard');
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text("Project Time Plan",
            style: TextStyle(color: Colors.white)),
        actions: [
          if (status.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Chip(
                label: Text(status.toUpperCase()),
                backgroundColor:
                    status == 'pending_ta' ? Colors.orange : Colors.green,
              ),
            )
        ],
      ),
      floatingActionButton: status == 'pending_ta' || status == 'pending_doctor'
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.tealAccent,
              onPressed: addTask,
              child: const Icon(Icons.add, color: Colors.black),
            ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: TableCalendar(
                rowHeight: 42,
                firstDay: DateTime(2024),
                lastDay: DateTime(2035),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                onDaySelected: (selected, focused) {
                  setState(() {
                    selectedDay = selected;
                    focusedDay = focused;
                  });
                },
                eventLoader: (day) {
                  return tasks
                      .where((task) =>
                          isSameDay(task["deadline"] as DateTime, day))
                      .toList();
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    final hasTask =
                        tasks.any((task) => isSameDay(task['deadline'], day));
                    if (hasTask) {
                      return Container(
                        margin: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                            color: Colors.teal, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: selectedTasks.isEmpty
                ? const Center(
                    child: Text("No Tasks For This Day",
                        style: TextStyle(color: Colors.white70, fontSize: 16)),
                  )
                : ListView.builder(
                    itemCount: selectedTasks.length,
                    itemBuilder: (context, index) {
                      final task = selectedTasks[index];
                      return Card(
                        color: const Color(0xFF1B1E2B),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: ListTile(
                          title: Text(
                            task['title'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              Text(task['description'],
                                  style:
                                      const TextStyle(color: Colors.white70)),
                              const SizedBox(height: 6),
                              Text(
                                "Deadline: ${task['deadline'].toString().split(' ')[0]}",
                                style: const TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (status != 'pending_ta' && status != 'pending_doctor')
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (planId.isNotEmpty) return;

                    final formattedTasks = tasks
                        .map((t) => {
                              "title": t["title"],
                              "description": t["description"],
                              "deadline":
                                  (t["deadline"] as DateTime).toIso8601String(),
                            })
                        .toList();

                    await CreateTimePlanService.createTimePlan(
                      projectId: widget.projectId,
                      tasks: formattedTasks,
                    );

                    await getTimePlan();

                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Time Plan Submitted Successfully"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Submit To TA",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
