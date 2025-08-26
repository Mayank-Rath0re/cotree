import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_org_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkDescPage extends StatefulWidget {
  final Offers offerData;
  final UserView userData;
  const WorkDescPage(
      {super.key, required this.offerData, required this.userData});

  @override
  State<WorkDescPage> createState() => _WorkDescPageState();
}

class _WorkDescPageState extends State<WorkDescPage> {
  bool ifApplied = false;
  bool isLoading = true;
  late String authorAvatar;
  void getBuildData() async {
    var applied = await client.work
        .hasApplied(widget.userData.userId, widget.offerData.id!);
    var url = await client.account.getUserAvatarUrl(widget.offerData.author);
    setState(() {
      ifApplied = applied;
      authorAvatar = url;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getBuildData();
    super.initState();
  }

  void showCustomDialog(BuildContext context) async {
    final TextEditingController descriptionController = TextEditingController();
    Set<int> selectedOptions = {};

    var result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(10),
              content: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AbsText(
                                displayString: "Describe",
                                fontSize: 16,
                                bold: true,
                                headColor: true),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                        const SizedBox(height: 8),
                        AbsMultilineTextfield(
                            minLines: 5,
                            maxLines: 10,
                            hintText: "why are you the right person?",
                            controller: descriptionController),
                        const SizedBox(height: 20),
                        const AbsText(
                            displayString:
                                "How many qualifications do you meet?",
                            fontSize: 14,
                            bold: true),
                        Column(
                          children: [
                            for (int i = 0;
                                i < widget.offerData.qualifications.length;
                                i++) ...[
                              CheckboxListTile(
                                activeColor: Provider.of<ThemeProvider>(context)
                                    .headColor,
                                title: AbsText(
                                    displayString:
                                        widget.offerData.qualifications[i],
                                    fontSize: 14),
                                value: selectedOptions.contains(i),
                                onChanged: (value) {
                                  if (selectedOptions.contains(i)) {
                                    setState(() {
                                      selectedOptions.remove(i);
                                    });
                                  } else {
                                    setState(() {
                                      selectedOptions.add(i);
                                    });
                                  }
                                },
                              )
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                AbsButtonPrimary(
                  text: "Submit",
                  onPressed: () async {
                    await client.work.submitApplication(
                        widget.offerData,
                        sessionManager.signedInUser!.id,
                        descriptionController.text,
                        selectedOptions.toList());
                    Navigator.pop(context, true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                            Provider.of<ThemeProvider>(context, listen: false)
                                .mainColor,
                        content: const AbsText(
                            displayString: "Applicated Submitted Successfully",
                            fontSize: 15),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
    if (result) {
      setState(() {
        ifApplied = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            const SizedBox(width: 16),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AbsText(
                        displayString: "Overview",
                        fontSize: 20,
                        headColor: true,
                        bold: true,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: AbsMinimalBox(
                                  child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AbsText(
                                      displayString: widget.offerData.title,
                                      fontSize: 20,
                                      headColor: true,
                                      bold: true,
                                    ),
                                    const SizedBox(height: 10),
                                    AbsText(
                                      displayString:
                                          widget.offerData.authorName,
                                      fontSize: 16,
                                      bold: true,
                                    ),
                                    const SizedBox(height: 10),
                                    AbsText(
                                        displayString:
                                            widget.offerData.description,
                                        fontSize: 14),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        /*
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(profileId: , userview: userview)));
                                    */
                                      },
                                      child: AbsOrgAvatar(
                                          radius: 40, avatarUrl: authorAvatar)),
                                  const SizedBox(height: 15),
                                  if (widget.offerData.acceptingApplications &&
                                      widget.offerData.author !=
                                          widget.userData.userId) ...[
                                    if (!ifApplied) ...[
                                      AbsButtonPrimary(
                                          onPressed: () {
                                            showCustomDialog(context);
                                          },
                                          text: "Apply",
                                          fontSize: 14)
                                    ] else ...[
                                      AbsButtonSecondary(
                                          onPressed: () {}, text: "Applied")
                                    ]
                                  ],
                                ],
                              )
                            ],
                          )))
                        ],
                      ),
                      const SizedBox(height: 20),
                      const AbsText(
                        displayString: "Details",
                        fontSize: 20,
                        headColor: true,
                        bold: true,
                      ),
                      const SizedBox(height: 20),
                      AbsMinimalBox(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AbsText(
                                  displayString: "Offer Type",
                                  fontSize: 16,
                                  bold: true),
                              Chip(
                                  label: AbsText(
                                      displayString: widget.offerData.offerType,
                                      fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AbsText(
                                  displayString: "Pay",
                                  fontSize: 16,
                                  bold: true),
                              Chip(
                                  label: AbsText(
                                displayString: widget.offerData.pay,
                                fontSize: 12,
                              ))
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AbsText(
                                  displayString: "Location",
                                  fontSize: 16,
                                  bold: true),
                              Chip(
                                  label: AbsText(
                                      displayString: widget.offerData.location,
                                      fontSize: 12))
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AbsText(
                                  displayString: "Duration",
                                  fontSize: 16,
                                  bold: true),
                              Chip(
                                  label: AbsText(
                                      displayString:
                                          "${widget.offerData.duration} months",
                                      fontSize: 12))
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      )),
                      const SizedBox(height: 20),
                      const AbsText(
                        displayString: "Qualifications",
                        fontSize: 20,
                        headColor: true,
                        bold: true,
                      ),
                      const SizedBox(height: 20),
                      for (int i = 0;
                          i < widget.offerData.qualifications.length;
                          i++) ...[
                        Row(
                          children: [
                            Expanded(
                              child: AbsMinimalBox(
                                  child: AbsText(
                                      displayString:
                                          widget.offerData.qualifications[i],
                                      fontSize: 14)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ]
                    ],
                  ),
                ),
              ));
  }
}
