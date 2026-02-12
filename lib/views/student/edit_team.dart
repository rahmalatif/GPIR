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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    members = List.from(widget.members);
  }

  void addMember() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      members.add(
        TeamMember(
          name: nameController.text.trim(),
          track: '',
        ),
      );
    });

    nameController.clear();
    roleController.clear();

    showSnack("Member added ✅");
  }

  void editMember(int index) {
    final editName = TextEditingController(text: members[index].name);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Color(0xff1D1D2E),
        title: Text("Edit Member", style: TextStyle(color: Colors.white)),
        content: buildField(editName, "Name"),
        actions: [
          TextButton(
            onPressed: () {
              if (editName.text.trim().isEmpty) return;

              setState(() {
                members[index] = TeamMember(
                  name: editName.text.trim(),
                  track: members[index].track,
                );
              });

              Navigator.pop(context);
              showSnack("Member updated ✏️");
            },
            child: Text(
              "Save",
              style: TextStyle(
                color: Color(0xff4699A8),
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  void deleteMember(int index) {
    setState(() {
      members.removeAt(index);
    });

    showSnack("Member deleted 🗑️");
  }

  void showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Color(0xff4699A8),
      ),
    );
  }

  Widget buildField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xff2A2A3D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildValidatedField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Required field";
        }
        if (value.length < 3) {
          return "Min 3 characters";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xff1D1D2E),
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
      backgroundColor: Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0F1A),
        title: Text(
          "Edit Team",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(members);
            },
            child: Text(
              "Save",
              style: TextStyle(color: Color(0xff4699A8), fontSize: 16),
            ),
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
                itemBuilder: (context, index) {
                  final member = members[index];

                  return Card(
                    color: Color(0xff1D1D2E),
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(
                        member.name,
                        style: TextStyle(color: Colors.white),
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Color(0xff4699A8)),
                            onPressed: () => editMember(index),
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
              child: buildValidatedField(
                controller: nameController,
                hint: "New member name",
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addMember,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff4699A8),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text("Add Member"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
