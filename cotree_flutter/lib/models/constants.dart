import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/box_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Constants {
  Future<UserView> getOrSetUserView(BuildContext context) async {
    final appCache = context.read<HiveBoxProvider>();
    final user = context.read<HiveBoxProvider>().getValue<UserView>(
          'userview',
          fromJson: (map) => UserView.fromJson(map),
        );
    print("value from hive: $user");
    if (user == null) {
      var callForUserView =
          await client.account.getUserView(sessionManager.signedInUser!.id!);
      // ignore: unused_local_variable
      var userIns = appCache.setValue('userview', callForUserView);
      return callForUserView;
    }
    return user;
  }

  Future<void> updateUserView(BuildContext context, UserView userview) async {
    final appCache = context.read<HiveBoxProvider>();
    appCache.setValue('userview', userview);
  }

  Future<void> clearUserView(BuildContext context) async {
    final appCache = context.read<HiveBoxProvider>();
    appCache.deleteValue('userview');
    print("cleared user view");
  }
}
