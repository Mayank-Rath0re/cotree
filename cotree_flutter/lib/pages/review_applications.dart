import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewApplications extends StatefulWidget {
  final UserView userview;
  final Offers offerData;
  const ReviewApplications(
      {super.key, required this.offerData, required this.userview});

  @override
  State<ReviewApplications> createState() => _ReviewApplicationsState();
}

class _ReviewApplicationsState extends State<ReviewApplications> {
  bool isLoading = true;
  List<String> options = ["Submitted", "Reviewed", "Accepted", "Rejected"];
  String selectedOption = "Submitted";
  int selectedIndex = 0;
  late List<Applications> applications;
  late List<UserView> applicationUsers;
  List<int> applicationDistribution = List.filled(4, 0);
  TextEditingController reviewOptions = TextEditingController();

  Future<void> buildPage() async {
    var applicationInfo =
        await client.work.fetchApplicationsForReview(widget.offerData.id!);
    List<UserView> userviews = [];
    List<int> distribution = List.filled(4, 0);
    for (int i = 0; i < applicationInfo.length; i++) {
      var view =
          await client.account.getUserView(applicationInfo[i].individualId);
      userviews.add(view);
      switch (applicationInfo[i].status) {
        case "Submitted":
          distribution[0] += 1;
          break;
        case "Reviewed":
          distribution[1] += 1;
          break;
        case "Accepted":
          distribution[2] += 1;
          break;
        case "Rejected":
          distribution[3] += 1;
          break;
      }
    }
    setState(() {
      applications = applicationInfo;
      applicationUsers = userviews;
      applicationDistribution = distribution;
      isLoading = false;
    });
  }

  // Helper to get filtered applications for a stage
  List<Applications> getFilteredApplications(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return applications.where((t) => t.status == "Submitted").toList();
      case 1:
        return applications.where((t) => t.status == "Reviewed").toList();
      case 2:
        return applications.where((t) => t.status == "Accepted").toList();
      case 3:
        return applications.where((t) => t.status == "Rejected").toList();
      default:
        return applications;
    }
  }

  // The separated review page for a given stage
  void openReviewStage(int stageIndex) {
    final stageApps = getFilteredApplications(stageIndex);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _ReviewStagePage(
          applications: List<Applications>.from(stageApps),
          applicationUsers: applicationUsers,
          stageIndex: stageIndex,
          options: options,
          offerData: widget.offerData,
          userview: widget.userview,
          onStatusChange: (app, oldStatus, newStatus) {
            setState(() {
              // Remove from current stage count
              switch (oldStatus) {
                case "Submitted":
                  applicationDistribution[0] -= 1;
                  break;
                case "Reviewed":
                  applicationDistribution[1] -= 1;
                  break;
                case "Accepted":
                  applicationDistribution[2] -= 1;
                  break;
                case "Rejected":
                  applicationDistribution[3] -= 1;
                  break;
              }
              // Add to new stage count
              switch (newStatus) {
                case "Submitted":
                  applicationDistribution[0] += 1;
                  break;
                case "Reviewed":
                  applicationDistribution[1] += 1;
                  break;
                case "Accepted":
                  applicationDistribution[2] += 1;
                  break;
                case "Rejected":
                  applicationDistribution[3] += 1;
                  break;
              }
              // Update the main applications list
              int idx = applications.indexWhere((a) => a.id == app.id);
              if (idx != -1) {
                applications[idx] = Applications(
                  id: app.id,
                  individualId: app.individualId,
                  offerId: app.offerId,
                  status: newStatus,
                  shortDescription: app.shortDescription,
                  qualifyIndices: app.qualifyIndices,
                );
              }
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    buildPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AbsText(
                          displayString: widget.offerData.title,
                          fontSize: 20,
                          bold: true,
                          headColor: true),
                      const SizedBox(height: 15),
                      AbsText(
                          displayString: widget.offerData.description,
                          fontSize: 14),
                      const SizedBox(height: 20),
                      Row(children: [
                        Expanded(
                            child: AbsMinimalBox(
                                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AbsText(
                                displayString: "Total Applications",
                                fontSize: 16,
                                bold: true),
                            const SizedBox(height: 8),
                            AbsText(
                                displayString: "${applications.length}",
                                fontSize: 20,
                                bold: true,
                                headColor: true)
                          ],
                        ))),
                      ]),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: () => openReviewStage(0),
                                  child: AbsMinimalBox(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AbsText(
                                          displayString: "New Applications",
                                          fontSize: 16,
                                          headColor: true,
                                          bold: true),
                                      const SizedBox(height: 8),
                                      AbsText(
                                          displayString:
                                              "${applicationDistribution[0]}",
                                          fontSize: 20,
                                          bold: true,
                                          headColor: true)
                                    ],
                                  )))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: GestureDetector(
                                  onTap: () => openReviewStage(1),
                                  child: AbsMinimalBox(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AbsText(
                                          displayString: "Reviewed",
                                          fontSize: 16,
                                          bold: true),
                                      const SizedBox(height: 8),
                                      AbsText(
                                          displayString:
                                              "${applicationDistribution[1]}",
                                          fontSize: 20,
                                          bold: true,
                                          headColor: true)
                                    ],
                                  ))))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: () => openReviewStage(2),
                                  child: AbsMinimalBox(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AbsText(
                                          displayString: "Shortlisted",
                                          fontSize: 16,
                                          bold: true),
                                      const SizedBox(height: 8),
                                      AbsText(
                                          displayString:
                                              "${applicationDistribution[2]}",
                                          fontSize: 20,
                                          bold: true,
                                          headColor: true)
                                    ],
                                  )))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: GestureDetector(
                                  onTap: () => openReviewStage(3),
                                  child: AbsMinimalBox(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AbsText(
                                          displayString: "Rejected",
                                          fontSize: 16,
                                          bold: true),
                                      const SizedBox(height: 8),
                                      AbsText(
                                          displayString:
                                              "${applicationDistribution[3]}",
                                          fontSize: 20,
                                          bold: true,
                                          headColor: true)
                                    ],
                                  )))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const AbsText(
                          displayString: "Offer Details Overview",
                          fontSize: 15,
                          bold: true),
                      const SizedBox(height: 10),
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
                              AbsText(
                                  displayString: widget.offerData.offerType,
                                  fontSize: 16,
                                  headColor: true)
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
                              AbsText(
                                  displayString: widget.offerData.pay,
                                  fontSize: 16,
                                  headColor: true)
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
                              AbsText(
                                  displayString: widget.offerData.location,
                                  fontSize: 16,
                                  headColor: true)
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
                              AbsText(
                                  displayString:
                                      "${widget.offerData.duration} months",
                                  fontSize: 16,
                                  headColor: true)
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      )),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: AbsButtonSecondary(
                                  onPressed: () {
                                    client.work.haltApplications(
                                        widget.offerData.id!,
                                        widget.offerData.acceptingApplications);
                                  },
                                  text: "Halt Applications")),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 5,
                              child: AbsButtonPrimary(
                                  onPressed: () async {
                                    // Confirmation
                                  },
                                  text: "Close Request"))
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }
}

// Separated review page for a stage
class _ReviewStagePage extends StatefulWidget {
  final List<Applications> applications;
  final List<UserView> applicationUsers;
  final int stageIndex;
  final List<String> options;
  final Offers offerData;
  final UserView userview;
  final void Function(Applications, String, String) onStatusChange;

  const _ReviewStagePage({
    required this.applications,
    required this.applicationUsers,
    required this.stageIndex,
    required this.options,
    required this.offerData,
    required this.userview,
    required this.onStatusChange,
    Key? key,
  }) : super(key: key);

  @override
  State<_ReviewStagePage> createState() => _ReviewStagePageState();
}

class _ReviewStagePageState extends State<_ReviewStagePage> {
  late List<Applications> localApplications;

  @override
  void initState() {
    localApplications = List<Applications>.from(widget.applications);
    super.initState();
  }

  void updateApplicationStatus(
      Applications applicationData, String newStatus) async {
    String oldStatus = applicationData.status;
    await client.work.changeApplicationStatus(applicationData, newStatus);
    setState(() {
      localApplications.removeWhere((a) => a.id == applicationData.id);
    });
    widget.onStatusChange(applicationData, oldStatus, newStatus);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: AbsText(
        displayString: 'Moved to "$newStatus"',
        fontSize: 15,
      )),
    );
  }

  Widget cardBuild(Applications applicationData) {
    var userData = widget.applicationUsers
        .where((t) => t.userId == applicationData.individualId)
        .first;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: AbsMinimalBox(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AbsText(
                      displayString: userData.name,
                      fontSize: 16,
                      headColor: true,
                      bold: true,
                    ),
                    const SizedBox(height: 6),
                    AbsText(displayString: userData.headline, fontSize: 14),
                    const SizedBox(height: 20),
                    AbsMinimalBox(
                        roundedBorder: true,
                        child: AbsText(
                            displayString: "Status: ${applicationData.status}",
                            bold: true,
                            fontSize: 14)),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    AbsAvatar(radius: 35, avatarUrl: userData.avatar),
                    const SizedBox(height: 10),
                    AbsButtonSecondary(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilePage(profileId: userData.userId)));
                        },
                        text: "View Profile")
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          const AbsText(
              displayString: "Why am I the right person for this role?",
              fontSize: 14,
              bold: true),
          const SizedBox(height: 8),
          AbsText(
              displayString: applicationData.shortDescription, fontSize: 12),
          const SizedBox(height: 10),
          const AbsText(
              displayString: "Qualifications met",
              fontSize: 14,
              bold: true,
              headColor: true),
          const SizedBox(height: 10),
          for (int i = 0; i < widget.offerData.qualifications.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (applicationData.qualifyIndices.contains(i)) ...[
                  Icon(Icons.check_box,
                      color: Provider.of<ThemeProvider>(context).headColor),
                ] else ...[
                  const Icon(Icons.check_box_outline_blank)
                ],
                const SizedBox(width: 8),
                Expanded(
                  child: AbsText(
                      displayString: widget.offerData.qualifications[i],
                      fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              if (applicationData.status == "Rejected")
                ...[]
              else ...[
                AbsButtonSecondary(
                    onPressed: () async {
                      updateApplicationStatus(applicationData, "Rejected");
                    },
                    text: "Reject"),
              ],
              const Spacer(),
              if (applicationData.status != "Accepted") ...[
                AbsButtonPrimary(
                    onPressed: () async {
                      updateApplicationStatus(applicationData, "Accepted");
                    },
                    text: "Shortlist")
              ] else ...[
                AbsButtonSecondary(
                    onPressed: () async {
                      updateApplicationStatus(applicationData, "Reviewed");
                    },
                    text: "Remove from Shortlist")
              ]
            ],
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.options[widget.stageIndex]),
      ),
      body: localApplications.isEmpty
          ? const Center(
              child: AbsText(
                  displayString: "No applications in this stage.",
                  fontSize: 16))
          : ListView.builder(
              itemCount: localApplications.length,
              itemBuilder: (context, index) {
                return cardBuild(localApplications[index]);
              },
            ),
    );
  }
}
