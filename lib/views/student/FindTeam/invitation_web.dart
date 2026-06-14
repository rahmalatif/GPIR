import 'package:flutter/material.dart';
import '../../../services/get_invitation_services.dart';
import '../../../services/handle_invitation.dart';
import '../../model/invitation.dart';

class TeamInvitationsWebView extends StatefulWidget {
  const TeamInvitationsWebView({super.key});

  @override
  State<TeamInvitationsWebView> createState() => _TeamInvitationsWebViewState();
}

class _TeamInvitationsWebViewState extends State<TeamInvitationsWebView> {
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
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> acceptInvitation(String invitationId) async {
    await HandleInvitationService.handleInvitation(
      invitationId: invitationId,
      action: "accept",
    );
    await getInvitations();
  }

  Future<void> rejectInvitation(String invitationId) async {
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
        iconTheme: const IconThemeData(color: Colors.white),
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
          : Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 650 ? 2 : 1;
              return GridView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: invitations.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  return _invitationCard(invitations[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _invitationCard(InvitationModel invitation) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1E2B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 8,
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
              Text(
                invitation.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                invitation.specialization,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                invitation.phone,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          if (invitation.status == "pending")
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await acceptInvitation(invitation.id);
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Invitation accepted"),
                            ),
                          );
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Accept"),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await rejectInvitation(invitation.id);
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Invitation rejected"),
                            ),
                          );
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Reject"),
                    ),
                  ),
                ),
              ],
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: invitation.status == "accepted"
                    ? Colors.green.withOpacity(.15)
                    : Colors.red.withOpacity(.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                invitation.status.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: invitation.status == "accepted"
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
        ],
      ),
    );
  }
}