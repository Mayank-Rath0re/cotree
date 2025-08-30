import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_searchbar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_work_tile.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/pages/application_summary.dart';
import 'package:cotree_flutter/pages/review_page.dart';
import 'package:cotree_flutter/pages/work_desc_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  final TextEditingController searchController = TextEditingController();
  late UserView userview;
  late List<Offers> workOfferData;
  late List<Offers> collabOfferData;
  late List<Offers> searchOffers = [];
  bool searchMode = false;
  bool isSearching = true;
  bool isLoading = true;

  Future<void> getOfferData() async {
    final userCache = context.read<UserCacheService>();
    // Get or set user
    final user = await userCache.getOrSetUserView(context);
    var offersInfo = await client.recommendation.recommendOffers(user.userId);
    //var offersInfo = await client.work.fetchOffers();
    setState(() {
      userview = user;
      workOfferData =
          offersInfo.where((t) => t.offerType != "Collab Request").toList();
      collabOfferData =
          offersInfo.where((t) => t.offerType == "Collab Request").toList();
      isLoading = false;
    });
  }

  void search() async {
    var results = await client.work.fetchSearchOffers(searchController.text);
    setState(() {
      searchOffers = results;
      isSearching = false;
    });
  }

  @override
  void initState() {
    getOfferData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (isLoading) ...[
          const Center(child: CircularProgressIndicator())
        ] else ...[
          Row(
            children: [
              Expanded(
                  child: AbsSearchbar(
                controller: searchController,
                onChanged: (val) {
                  if (searchController.text.isEmpty && searchMode) {
                    setState(() {
                      searchMode = false;
                      searchOffers = [];
                    });
                  }
                },
                onSubmitted: (val) {
                  if (!searchMode && searchController.text.isNotEmpty) {
                    print("Activated search mode");
                    setState(() {
                      searchMode = true;
                    });
                  }
                  setState(() {
                    isSearching = true;
                  });
                  print("searching for query");
                  search();
                },
              )),
            ],
          ),
          const SizedBox(height: 15),
          if (!searchMode) ...[
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ApplicationSummary()));
                },
                child: const AbsMinimalBox(
                    child: AbsText(
                  displayString: "My Applications",
                  fontSize: 18,
                  bold: true,
                ))),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReviewPage()));
                },
                child: const AbsMinimalBox(
                    child: AbsText(
                  displayString: "Review Applications",
                  fontSize: 18,
                  bold: true,
                ))),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 5),
            const AbsText(displayString: "Jobs", fontSize: 18, bold: true),
            const SizedBox(height: 10),
            if (workOfferData.isEmpty) ...[
              const AbsMinimalBox(
                  child: SizedBox(
                height: 130,
                child: Center(
                  child: AbsText(
                      displayString: "No Work Offers Available Right Now",
                      fontSize: 18,
                      bold: true),
                ),
              ))
            ] else ...[
              for (int i = 0; i < workOfferData.length; i++) ...[
                AbsWorkTile(
                    offerData: workOfferData[i],
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkDescPage(
                                  offerData: workOfferData[i],
                                  userData: userview,
                                )))),
                const SizedBox(height: 8)
              ]
            ],
            const SizedBox(height: 12),
            const AbsText(
              displayString: "Collab Requests",
              fontSize: 16,
              bold: true,
            ),
            const SizedBox(height: 8),
            if (collabOfferData.isEmpty) ...[
              const AbsMinimalBox(
                  child: SizedBox(
                height: 130,
                child: Center(
                  child: AbsText(
                      displayString: "No Collab Offers Available Right Now",
                      fontSize: 18,
                      bold: true),
                ),
              ))
            ] else ...[
              for (int i = 0; i < collabOfferData.length; i++) ...[
                AbsWorkTile(
                    offerData: collabOfferData[i],
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkDescPage(
                                  offerData: collabOfferData[i],
                                  userData: userview,
                                )))),
                const SizedBox(height: 8)
              ]
            ]
          ] else ...[
            if (isSearching) ...[
              const Center(child: CircularProgressIndicator())
            ] else ...[
              if (searchOffers.isEmpty) ...[
                const Center(
                  child: AbsMinimalBox(
                      child: AbsText(
                    displayString: "Nothing to see here.",
                    fontSize: 18,
                    bold: true,
                  )),
                )
              ] else ...[
                for (int i = 0; i < searchOffers.length; i++) ...[
                  AbsWorkTile(
                      offerData: searchOffers[i],
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkDescPage(
                                    offerData: searchOffers[i],
                                    userData: userview,
                                  )))),
                  const SizedBox(height: 5),
                ]
              ]
            ]
          ],
        ],
      ],
    );
  }
}
