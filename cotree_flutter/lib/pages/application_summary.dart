// File: application_summary.dart

import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_application_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationSummary extends StatefulWidget {
  const ApplicationSummary({super.key});

  @override
  State<ApplicationSummary> createState() => _ApplicationSummaryState();
}

class _ApplicationSummaryState extends State<ApplicationSummary> {
  late Future<void> _loadFuture;
  late UserView userview;
  List<Applications> _applications = [];
  List<Offers> _offers = [];

  Future<void> _fetchData() async {
    final userCache = context.read<UserCacheService>();
    // Get or set user
    final user = await userCache.getOrSetUserView(context);
    // keep the same behavior as before (first fetch applications, then offers)
    var applicationInfo = await client.work.fetchUserApplications(user.userId);

    // gather offer ids (avoid duplicates)
    List<int> offerIds = applicationInfo.map((a) => a.offerId).toList();

    var offerInfo = <Offers>[];
    if (offerIds.isNotEmpty) {
      offerInfo = await client.work.getOffersData(offerIds);
    }

    // save in state
    _applications = applicationInfo;
    userview = user;
    _offers = offerInfo;
  }

  Future<void> _refresh() async {
    await _fetchData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadFuture = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const AbsText(
          displayString: "My Applications",
          fontSize: 20,
          bold: true,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // nicer loading state
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  AbsText(
                      displayString: 'Loading your applications...',
                      fontSize: 16)
                ],
              ),
            );
          }

          // error
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AbsText(
                      displayString: 'Failed to load applications',
                      fontSize: 18,
                      bold: true),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _loadFuture = _fetchData();
                      });
                    },
                    child: const AbsText(displayString: 'Retry', fontSize: 16),
                  )
                ],
              ),
            );
          }

          // empty
          if (_applications.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  const Center(
                    child: Column(
                      children: [
                        Icon(Icons.inbox, size: 68),
                        SizedBox(height: 12),
                        AbsText(
                            displayString: 'No applications yet',
                            fontSize: 20,
                            bold: true),
                        SizedBox(height: 6),
                        AbsText(
                            displayString:
                                'When you apply to offers they will show up here.',
                            fontSize: 15)
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          // normal list
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              itemCount: _applications.length,
              itemBuilder: (context, index) {
                final app = _applications[index];
                // attempt to find matching offer; fallback if not available
                Offers? offer;
                if (index < _offers.length) offer = _offers[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AbsApplicationCard(
                    application: app,
                    offer: offer,
                    profileId: userview.userId,
                    onWithdraw: () {
                      // remove locally
                      setState(() {
                        _applications.removeAt(index);
                        if (index < _offers.length) _offers.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
