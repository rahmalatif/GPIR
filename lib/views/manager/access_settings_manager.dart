import 'package:flutter/material.dart';

class AccessSettingsView extends StatefulWidget {
  const AccessSettingsView({super.key});

  @override
  State<AccessSettingsView> createState() => _AccessSettingsViewState();
}

class _AccessSettingsViewState extends State<AccessSettingsView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _doctorsController = TextEditingController();
  final TextEditingController _teamsController = TextEditingController();
  final TextEditingController _studentsController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _doctorsController.text = "5";
    _teamsController.text = "10";
    _studentsController.text = "6";
    _deadlineController.text = "2026-07-01";
  }

  @override
  void dispose() {
    _doctorsController.dispose();
    _teamsController.dispose();
    _studentsController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff6EC6D9),
              onPrimary: Colors.black,
              surface: Color(0xFF1A1D2E),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF0D0F1A),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _deadlineController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Access Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(
                label: "Max Doctors Count",
                controller: _doctorsController,
                icon: Icons.person_rounded,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Max Teams Count",
                controller: _teamsController,
                icon: Icons.group_work_rounded,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Max Students per Team",
                controller: _studentsController,
                icon: Icons.groups_rounded,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Documentation Deadline",
                controller: _deadlineController,
                icon: Icons.calendar_month_rounded,
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff6EC6D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Save Settings",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.cyan,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1A1D2E),
            prefixIcon: Icon(icon, color: Colors.cyan, size: 22),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xff6EC6D9), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "This field is required";
            }
            return null;
          },
        ),
      ],
    );
  }
}