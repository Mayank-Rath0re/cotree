import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_spInvite.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:flutter/material.dart';

class WorkNotifyPage extends StatefulWidget {
  const WorkNotifyPage({
    super.key,
  });

  @override
  State<WorkNotifyPage> createState() => _WorkNotifyPageState();
}

class _WorkNotifyPageState extends State<WorkNotifyPage> {
  late List<SpaceInvite> spaceInvitations;
  bool isLoading = true;

  void getBuildData() async {
    var spInvInfo =
        await client.space.fetchSpaceInvites(sessionManager.signedInUser!.id!);
    // Mark Unread backend call
    client.space
        .markInviteRead(spInvInfo.where((t) => t.unread == true).toList());
    setState(() {
      spaceInvitations = spInvInfo;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getBuildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            const AbsText(
              displayString: "Work Updates",
              fontSize: 20,
              bold: true,
            ),
            const SizedBox(height: 20),
            if (isLoading) ...[
              const Center(child: CircularProgressIndicator())
            ] else ...[
              for (int i = 0; i < spaceInvitations.length; i++) ...[
                AbsSpinvite(
                  inviteData: spaceInvitations[i],
                  onAccepted: () {
                    setState(() {
                      spaceInvitations[i].status = "Accepted";
                    });
                  },
                ),
                const SizedBox(height: 8),
              ]
            ]
          ],
        ),
      ),
    );
  }
}
