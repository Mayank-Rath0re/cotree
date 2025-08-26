import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_searchbar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/find_members_page.dart';
import 'package:cotree_flutter/pages/manage_space_members.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class SpaceManagePage extends StatefulWidget {
  final int spaceId;
  final Member myMemberData;
  final List<Member> spaceMembers;
  const SpaceManagePage(
      {super.key,
      required this.spaceId,
      required this.myMemberData,
      required this.spaceMembers});

  @override
  State<SpaceManagePage> createState() => _SpaceManagePageState();
}

class _SpaceManagePageState extends State<SpaceManagePage> {
  int scaffoldIndex = 0;
  TextEditingController title = TextEditingController();
  TextEditingController overview = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<Member> searchResult = [];
  Stream<Member>? searchStream;
  int category = 0;
  List<Member> selectedMembers = [];
  List<Teams> teams = [];
  List<int> selectedTeams = [];
  bool isLoadingTeams = true;

  void fetchTeams() async {
    var teamsObj = await client.space.fetchSpaceTeams(widget.spaceId);
    setState(() {
      teams = teamsObj;
      isLoadingTeams = false;
    });
  }

  Scaffold manageScaffold() {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const AbsText(
                displayString: "Manage Space",
                fontSize: 25,
                headColor: true,
              ),
            ),

            const SizedBox(height: 40),

            /// Invite New Members Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FindMembersPage(spaceId: widget.spaceId)),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: themeProvider.contrastColor,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.paperplane,
                      color: themeProvider.headColor,
                    ),
                    const SizedBox(width: 10),
                    const AbsText(
                      displayString: "Invite New Members",
                      fontSize: 17,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            /// Create Team/Project Button
            GestureDetector(
              onTap: () {
                setState(() {
                  scaffoldIndex = 1;
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: themeProvider.contrastColor,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.create,
                      color: themeProvider.headColor,
                    ),
                    const SizedBox(width: 10),
                    const AbsText(
                      displayString: "Create New Team/Project",
                      fontSize: 17,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            /// Manage Members Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ManageSpaceMembers(
                          spaceMembers: widget.spaceMembers,
                          spaceId: widget.spaceId,
                          myMemberData: widget.myMemberData)),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: themeProvider.contrastColor,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    HeroIcon(
                      HeroIcons.users,
                      color: themeProvider.headColor,
                    ),
                    const SizedBox(width: 10),
                    const AbsText(
                      displayString: "Manage Members",
                      fontSize: 17,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      searchResult = [];
      return;
    }
    searchStream = client.space.searchMemberByName(widget.spaceId, query);
    searchResult = [];
    searchStream!.listen((results) {
      setState(() {
        searchResult.add(results);
      });
    });
  }

  Scaffold createScaffold() {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                setState(() {
                  scaffoldIndex = 0;
                });
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              const AbsText(
                displayString: "Create Team/Project",
                fontSize: 28,
                headColor: true,
              ),
              const SizedBox(height: 20),
              const AbsText(
                  displayString: "Title", fontSize: 16, headColor: true),
              const SizedBox(height: 5),
              AbsTextfield(hintText: "title", controller: title),
              const SizedBox(height: 20),
              CupertinoSlidingSegmentedControl<int>(
                // The animation for the sliding selection is built-in here.
                children: const <int, Widget>{
                  0: Padding(
                    padding: EdgeInsets.all(8),
                    child: AbsText(
                        displayString: "Team", fontSize: 16, bold: true),
                  ),
                  1: Padding(
                    padding: EdgeInsets.all(8),
                    child: AbsText(
                        displayString: "Project", fontSize: 16, bold: true),
                  ),
                },
                groupValue: category,
                onValueChanged: (int? value) {
                  if (category == 1 && teams.isEmpty) {
                    fetchTeams();
                  }
                  setState(() {
                    category = value!;
                  });
                },
                // You can customize colors, but the sliding animation is automatic
                backgroundColor: Provider.of<ThemeProvider>(context).mainColor,
                thumbColor: Provider.of<ThemeProvider>(context).headColor,
                padding:
                    const EdgeInsets.all(12), // Adjust padding around the thumb
              ),
              const SizedBox(height: 10),
              if (category == 1) ...[
                if (isLoadingTeams) ...[
                  const CircularProgressIndicator()
                ] else ...[
                  const AbsText(
                      displayString: "Description",
                      fontSize: 16,
                      headColor: true),
                  const SizedBox(height: 5),
                  AbsMultilineTextfield(
                      hintText: "description", controller: overview),
                  const SizedBox(height: 10),
                  const AbsText(
                    displayString: "Select Teams",
                    fontSize: 18,
                    headColor: true,
                  ),
                  const SizedBox(height: 10),
                  // Dropdown for selection
                  MultiSelectDialogField<Teams>(
                    items: teams
                        .map((team) =>
                            MultiSelectItem<Teams>(team, team.teamTitle))
                        .toList(),
                    itemsTextStyle: TextStyle(
                        color:
                            Provider.of<ThemeProvider>(context).contrastColor),
                    title: const Text("Teams"),
                    selectedColor:
                        Provider.of<ThemeProvider>(context).headColor,
                    buttonText: const Text(
                      "Select teams…",
                      style: TextStyle(fontSize: 16),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    searchable: true,
                    listType: MultiSelectListType.LIST,
                    onConfirm: (values) {
                      setState(() {
                        selectedTeams = values.map((team) {
                          return team.id!;
                        }).toList();
                      });
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        setState(() {
                          selectedTeams.remove(value.id);
                        });
                      },
                    ),
                  ),
                ]
              ] else ...[
                const AbsText(
                    displayString: "Select Team Members",
                    fontSize: 18,
                    headColor: true),
                const SizedBox(height: 10),
                AbsSearchbar(
                    controller: searchController, onChanged: _onSearchChanged),
                const SizedBox(height: 7),
                for (int i = 0; i < selectedMembers.length; i++) ...[
                  AbsMinimalBox(
                      child: Row(
                    children: [
                      Icon(
                        Icons.check_box,
                        color: Provider.of<ThemeProvider>(context).headColor,
                      ),
                      const SizedBox(width: 7),
                      AbsAvatar(
                          radius: 24, avatarUrl: selectedMembers[i].avatar),
                      const SizedBox(width: 10),
                      AbsText(
                          displayString: selectedMembers[i].name, fontSize: 17),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              selectedMembers.removeAt(i);
                            });
                          },
                          icon: const Icon(Icons.remove_circle_outline,
                              color: Colors.red))
                    ],
                  )),
                  const SizedBox(height: 5)
                ],
                const SizedBox(height: 7),
                for (int i = 0; i < searchResult.length; i++) ...[
                  if (!selectedMembers.contains(searchResult[i])) ...[
                    GestureDetector(
                        onTap: () {
                          if (!selectedMembers.contains(searchResult[i])) {
                            setState(() {
                              selectedMembers.add(searchResult[i]);
                              searchResult.removeAt(i);
                            });
                          }
                        },
                        child: AbsMinimalBox(
                            child: Row(
                          children: [
                            AbsAvatar(
                                radius: 24, avatarUrl: searchResult[i].avatar),
                            const SizedBox(width: 10),
                            AbsText(
                                displayString: searchResult[i].name,
                                fontSize: 17),
                          ],
                        )))
                  ]
                ]
              ],
              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  AbsButtonPrimary(
                      onPressed: () async {
                        if (category == 0) {
                          await client.space.createTeam(
                              widget.spaceId,
                              title.text,
                              selectedMembers.map((member) {
                                return member.id!;
                              }).toList(),
                              List.filled(
                                  selectedMembers.length, "Contributor"));
                        } else {
                          await client.space.createProject(widget.spaceId,
                              title.text, overview.text, selectedTeams);
                        }
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    content: SizedBox(
                                  child: Center(
                                      child: AbsText(
                                          displayString:
                                              "Created $category ${title.text}",
                                          fontSize: 18)),
                                )));
                        // Replace with Navigating to the teams/project page
                      },
                      text: "CREATE")
                ],
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (scaffoldIndex == 0) {
      return manageScaffold();
    } else if (scaffoldIndex == 1) {
      return createScaffold();
    }
    return const Placeholder();
  }
}
