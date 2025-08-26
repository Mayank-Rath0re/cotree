import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_searchbar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/add_members_page.dart';
import 'package:face_pile/face_pile.dart';
import 'package:flutter/material.dart';

class FindMembersPage extends StatefulWidget {
  final int spaceId;
  const FindMembersPage({super.key, required this.spaceId});

  @override
  State<FindMembersPage> createState() => _FindMembersPageState();
}

class _FindMembersPageState extends State<FindMembersPage> {
  TextEditingController searchController = TextEditingController();

  Stream<UserView>? searchStream;
  List<UserView> members = [];
  List<UserView> searchResult = [];
  bool isLoading = true;

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      searchResult = [];
      return;
    }
    searchStream =
        client.account.userSearch(sessionManager.signedInUser!.id, query);
    searchResult = [];
    searchStream!.listen((results) {
      setState(() {
        searchResult.add(results);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const AbsText(
                  displayString: "Invite Members",
                  fontSize: 22,
                  headColor: true),
              const SizedBox(height: 20),
              if (members.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      FacePile(
                        radius: 26,
                        space: 40,
                        images: members.map<ImageProvider<Object>>((user) {
                          if (user.avatar.isNotEmpty) {
                            return NetworkImage(user.avatar);
                          } else {
                            return const AssetImage('assets/avatar.jpg');
                          }
                        }).toList(),
                      ),
                      if (members.length > 5) ...[
                        const SizedBox(width: 8),
                        AbsText(
                            displayString: "+ ${members.length - 5} more",
                            fontSize: 18)
                      ]
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
              AbsSearchbar(
                controller: searchController,
                onChanged: _onSearchChanged,
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < searchResult.length; i++) ...[
                GestureDetector(
                    onTap: () {
                      if (!members.contains(searchResult[i])) {
                        setState(() {
                          members.add(searchResult[i]);
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
                            displayString: searchResult[i].name, fontSize: 17),
                      ],
                    )))
              ],
              const SizedBox(height: 25),
              Row(
                children: [
                  AbsButtonSecondary(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      fontSize: 18,
                      text: "Go Back"),
                  const Spacer(),
                  AbsButtonPrimary(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddMembersPage(
                                    spaceId: widget.spaceId,
                                    membersToAdd: members)));
                      },
                      text: "Next")
                ],
              ),
            ],
          ),
        ));
  }
}
