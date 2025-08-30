import 'dart:typed_data';
import 'package:cotree_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AccountEndpoint extends Endpoint {
  // Handling Search Streams
  final _searchSubscribers = <Session>{};

  @override
  Future<void> streamOpened(Session session) async {
    _searchSubscribers.add(session);
  }

  @override
  Future<void> streamClosed(Session session) async {
    _searchSubscribers.remove(session);
  }
  // Class performing general account related functions

  // BASIC ACCOUNT CRUD
  // Create Account
  Future<int> createAccount(Session session, int? id, String name, String email,
      String accountType, String password) async {
    // create User object
    User userObj = User(
        userInfoId: id!,
        name: name,
        accountType: accountType,
        password: password,
        email: email,
        spaceLimit: 3);

    // Insert Object
    // ignore: unused_local_variable
    try {
      var userInsert = await User.db.insertRow(session, userObj);
      createUserView(session, id, name, "", "", accountType);
      // Initialize empty connections list
      var connectObj = Connect(accountId: userInsert.id, activeConnections: []);
      // ignore: unused_local_variable
      var connectInsert = await Connect.db.insertRow(session, connectObj);
      return userInsert.id!;
    } catch (e) {
      print("Error inserting user: $e");
      return -1;
    }
  }

  Future<void> createUserView(Session session, int? userId, String name,
      String headline, String avatar, String accountType) async {
    var userViewObj = UserView(
        userId: userId!,
        name: name,
        headline: headline,
        avatar: avatar,
        accountType: accountType);
    // ignore: unused_local_variable
    var updateObj = UserView.db.insertRow(session, userViewObj);
  }

  // Receive
  Future<User> getUserData(Session session, int? id) async {
    print("Received User ID: $id");
    var user =
        await User.db.find(session, where: (t) => t.userInfoId.equals(id));
    return user[0];
  }

  // Delete Account
  // Update Account
  Future<int> updateIndivAccount(
      Session session, UserView userview, String bio, String residence) async {
    try {
      var userData = await User.db.findById(session, userview.userId);
      var indivAccount = await Individual.db.findFirstRow(session,
          where: (t) => t.accountId.equals(userview.userId));
      userData!.name = userview.name;
      indivAccount!.bio = bio;
      indivAccount.residence = residence;
      // update userView
      await UserView.db.updateRow(session, userview);
      // update user
      await User.db.updateRow(session, userData);
      await Individual.db.updateRow(session, indivAccount);
      return 0;
    } catch (err) {
      print(err);
      return 1;
    }
  }

  // Get all users
  Future<List<UserView>> getAllUser(Session session) async {
    var users = await UserView.db
        .find(session, where: (t) => t.accountType.equals("Individual"));
    return users;
  }

  Future<List<UserView>> getOrgs(Session session) async {
    var orgs = await UserView.db
        .find(session, where: (t) => t.accountType.equals("Organization"));
    return orgs;
  }

  // Retrieve UserView
  Future<UserView> getUserView(Session session, int? userId) async {
    var userView = await UserView.db
        .findFirstRow(session, where: (t) => t.userId.equals(userId));
    return userView!;
  }

  Future<List<ProfessionalData>> fetchUserProfessionalData(
      Session session, int profileId) async {
    var profData = await ProfessionalData.db
        .find(session, where: (t) => t.accountId.equals(profileId));
    return profData;
  }

  // PROFILE ACCOUNT
  // SETUP PROFILE
  Future<UserView> setupProfileI(
      Session session,
      String? headline,
      String? bio,
      int? userId,
      String gender,
      String? residence,
      DateTime? dob,
      String contact) async {
    // Get user id
    print("In profile setup I:");
    var userView = await UserView.db
        .findFirstRow(session, where: (t) => t.userId.equals(userId));
    print("Userview: $userView");
    // Update the profile data for that user id
    var individualObj = Individual(
        bio: bio!,
        gender: gender,
        accountId: userId!,
        residence: residence,
        dob: dob,
        contact: contact);
    userView!.headline = headline!;
    // ignore: unused_local_variable
    var indiv = await Individual.db.insertRow(session, individualObj);
    print("Individual: $indiv");
    // ignore: unused_local_variable
    var updatedUserView = await UserView.db.updateRow(session, userView);
    return updatedUserView;
  }

  Future<void> setupProfileB(
      Session session,
      String headline,
      String about,
      int userId,
      DateTime originDate,
      List<CustomDetails> customInformation,
      ByteData? imageData) async {
    String avatarPath;
    if (imageData != null) {
      avatarPath = await uploadImage(session, imageData, "$userId.png");
    } else {
      avatarPath = "";
    }
    // Get user id
    var userView =
        await UserView.db.find(session, where: (t) => t.userId.equals(userId));
    var orgData = Organization(
        accountId: userId,
        founded: originDate,
        about: about,
        events: [],
        jobOpenings: [],
        customFields: customInformation);
    userView[0].headline = headline;
    userView[0].avatar = avatarPath;
    Organization.db.insertRow(session, orgData);
    // ignore: unused_local_variable
    var updatedUserView = UserView.db.updateRow(session, userView[0]);
  }

  // Receive Profile Data
  Future<Individual> getIndividualData(Session session, int? userId) async {
    var user = await User.db
        .findFirstRow(session, where: (t) => t.userInfoId.equals(userId));
    print("user: $user");
    // Find account data
    var individual = await Individual.db.findFirstRow(session,
        where: (t) => t.accountId.equals(user!.userInfoId));
    print("Individual: $individual");
    return individual!;
  }

  Future<Organization> getOrganizationData(Session session, int? userId) async {
    // Find account data
    // ignore: unused_local_variable
    var user = await User.db.findById(session, userId!);
    var organization = await Organization.db
        .find(session, where: (t) => t.accountId.equals(userId));
    return organization[0];
  }

  Future<String> uploadImage(
      Session session, ByteData imageData, String filename) async {
    String path = "/uploads/$filename";
    // ignore: unused_local_variable
    final file = await session.storage
        .storeFile(storageId: "public", path: path, byteData: imageData);
    final verify =
        await session.storage.fileExists(storageId: "public", path: path);
    if (verify) {
      print("Image Uploaded Successfully");
      var uri =
          await session.storage.getPublicUrl(storageId: "public", path: path);
      return uri.toString();
    }
    return "";
  }

  Future<void> addProfessionalInfo(
      Session session,
      int profileId,
      String type,
      String title,
      String institute,
      DateTime? startDate,
      DateTime? endDate,
      String supportingLink,
      List<String> images) async {
    var profInfo = ProfessionalData(
        accountId: profileId,
        type: type,
        title: title,
        institute: institute,
        startDate: startDate!,
        endData: endDate,
        supportingLink: supportingLink,
        images: images);
    // ignore: unused_local_variable
    var profIns = await ProfessionalData.db.insertRow(session, profInfo);
  }

  Future<void> editProfessionalData(
      Session session, ProfessionalData profData) async {
    // ignore: unused_local_variable
    var editProf = await ProfessionalData.db.updateRow(session, profData);
  }

  Future<void> deleteProfessionalData(Session session, int profDataId) async {
    var profData = await ProfessionalData.db.findById(session, profDataId);
    if (profData != null) {
      // ignore: unused_local_variable
      var delProf = await ProfessionalData.db.deleteRow(session, profData);
    }
  }

  Future<String> getUserAvatarUrl(Session session, int userId) async {
    var userview = await UserView.db.findById(session, userId);
    if (userview == null) {
      return "";
    }
    return userview.avatar;
  }

  Future<void> updateAvatar(
      Session session, UserView userview, String url) async {
    userview.avatar = url;
    await UserView.db.updateRow(session, userview);
  }

  Future<void> removeAvatar(Session session, UserView userview) async {
    String path = "/uploads/${userview.userId}.png";
    // ignore: unused_local_variable
    final file =
        await session.storage.deleteFile(storageId: "public", path: path);
    final verify =
        await session.storage.fileExists(storageId: "public", path: path);
    if (!verify) {
      print("Image deleted sucessfully");
      userview.avatar = "";
      await UserView.db.updateRow(session, userview);
    }
  }

  Stream<UserView> userSearch(
      Session session, int? userId, String query) async* {
    var users = await UserView.db
        .find(session, where: (t) => (t.name.ilike("%$query%")));
    for (int i = 0; i < users.length; i++) {
      print("Retrieved Users: ${users[i].name}");
    }
    for (var user in users) {
      yield user;
    }
  }

  Future<int> fetchUserConnectionCount(Session session, int userId) async {
    var connectObj = await Connect.db
        .findFirstRow(session, where: (t) => t.accountId.equals(userId));
    return connectObj!.activeConnections.length;
  }

  Future<int> fetchUserSpaceCount(Session session, int userId) async {
    var ownSpaces =
        await Space.db.count(session, where: (t) => t.ownerId.equals(userId));
    return ownSpaces;
  }
}
