import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_org_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/pages/create_space_page.dart';
import 'package:cotree_flutter/pages/main_space_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpaceLandPage extends StatefulWidget {
  const SpaceLandPage({super.key});

  @override
  State<SpaceLandPage> createState() => _SpaceLandPageState();
}

class _SpaceLandPageState extends State<SpaceLandPage> {
  bool isLoading = true;
  late UserView userview;
  late List<Space> spaces;
  void fetchSpaces() async {
    final userCache = context.read<UserCacheService>();
    // Get or set user
    final user = await userCache.getOrSetUserView(context);
    var fetchedSpaces =
        await client.space.fetchSpacesByUser(sessionManager.signedInUser!.id!);
    setState(() {
      userview = user;
      spaces = fetchedSpaces;
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchSpaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            AbsButtonPrimary(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateSpacePage()));
              },
              fontSize: 16,
              text: "Create New Workspace",
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AbsText(
                  displayString: "Your Spaces", fontSize: 22, headColor: true),
              const SizedBox(height: 20),
              if (isLoading) ...[
                const Center(child: CircularProgressIndicator())
              ] else ...[
                Center(
                    child: ListView(
                  shrinkWrap: true,
                  children: [
                    if (spaces.isEmpty) ...[
                      const Center(
                          child:
                              AbsText(displayString: "No Spaces", fontSize: 25))
                    ],
                    for (int i = 0; i < spaces.length; i++) ...[
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainSpacePage(
                                        spaceId: spaces[i].id!,
                                        userId: userview.userId)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Provider.of<ThemeProvider>(context)
                                    .mainColor,
                                border: Border.all(
                                    width: 0.8,
                                    color: Provider.of<ThemeProvider>(context)
                                        .contrastColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AbsOrgAvatar(
                                        radius: 40,
                                        avatarUrl: spaces[i].avatar),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AbsText(
                                            displayString: spaces[i].title,
                                            fontSize: 18),
                                        const SizedBox(height: 5),
                                        AbsText(
                                            displayString:
                                                spaces[i].description,
                                            fontSize: 14),
                                        const SizedBox(height: 8),
                                      ],
                                    ))
                                  ],
                                )),
                          )),
                      const SizedBox(height: 12)
                    ]
                  ],
                ))
              ]
            ],
          ),
        ));
  }
}
