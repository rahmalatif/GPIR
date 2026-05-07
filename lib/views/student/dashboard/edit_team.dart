import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/model/team.dart';

class EditTeamView extends StatefulWidget {
  final List<TeamMember> members;

  const EditTeamView({super.key, required this.members});

  @override
  State<EditTeamView> createState() => _EditTeamViewState();
}

class _EditTeamViewState extends State<EditTeamView> {
  final _formKey = GlobalKey<FormState>();
  late List<TeamMember> members;

  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    members = List.from(widget.members);
  }

  void addMember() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      members.add(
        TeamMember(name: nameController.text.trim(), track: ''),
      );
    });

    nameController.clear();
    showSnack("Member added ✅");
  }

  void editMember(int index) {
    final editController =
    TextEditingController(text: members[index].name);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xff1D1D2E),
        title: const Text(
          "Edit Member",
          style: TextStyle(color: Colors.white),
        ),
        content: TextFormField(
          controller: editController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Name",
            filled: true,
            fillColor: const Color(0xff2A2A3D),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text("Cancel",
                style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              final newName = editController.text.trim();
              if (newName.isEmpty) return;

              setState(() {
                members[index] = TeamMember(name: newName, track:  '');
              });

              Navigator.pop(dialogContext);
              showSnack("Member updated ✏️");
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Color(0xff4699A8)),
            ),
          ),
        ],
      ),
    );
  }

  void deleteMember(int index) {
    setState(() => members.removeAt(index));
    showSnack("Member deleted 🗑️");
  }

  void showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xff4699A8),
      ),
    );
  }

  Widget buildValidatedField() {
    return TextFormField(
      controller: nameController,
      style: const TextStyle(color: Colors.white),
      validator: (v) =>
      v == null || v.trim().isEmpty ? "Required field" : null,
      decoration: InputDecoration(
        hintText: "New member name",
        filled: true,
        fillColor: const Color(0xff1D1D2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text("Edit Team",
            style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => context.pop(members),
            child: const Text("Save",
                style: TextStyle(color: Color(0xff4699A8))),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (_, i) {
                  return Card(
                    color: const Color(0xff1D1D2E),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(
                        members[i].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Color(0xff4699A8)),
                            onPressed: () => editMember(i),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () => deleteMember(i),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Form(
              key: _formKey,
              child: buildValidatedField(),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addMember,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4699A8),
                  padding:
                  const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text("Add Member"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
