import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_org_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:flutter/material.dart';

class ProfilePageOrg extends StatefulWidget {
  final int? profileId;
  final UserView userview;
  const ProfilePageOrg(
      {super.key, required this.profileId, required this.userview});

  @override
  State<ProfilePageOrg> createState() => _ProfilePageOrgState();
}

class _ProfilePageOrgState extends State<ProfilePageOrg> {
  bool isLoading = true;
  late UserView userData;
  late Organization orgData;

  void getBuildData() async {
    var userInfo = await client.account.getUserView(widget.profileId);
    var profileData =
        await client.account.getOrganizationData(widget.profileId);
    setState(() {
      userData = userInfo;
      orgData = profileData;
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
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AbsOrgAvatar(radius: 45, avatarUrl: widget.userview.avatar),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            AbsText(
                              displayString: userData.name,
                              fontSize: 20,
                              bold: true,
                              headColor: true,
                            ),
                            const SizedBox(height: 10),
                            AbsText(
                                displayString: userData.headline, fontSize: 16),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                AbsMinimalBox(
                                    roundedBorder: true,
                                    child: Row(
                                      children: [
                                        const AbsText(
                                          displayString: "30",
                                          fontSize: 15,
                                          headColor: true,
                                        ),
                                        const AbsText(
                                            displayString: " Followers",
                                            fontSize: 15)
                                      ],
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            AbsButtonPrimary(
                                onPressed: () {}, text: " + Follow")
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const AbsText(
                        displayString: "About Us", fontSize: 18, bold: true),
                    const SizedBox(height: 8),
                    AbsText(displayString: orgData.about, fontSize: 14),
                    const SizedBox(height: 20),
                    const AbsText(
                        displayString: "Events", fontSize: 18, bold: true),
                    const SizedBox(height: 10),
                    const SizedBox(height: 200),
                    const SizedBox(height: 20),
                    const AbsText(
                        displayString: "Recent Posts",
                        fontSize: 18,
                        headColor: true)
                  ],
                ),
              )));
  }
}
