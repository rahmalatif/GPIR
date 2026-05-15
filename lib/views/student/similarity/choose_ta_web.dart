import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/ta_service.dart';
import '../../model/project_idea.dart';

class ChooseTAWebView extends StatefulWidget {
  final ProjectIdea projectIdea;
  final dynamic doctor;
  final double? similarityScore;
  const ChooseTAWebView({
    super.key,
    required this.projectIdea,
    required this.doctor, required this.similarityScore,
  });

  @override
  State<ChooseTAWebView> createState() => _ChooseTAWebViewState();
}

class _ChooseTAWebViewState extends State<ChooseTAWebView> {
  int? selectedIndex;
  List<dynamic> tas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTAs();
  }

  Future<void> loadTAs() async {
    tas = await TAService.getTAs();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: const Text("Choose Teacher Assistant", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "Select the Teacher Assistant for your Idea",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    mainAxisExtent: 100,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: tas.length,
                  itemBuilder: (context, index) {
                    final ta = tas[index];
                    return TAWebContainer(
                      ta: ta,
                      isSelected: selectedIndex == index,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  width: 400,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedIndex == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select a Teacher Assistant"), backgroundColor: Colors.red),
                        );
                        return;
                      }
                      context.go(
                        '/confirmSubmission',
                        extra: {
                          'projectIdea': widget.projectIdea,
                          'doctor': widget.doctor,
                          'ta': tas[selectedIndex!],
                          'similarityScore': widget.similarityScore,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4699A8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "Proceed to Confirmation",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
}

class TAWebContainer extends StatefulWidget {
  final dynamic ta;
  final bool isSelected;
  final VoidCallback onTap;

  const TAWebContainer({
    super.key,
    required this.ta,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<TAWebContainer> createState() => _TAWebContainerState();
}

class _TAWebContainerState extends State<TAWebContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? const Color(0xff4699A8).withOpacity(.2)
                : (isHovered ? Colors.white.withOpacity(0.05) : Colors.transparent),
            border: Border.all(
              color: widget.isSelected ? const Color(0xff4699A8) : Colors.white24,
              width: widget.isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF1A1D2D),
                child: Icon(Icons.person, color: Colors.white70),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.ta['name'],
                      style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.ta['specialization'] ?? 'Faculty Member',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (widget.isSelected)
                const Icon(Icons.check_circle, color: Color(0xff4699A8)),
            ],
          ),
        ),
      ),
    );
  }
}