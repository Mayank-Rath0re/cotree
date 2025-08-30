import 'package:flutter/material.dart';
import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/models/box_provider.dart';
import 'package:cotree_flutter/main.dart'; // for client, sessionManager

class UserCacheService {
  final HiveBoxProvider cache;

  UserCacheService(this.cache);

  Future<UserView> getOrSetUserView(BuildContext context) async {
    final user = cache.getValue<UserView>(
      'userview',
      fromJson: (map) => UserView.fromJson(map),
    );

    if (user == null) {
      final freshUser =
          await client.account.getUserView(sessionManager.signedInUser!.id!);

      await cache.setValue('userview', freshUser);
      return freshUser;
    }
    return user;
  }

  Future<void> updateUserView(UserView userview) async {
    await cache.setValue('userview', userview);
  }

  Future<void> clearUserView() async {
    await cache.deleteValue('userview');
  }

  Future<void> changeThemeMode(String mode) async {
    await cache.setValue('theme', mode);
  }
}
