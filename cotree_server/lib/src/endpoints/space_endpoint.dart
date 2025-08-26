import 'package:cotree_server/src/generated/protocol.dart';
import 'package:cotree_server/src/generated/user.dart';
import 'package:serverpod/serverpod.dart';

class SpaceEndpoint extends Endpoint {
  Future<int> createSpace(Session session, int creatorId, String title,
      String description, String url, String? credentials) async {
    // Create a workspace object
    var userData = await User.db.findById(session, creatorId);
    var spaces =
        await Space.db.find(session, where: (t) => t.ownerId.equals(creatorId));
    if (spaces.length == userData!.spaceLimit) {
      // Space limit reached
      return 1;
    }

    // Create Space
    var spaceObj = Space(
        ownerId: creatorId,
        title: title,
        description: description,
        avatar: url,
        credentials: credentials,
        memberLimit: 10);

    // Insert the workspace object
    var spaceInsert = await Space.db.insertRow(session, spaceObj);
    // ignore: unused_local_variable
    int teamId =
        await createTeam(session, spaceInsert.id!, "Executive", [], []);

    // Code executed successfully
    return spaceInsert.id!;
  }

  Future<int> deleteSpace(Session session, int creatorId, int spaceId) async {
    var spaceObj = await Space.db.findById(session, spaceId);
    if (spaceObj!.ownerId == creatorId) {
      // ignore: unused_local_variable
      var delSpace = await Space.db.delete(session, [spaceObj]);
      return 0;
    }
    // abort the request
    return 1;
  }

  Future<int> createTeam(Session session, int spaceId, String title,
      List<int> members, List<String> role) async {
    try {
      var chatIns =
          await Chat.db.insertRow(session, Chat(isGroup: true, name: title));
      var teamObj =
          Teams(spaceId: spaceId, teamTitle: title, chatId: chatIns.id!);

      var teamInsert = await Teams.db.insertRow(session, teamObj);
      List<TeamMember> insertMembers = [];
      List<ChatParticipant> chatMembers = [];
      for (int i = 0; i < members.length; i++) {
        var teamMember = TeamMember(
            teamId: teamInsert.id!, memberId: members[i], role: role[i]);
        insertMembers.add(teamMember);
        chatMembers
            .add(ChatParticipant(chatId: chatIns.id!, participant: members[i]));
      }
      await TeamMember.db.insert(session, insertMembers);
      await ChatParticipant.db.insert(session, chatMembers);

      return teamInsert.id!;
    } catch (err) {
      return -1;
    }
  }

  Future<int> createProject(Session session, int spaceId, String title,
      String overview, List<int> teamAssigned) async {
    try {
      var projectObj = Project(
          spaceId: spaceId,
          projectTitle: title,
          status: "Ongoing",
          projectOverview: overview);
      var projectInsert = await Project.db.insertRow(session, projectObj);
      List<ProjectAssigned> insertProjects = [];
      for (int i = 0; i < teamAssigned.length; i++) {
        var projectAssigned = ProjectAssigned(
            projectId: projectInsert.id!, teamId: teamAssigned[i]);
        insertProjects.add(projectAssigned);
      }
      await ProjectAssigned.db.insert(session, insertProjects);

      return projectInsert.id!;
    } catch (err) {
      return -1;
    }
  }

  Future<int> addOwner(
      Session session, int userId, int spaceId, UserView userview) async {
    try {
      var executiveTeamId = await Teams.db.find(session,
          where: (t) =>
              t.spaceId.equals(spaceId) & t.teamTitle.equals("Executive"));
      var memberObj = Member(
          userId: userId,
          workspaceId: spaceId,
          name: userview.name,
          designation: "Owner",
          avatar: userview.avatar,
          globalRole: "Owner",
          joinedAt: DateTime.now());
      var memberInsert = await Member.db.insertRow(session, memberObj);
      var teamMember = TeamMember(
          teamId: executiveTeamId[0].id!,
          memberId: memberInsert.id!,
          role: "Lead");
      await TeamMember.db.insertRow(session, teamMember);
      return memberInsert.id!;
    } catch (err) {
      return -1;
    }
  }

  // Create Space Invite
  Future<int> createSpaceInvite(
      Session session,
      int userId,
      int spaceId,
      String designation,
      List<List<String>> teamAndRoles,
      String globalRole,
      int sentBy) async {
    try {
      var inviteObj = SpaceInvite(
          spaceId: spaceId,
          userId: userId,
          designation: designation,
          globalRole: globalRole,
          teams: teamAndRoles,
          sentOn: DateTime.now(),
          sentBy: sentBy,
          status: "Active",
          unread: true);
      var inviteInsert = await SpaceInvite.db.insertRow(session, inviteObj);
      return inviteInsert.id!;
    } catch (err) {
      return -1;
    }
  }

  Future<void> markInviteRead(
      Session session, List<SpaceInvite> invites) async {
    for (var obj in invites) {
      if (obj.unread) {
        obj.unread = false;
      }
    }
    await SpaceInvite.db.update(session, invites);
  }

  Future<bool> unreadInvites(Session session, int userId) async {
    var check = await SpaceInvite.db.count(session,
        where: (t) => t.userId.equals(userId) & t.unread.equals(true));
    if (check == 0) {
      return false;
    }
    return true;
  }

  Future<void> acceptInvite(Session session, int spaceInviteId) async {
    var spaceInv = await SpaceInvite.db.findById(session, spaceInviteId);
    spaceInv!.status = "Accepted";
    // ignore: unused_local_variable
    var updateSpace = await SpaceInvite.db.updateRow(session, spaceInv);
  }

  Future<int> addMember(
      Session session, int userId, SpaceInvite spInvite) async {
    try {
      // fetch userview
      List<String> teamTitles = spInvite.teams.map((team) {
        return team[0];
      }).toList();
      UserView? userview = await UserView.db.findById(session, userId);
      var teams = await Teams.db.find(session,
          where: (t) =>
              t.spaceId.equals(spInvite.spaceId) &
              t.teamTitle.inSet(teamTitles.toSet()));

      // create member object

      var memberObj = Member(
          userId: spInvite.userId,
          workspaceId: spInvite.spaceId,
          name: userview!.name,
          designation: spInvite.designation,
          avatar: userview.avatar,
          globalRole: spInvite.globalRole,
          joinedAt: DateTime.now());

      var memberInsert = await Member.db.insertRow(session, memberObj);
      List<TeamMember> teamRoles = [];
      List<ChatParticipant> chatParticipation = [];
      for (int i = 0; i < teams.length; i++) {
        var teamMemberObj = TeamMember(
            teamId: teams[i].id!,
            memberId: memberInsert.id!,
            role: spInvite.teams[i][1]);
        teamRoles.add(teamMemberObj);
        chatParticipation.add(ChatParticipant(
            chatId: teams[i].chatId, participant: memberInsert.id!));
      }
      await TeamMember.db.insert(session, teamRoles);
      await ChatParticipant.db.insert(session, chatParticipation);
      return memberInsert.id!;
    } catch (err) {
      return -1;
    }
  }

  Future<void> removeMember(Session session, List<int> memberIds) async {
    for (int id in memberIds) {
      // remove from task allocation
      // ignore: unused_local_variable
      var delAssigned = await TaskAssigned.db
          .deleteWhere(session, where: (t) => t.memberId.equals(id));
      // remove from all teams
      // ignore: unused_local_variable
      var delTeamMembership = await TeamMember.db
          .deleteWhere(session, where: (t) => t.memberId.equals(id));
      // get member data
      // ignore: unused_local_variable
      var memberObj =
          await Member.db.deleteWhere(session, where: (t) => t.id.equals(id));
    }
  }

  Future<void> editMemberRoles(
      Session session, List<Member> members, List<TeamMember> teamRoles) async {
    // ignore: unused_local_variable
    var updateMembers = await Member.db.update(session, members);
    // ignore: unused_local_variable
    var updateRoles = await TeamMember.db.update(session, teamRoles);
  }

  Future<List<Space>> fetchSpacesByUser(Session session, int userId) async {
    // Need to update this to query from members and then from spaces to fetch all spaces
    // after finishing role integration
    List<Space> spaces = [];
    var membership =
        await Member.db.find(session, where: (t) => t.userId.equals(userId));
    for (int i = 0; i < membership.length; i++) {
      var spaceData =
          await Space.db.findById(session, membership[i].workspaceId);
      spaces.add(spaceData!);
    }
    return spaces;
  }

  Future<Space?> fetchSpace(Session session, int spaceId) async {
    var space = await Space.db.findById(session, spaceId);
    return space;
  }

  Stream<Member> searchMemberByName(
      Session session, int spaceId, String query) async* {
    var users = await Member.db.find(session,
        where: (t) =>
            (t.name.ilike("%$query%") & t.workspaceId.equals(spaceId)));
    for (int i = 0; i < users.length; i++) {
      print("Retrieved Users: ${users[i].name}");
    }
    for (var user in users) {
      yield user;
    }
  }

  Future<Member> fetchMember(Session session, int userId) async {
    var member =
        await Member.db.find(session, where: (t) => t.userId.equals(userId));
    return member[0];
  }

  Future<List<List<String>>> fetchTitles(Session session, int spaceId) async {
    List<List<String>> result = [];
    var teamTitles =
        await Teams.db.find(session, where: (t) => t.spaceId.equals(spaceId));
    result.add(teamTitles.map((team) {
      return team.teamTitle;
    }).toList());
    var projectTitles = await Project.db.find(session,
        where: (t) => t.spaceId.equals(spaceId) & t.status.equals("Ongoing"));
    result.add(projectTitles.map((proj) {
      return proj.projectTitle;
    }).toList());
    return result;
  }

  Future<List<Project>> fetchProjectsByUser(
      Session session, List<int> teams) async {
    var projectAssigned = await ProjectAssigned.db
        .find(session, where: (t) => t.teamId.inSet(teams.toSet()));
    var projectIds = projectAssigned.map((proj) {
      return proj.projectId;
    }).toSet();
    var projects =
        await Project.db.find(session, where: (t) => t.id.inSet(projectIds));
    return projects;
  }

  Future<List<Teams>> fetchSpaceTeams(Session session, int spaceId) async {
    var teamsObj =
        await Teams.db.find(session, where: (t) => t.spaceId.equals(spaceId));
    return teamsObj;
  }

  Future<List<Project>> fetchSpaceProjects(Session session, int spaceId) async {
    var projectsObj =
        await Project.db.find(session, where: (t) => t.spaceId.equals(spaceId));
    return projectsObj;
  }

  Future<List<Teams>> fetchMemberTeams(Session session, int memberId) async {
    var teamMemberObj = await TeamMember.db
        .find(session, where: (t) => t.memberId.equals(memberId));
    var teams = await Teams.db.find(session,
        where: (t) => t.id.inSet(teamMemberObj.map((teamMember) {
              return teamMember.teamId;
            }).toSet()));
    return teams;
  }

  Future<Member?> fetchMemberByUserId(
      Session session, int spaceId, int userId) async {
    var memberObj = await Member.db.find(session,
        where: (t) => t.userId.equals(userId) & t.workspaceId.equals(spaceId));
    if (memberObj.isNotEmpty) {
      return memberObj[0];
    }
    return null;
  }

  Future<List<Member>> fetchMemberByMemberIds(
      Session session, List<int> memberIds) async {
    var memberObj = await Member.db
        .find(session, where: (t) => t.id.inSet(memberIds.toSet()));
    return memberObj;
  }

  Future<List<Member>> fetchSpaceMembers(Session session, int spaceId) async {
    var membersView = await Member.db
        .find(session, where: (t) => t.workspaceId.equals(spaceId));
    return membersView;
  }

  Future<List<SpaceInvite>> fetchSpaceInvites(
      Session session, int userId) async {
    var invites = await SpaceInvite.db
        .find(session, where: (t) => t.userId.equals(userId));
    return invites;
  }

  Future<int> fetchSpaceCount(Session session, int userId) async {
    var spaces =
        await Space.db.count(session, where: (t) => t.ownerId.equals(userId));
    return spaces;
  }
}
