import 'package:flutter/material.dart';

import '../../../services/get_invitation_services.dart';
import '../../../services/handle_invitation.dart';
import '../../model/invitation.dart';

class TeamInvitationsView extends StatefulWidget {
  const TeamInvitationsView({super.key});

  @override
  State<TeamInvitationsView> createState() => _TeamInvitationsViewState();
}

class _TeamInvitationsViewState extends State<TeamInvitationsView> {
  List<InvitationModel> invitations = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getInvitations();
  }

  Future<void> getInvitations() async {
    try {
      invitations = await GetInvitationsService.getInvitations();

      print("Invitations Count = ${invitations.length}");

      for (var invitation in invitations) {
        print(
          "${invitation.name} - ${invitation.status}",
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> acceptInvitation(
    String invitationId,
  ) async {
    await HandleInvitationService.handleInvitation(
      invitationId: invitationId,
      action: "accept",
    );

    await getInvitations();
  }

  Future<void> rejectInvitation(
    String invitationId,
  ) async {
    await HandleInvitationService.handleInvitation(
      invitationId: invitationId,
      action: "reject",
    );

    await getInvitations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0F1A),
          title: const Text(
            "Team Invitations",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : invitations.isEmpty
                ? const Center(
                    child: Text(
                      "No Invitations Yet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: invitations.length,
                    itemBuilder: (context, index) {
                      return _invitationCard(
                        invitations[index],
                      );
                    },
                  )
    );
  }

  Widget _invitationCard(
    InvitationModel invitation,
  ) {
    {
      return Card(
        color: const Color(0xFF1B1E2B),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invitation.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                invitation.specialization,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                invitation.phone,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              if (invitation.status == "pending")
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await acceptInvitation(
                              invitation.id,
                            );
                            print("Invitations Count = ${invitations.length}");
                            print("${invitation.name} - ${invitation.status}");

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Invitation accepted",
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
                          backgroundColor: Colors.green,
                        ),
                        child: const Text("Accept"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await rejectInvitation(
                              invitation.id,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Invitation rejected",
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
                        child: const Text("Reject"),
                      ),
                    ),
                  ],
                )
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: invitation.status == "accepted"
                        ? Colors.green.withOpacity(.15)
                        : Colors.red.withOpacity(.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    invitation.status.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: invitation.status == "accepted"
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }
  }
}
