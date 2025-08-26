import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_org_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:flutter/material.dart';

class AbsWorkTile extends StatefulWidget {
  final Function()? onTap;
  final Offers offerData;
  const AbsWorkTile({super.key, required this.offerData, required this.onTap});

  @override
  State<AbsWorkTile> createState() => _AbsWorkTileState();
}

class _AbsWorkTileState extends State<AbsWorkTile> {
  bool isLoading = true;
  late String authorAvatar;

  void getBuildData() async {
    var url = await client.account.getUserAvatarUrl(widget.offerData.author);
    setState(() {
      authorAvatar = url;
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
    return GestureDetector(
        onTap: widget.onTap,
        child: AbsMinimalBox(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    AbsOrgAvatar(
                      radius: 30,
                      avatarUrl: authorAvatar,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AbsText(
                            displayString: widget.offerData.title,
                            fontSize: 15),
                        AbsText(
                            displayString: widget.offerData.authorName,
                            fontSize: 13),
                        Chip(
                            label: AbsText(
                                displayString: widget.offerData.offerType,
                                fontSize: 10)),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_outward)
                  ],
                ),
        ));
  }
}
