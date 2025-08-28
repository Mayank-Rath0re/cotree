import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserConnectionsPage extends StatefulWidget {
  final UserView userview;
  const UserConnectionsPage({super.key, required this.userview});

  @override
  State<UserConnectionsPage> createState() => _UserConnectionsPageState();
}

class _UserConnectionsPageState extends State<UserConnectionsPage> {
  bool isLoading = true;
  late List<UserView> connections = [];

  void getBuildData() async {
    var conn =
        await client.connection.fetchConnectedUsers(widget.userview.userId);
    setState(() {
      connections = conn;
      isLoading = false;
    });
  }

  Widget connectionBuild(UserView view) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(profileId: view.userId)));
      },
      child: AbsMinimalBox(
          child: Row(
        children: [
          AbsAvatar(radius: 20, avatarUrl: view.avatar),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AbsText(
                displayString: view.name,
                fontSize: 14,
                bold: true,
              ),
              const SizedBox(height: 4),
              AbsText(displayString: view.headline, fontSize: 11)
            ],
          )
        ],
      )),
    );
  }

  @override
  void initState() {
    getBuildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AbsText(
            displayString: "Your Connections", fontSize: 16, bold: true),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  const SizedBox(height: 10),
                  const AbsText(
                    displayString: "Fetching your connections",
                    fontSize: 16,
                    bold: true,
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (connections.isEmpty) ...[
                      const SizedBox(height: 200),
                      const Icon(Icons.no_accounts, size: 60),
                      const SizedBox(height: 20),
                      const AbsText(
                          displayString: "No active connections",
                          fontSize: 16,
                          bold: true)
                    ] else ...[
                      for (int i = 0; i < connections.length; i++) ...[
                        connectionBuild(connections[i]),
                        const SizedBox(height: 8),
                      ]
                    ]
                  ],
                ),
              ),
            ),
    );
  }
}
