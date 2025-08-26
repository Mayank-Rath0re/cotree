import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/pages/review_applications.dart';
import 'package:flutter/material.dart';

class AbsReviewBox extends StatefulWidget {
  final UserView userview;
  final Offers offer;
  const AbsReviewBox({super.key, required this.offer, required this.userview});

  @override
  State<AbsReviewBox> createState() => _AbsReviewBoxState();
}

class _AbsReviewBoxState extends State<AbsReviewBox> {
  @override
  Widget build(BuildContext context) {
    return AbsMinimalBox(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AbsText(
            displayString: widget.offer.title,
            fontSize: 18,
            headColor: true,
            bold: true,
          ),
          const SizedBox(height: 10),
          Text(widget.offer.description,
              maxLines: 2,
              style:
                  const TextStyle(overflow: TextOverflow.fade, fontSize: 14)),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                  child: AbsButtonPrimary(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewApplications(
                                    offerData: widget.offer,
                                    userview: widget.userview)));
                      },
                      fontSize: 20,
                      text: "Review ⇥")),
            ],
          )
        ],
      ),
    ));
  }
}
