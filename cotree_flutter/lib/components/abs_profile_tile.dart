import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_org_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/add_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsProfileTile extends StatefulWidget {
  final ProfessionalData data;
  final int categoryIndex;
  final int profileId;
  final bool isMyAccount;
  const AbsProfileTile(
      {super.key,
      required this.data,
      required this.categoryIndex,
      required this.profileId,
      required this.isMyAccount});

  @override
  State<AbsProfileTile> createState() => _AbsProfileTileState();
}

class _AbsProfileTileState extends State<AbsProfileTile> {
  void confirmationDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Center(
                child: AbsText(
                    displayString: "Are you sure?", fontSize: 16, bold: true),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child:
                        const AbsText(displayString: "Cancel", fontSize: 14)),
                AbsButtonPrimary(
                    onPressed: () {
                      client.account.deleteProfessionalData(widget.data.id!);

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: AbsMinimalBox(
                              child: AbsText(
                                  displayString: "Deleted Information!",
                                  fontSize: 16))));
                    },
                    text: "Yes")
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AbsOrgAvatar(
          radius: 30,
          avatarUrl: "",
        ),
        const SizedBox(width: 8),
        Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AbsText(
                    displayString: widget.data.title, fontSize: 15, bold: true),
                AbsText(displayString: widget.data.institute, fontSize: 13),
                AbsText(
                    displayString:
                        "${DateFormat("MM/yyyy").format(widget.data.startDate)}-${widget.data.endData == null ? "Present" : DateFormat("MM/yyyy").format(widget.data.endData!)}",
                    fontSize: 14)
              ],
            )),
        const SizedBox(width: 8),
        if (widget.isMyAccount) ...[
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProfileInfo(
                                        profileId: widget.profileId,
                                        index: widget.categoryIndex,
                                        profData: widget.data,
                                      )));
                        },
                        child:
                            const AbsText(displayString: "Edit", fontSize: 14)),
                    PopupMenuItem(
                        onTap: () {
                          confirmationDialog();
                        },
                        child: const AbsText(
                            displayString: "Delete", fontSize: 14)),
                  ])
        ],
      ],
    );
  }
}
