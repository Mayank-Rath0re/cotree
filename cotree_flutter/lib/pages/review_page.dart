import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_review_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewApplicationsState();
}

class _ReviewApplicationsState extends State<ReviewPage> {
  late UserView userview;
  late bool isLoading = true;
  late List<Offers> offerData;
  Future<void> buildPage() async {
    var user = await Constants().getOrSetUserView(context);
    var offerInfo = await client.work.fetchAuthorOffers(user.userId);
    setState(() {
      userview = user;
      offerData = offerInfo;
      isLoading = false;
    });
  }

  @override
  void initState() {
    buildPage();
    super.initState();
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
            padding: const EdgeInsets.all(12.0),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.black,
                  ))
                : SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const AbsText(
                            displayString: "Review Applications",
                            fontSize: 20,
                            headColor: true,
                            bold: true),
                        const SizedBox(height: 12),
                        if (offerData.isEmpty) ...[
                          const SizedBox(
                              height: 200,
                              child: Center(
                                  child: AbsText(
                                      displayString: "No Offers Created!",
                                      fontSize: 24,
                                      bold: true)))
                        ] else ...[
                          for (int i = 0; i < offerData.length; i++) ...[
                            AbsReviewBox(
                              offer: offerData[i],
                              userview: userview,
                            ),
                            const SizedBox(height: 10)
                          ]
                        ]
                      ]))));
  }
}
