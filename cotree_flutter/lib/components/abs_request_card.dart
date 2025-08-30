import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsRequestCard extends StatefulWidget {
  final int userId;
  final Invitation? invitation;
  final bool isReceived;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onWithdraw;
  const AbsRequestCard(
      {super.key,
      required this.userId,
      required this.isReceived,
      required this.invitation,
      required this.onAccept,
      required this.onReject,
      required this.onWithdraw});

  @override
  State<AbsRequestCard> createState() => _AbsRequestCardState();
}

class _AbsRequestCardState extends State<AbsRequestCard> {
  late UserView userView;
  bool isLoading = true;
  Future<void> getUserData() async {
    try {
      var data = await client.account.getUserView(widget.isReceived
          ? widget.invitation!.sender
          : widget.invitation!.receiver);
      if (!mounted) return; // safety against setState after dispose
      setState(() {
        userView = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return; // safety against setState after dispose
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not load user: $e')));
    }
  }

  Future<void> _withdrawAt() async {
    try {
      await client.connection.withdrawConnection(
          widget.invitation!.sender, widget.invitation!.receiver);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: AbsText(displayString: 'Withdrawn request', fontSize: 16)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not withdraw: $e')));
    }
  }

  Future<void> _acceptAt() async {
    try {
      await client.connection.confirmConnection(widget.invitation!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: AbsText(
                displayString: 'Accepted connection request', fontSize: 16)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not accept: $e')));
    }
  }

  Future<void> _rejectAt() async {
    try {
      await client.connection.rejectConnection(widget.invitation!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: AbsText(
                displayString: 'Rejected connection request', fontSize: 16)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not reject: $e')));
    }
  }

  Widget trailing() {
    if (widget.isReceived) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              await _acceptAt();
              if (!mounted) return;
              widget.onAccept(); // 🔥 update parent state
            },
            icon: Icon(Icons.check,
                color: Provider.of<ThemeProvider>(context).headColor, size: 18),
            label: const AbsText(displayString: 'Accept', fontSize: 14),
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 36),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () async {
              await _rejectAt();
              if (!mounted) return;
              widget.onReject(); // 🔥 update parent state
            },
            icon: Icon(Icons.close,
                color: Provider.of<ThemeProvider>(context).headColor, size: 18),
            label: const AbsText(displayString: 'Ignore', fontSize: 14),
            style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 36),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          )
        ],
      );
    } else {
      return OutlinedButton.icon(
        onPressed: () async {
          await _withdrawAt();
          if (!mounted) return;
          widget.onWithdraw(); // 🔥 update parent state
        },
        icon: Icon(Icons.undo,
            color: Provider.of<ThemeProvider>(context).headColor, size: 18),
        label: const AbsText(displayString: 'Withdraw', fontSize: 14),
        style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 36),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return AbsMinimalBox(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfilePage(profileId: userView.userId)));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AbsAvatar(radius: 30, avatarUrl: userView.avatar),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AbsText(
                            displayString: userView.name,
                            fontSize: 16,
                            bold: true,
                          ),
                          const SizedBox(height: 4),
                          if (userView.headline.isNotEmpty) ...[
                            AbsText(
                              displayString: userView.headline,
                              fontSize: 14,
                            ),
                          ],
                          const SizedBox(height: 4),
                          trailing(),
                        ],
                      ),
                    ),
                  ],
                )));
  }
}
