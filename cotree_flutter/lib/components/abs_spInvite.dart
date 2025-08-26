import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_bold_result.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_org_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class AbsSpinvite extends StatefulWidget {
  final SpaceInvite inviteData;
  final Function()? onAccepted;
  const AbsSpinvite(
      {super.key, required this.inviteData, required this.onAccepted});

  @override
  State<AbsSpinvite> createState() => _AbsSpinviteState();
}

class _AbsSpinviteState extends State<AbsSpinvite> {
  late Space spaceData;
  bool isAccepted = false;
  Color col = Colors.green;
  bool isLoading = true;

  void buildData() async {
    var spaceInfo = await client.space.fetchSpace(widget.inviteData.spaceId);
    setState(() {
      if (widget.inviteData.status == "Accepted") {
        isAccepted = true;
        col = Colors.blue;
      }
      spaceData = spaceInfo!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    buildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AbsOrgAvatar(radius: 40, avatarUrl: spaceData.avatar),
                      const SizedBox(height: 7),
                      AbsText(
                        displayString: spaceData.title,
                        fontSize: 20,
                        headColor: true,
                        bold: true,
                        align: true,
                      ),
                      const SizedBox(height: 5),
                      AbsText(
                          displayString: spaceData.description,
                          fontSize: 16,
                          align: true),
                      const SizedBox(height: 12),
                      AbsBoldResult(
                          field: "Designation",
                          value: widget.inviteData.designation,
                          spaceBetween: true),
                      const SizedBox(height: 7),
                      AbsBoldResult(
                          field: "Space Role",
                          value: widget.inviteData.globalRole,
                          spaceBetween: true),
                      const SizedBox(height: 15),
                      if (isAccepted) ...[
                        const AbsMinimalBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle_outline_rounded,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 10),
                              AbsText(
                                  displayString: "Invitation Accepted",
                                  fontSize: 16)
                            ],
                          ),
                        )
                      ] else ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const AbsText(
                                    displayString: "Dismiss", fontSize: 13)),
                            AbsButtonPrimary(
                                onPressed: () async {
                                  // ignore: unused_local_variable
                                  var acceptInvite = await client.space
                                      .addMember(
                                          sessionManager.signedInUser!.id!,
                                          widget.inviteData);
                                  client.space
                                      .acceptInvite(widget.inviteData.id!);
                                  widget.onAccepted!();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: AbsText(
                                              displayString:
                                                  "Accepted Invitation for ${spaceData.title}",
                                              fontSize: 16)));
                                },
                                text: "Accept")
                          ],
                        )
                      ],
                    ],
                  ),
                ),
              );
            },
            child: AbsMinimalBox(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AbsOrgAvatar(radius: 30, avatarUrl: spaceData.avatar),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AbsText(
                            displayString: spaceData.title,
                            fontSize: 18,
                            bold: true),
                        const SizedBox(height: 5),
                        AbsText(
                            displayString: widget.inviteData.designation,
                            fontSize: 15)
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const HeroIcon(HeroIcons.arrowTopRightOnSquare, size: 20),
                      const SizedBox(height: 8),
                      Text(
                        widget.inviteData.status,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: col),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }
}
