import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/auth_service.dart';
import '../../../services/find_student_service.dart';
import '../../../services/get_invitation_services.dart';
import '../../../services/stop_looking_for_team.dart';
import '../../../services/team_invitation_services.dart';
import '../../model/find_student.dart';

class FindStudentWebView extends StatefulWidget {
  const FindStudentWebView({super.key});

  @override
  State<FindStudentWebView> createState() => _FindStudentWebViewState();
}

class _FindStudentWebViewState extends State<FindStudentWebView> {
  int invitationsCount = 0;
  List<FindStudentModel> students = [];
  bool isLoading = true;
  bool isLookingForTeam = false;
  Set<String> invitedStudents = {};

  @override
  void initState() {
    super.initState();
    getStudents();
    getInvitationsCount();
  }

  Future<void> getInvitationsCount() async {
    try {
      final invitations = await GetInvitationsService.getInvitations();

      setState(() {
        isLookingForTeam = students.any(
              (student) => student.id == AuthService.userId,
        );

        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getStudents() async {
    try {
      students = await FindStudentService.getStudents();

      isLookingForTeam = students.any(
            (student) => student.id == AuthService.userId,
      );    } catch (e) {
      debugPrint(e.toString());
    }

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
        title: Text(
          'Find Teammates',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () async {
                  await context.push('/teamInvitations');

                  getInvitationsCount();
                },
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
              ),
              if (invitationsCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      invitationsCount > 99
                          ? "99+"
                          : invitationsCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
        ],
        leading: IconButton(
            onPressed: () {
              context.go('/studentDashboard');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Available Students',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!isLookingForTeam)
                            SizedBox(
                              width: 180,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  context.go('/createStudent');
                                },
                                icon: const Icon(Icons.person_add),
                                label: const Text('Join Search'),
                              ),
                            ),
                          if (isLookingForTeam)
                            SizedBox(
                              width: 180,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  try {
                                    await StopLookingForTeamService.stopLooking();

                                    await getStudents();

                                    setState(() {
                                      isLookingForTeam = false;
                                    });

                                    if (!mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Removed from available students",
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(e.toString()),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                icon: const Icon(Icons.close),
                                label: const Text('Stop Search'),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  isLoading
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: students.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 240,
                        ),
                        itemBuilder: (context, index) {
                          final student = students[index];

                          return _buildStudentCard(
                            id: student.id,
                            name: student.name,
                            specialization: student.specialization,
                            phone: student.phone,
                            collegeCode: student.collegeCode.toString(),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  _buildRegisterBanner(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard({
    required String id,
    required String name,
    required String specialization,
    required String phone,
    required String collegeCode,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1520),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFF142232),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          specialization,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.tealAccent,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Available",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.badge_outlined,
                    color: Colors.tealAccent,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "ID: $collegeCode",
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    color: Colors.tealAccent,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    phone,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: invitedStudents.contains(id)
                  ? null
                  : () async {
                try {
                  await TeamInvitationService.sendInvitation(id);

                  setState(() {
                    invitedStudents.add(id);
                  });

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Invitation sent to $name',
                      ),
                    ),
                  );
                } catch (e) {
                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        e.toString(),
                      ),
                    ),
                  );
                }
              },
              icon: Icon(
                invitedStudents.contains(id)
                    ? Icons.check
                    : Icons.group_add,
              ),
              label: Text(
                invitedStudents.contains(id)
                    ? "Invitation Sent"
                    : "Invite To Team",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: invitedStudents.contains(id)
                    ? Colors.grey
                    : Colors.tealAccent,
                foregroundColor: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRegisterBanner() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1520),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          const Icon(Icons.groups_rounded, color: Colors.tealAccent, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Looking for a team?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "List yourself here so teams can find you and recruit you.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              context.go('/createStudent');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E5FF),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              elevation: 0,
            ),
            child: const Text(
              'Add To available',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}