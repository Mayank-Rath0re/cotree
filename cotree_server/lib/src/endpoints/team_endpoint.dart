import 'package:cotree_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TeamEndpoint extends Endpoint {
  Future<void> removeTeam(
      Session session, int spaceId, int teamId, bool delDocs) async {
    // fetch team obj
    var teamObj = await Teams.db.findFirstRow(session,
        where: (t) => t.spaceId.equals(spaceId) & t.id.equals(teamId));
    if (teamObj != null) {
      var teamMembers = await TeamMember.db
          .find(session, where: (t) => t.teamId.equals(teamId));
      var memberIds = teamMembers.map((memb) {
        return memb.memberId;
      }).toSet();
      // remove tasks assigned to the team members
      // ignore: unused_local_variable
      var assignedTasks = await TaskAssigned.db
          .deleteWhere(session, where: (t) => t.memberId.inSet(memberIds));
      if (delDocs) {
        // ignore: unused_local_variable
        var removeDocs = await Documents.db
            .deleteWhere(session, where: (t) => t.uploadedBy.inSet(memberIds));
      }
      // remove projects assigned to team
      // ignore: unused_local_variable
      var removeProjs = await ProjectAssigned.db
          .deleteWhere(session, where: (t) => t.teamId.equals(teamId));
      // remove team members
      // ignore: unused_local_variable
      var removeMembers = await TeamMember.db.delete(session, teamMembers);
      // remove team
    }
  }

  Future<void> editTeamRole(
      Session session, int memberId, int teamId, String newRole) async {
    var teamMember = await TeamMember.db.findFirstRow(session,
        where: (t) => t.memberId.equals(memberId) & t.teamId.equals(teamId));
    teamMember!.role = newRole;
    // ignore: unused_local_variable
    var updateRole = await TeamMember.db.updateRow(session, teamMember);
  }

  Future<List<TeamMember>> fetchTeamRoles(Session session, int teamId) async {
    var roles = await TeamMember.db
        .find(session, where: (t) => t.teamId.equals(teamId));
    return roles;
  }

  Future<List<int>> alertAffects(
      Session session, List<int> memberId, int teamId) async {
    // Check all assigned tasks
    var projs = await ProjectAssigned.db
        .find(session, where: (t) => t.teamId.equals(teamId));
    Set<int> projIds = projs.map((proj) {
      return proj.projectId;
    }).toSet();
    var tasks = await Task.db.count(session,
        where: (t) =>
            t.projectId.inSet(projIds) &
            t.assigned.any((a) => a.memberId.inSet(memberId.toSet())));
    // Check all documents
    var docs = await Documents.db.count(session,
        where: (t) =>
            t.projectId.inSet(projIds) & t.uploadedBy.inSet(memberId.toSet()));
    return [tasks, docs];
  }

  Future<void> addTeamMember(
      Session session, List<TeamMember> newMembers) async {
    // ignore: unused_local_variable
    var insTeamMembers = await TeamMember.db.insert(session, newMembers);
  }

  Future<void> removeTeamMember(Session session, List<int> memberId, int teamId,
      bool deleteTasks, bool deleteDocs) async {
    // Remove assigned team Members
    // ignore: unused_local_variable
    var delMember = await TeamMember.db
        .deleteWhere(session, where: (t) => t.memberId.inSet(memberId.toSet()));
    // Remove taskboard
    var projs = await ProjectAssigned.db
        .find(session, where: (t) => t.teamId.equals(teamId));
    Set<int> projIds = projs.map((proj) {
      return proj.projectId;
    }).toSet();
    var tasks = await Task.db.find(session,
        where: (t) =>
            t.projectId.inSet(projIds) &
            t.assigned.any((a) => a.memberId.inSet(memberId.toSet())));
    if (deleteTasks) {
      // No need to delete TaskAssigned explicitly
      await Task.db.delete(session, tasks);
    } else {
      // Still delete assignments for specific members
      await TaskAssigned.db.deleteWhere(session,
          where: (t) => t.memberId.inSet(memberId.toSet()));
    }
    // Check all documents
    var docs = await Documents.db.find(session,
        where: (t) =>
            t.projectId.inSet(projIds) & t.uploadedBy.inSet(memberId.toSet()));
    if (deleteDocs) {
      await Documents.db.delete(session, docs);
    }
  }

  // Teams Objects
  Future<String> fetchTeamTitle(Session session, int teamId) async {
    var team = await Teams.db.findById(session, teamId);
    return team!.teamTitle;
  }

  Future<List<Member>> fetchNonTeamMembers(Session session, int teamId) async {
    var members = await TeamMember.db
        .find(session, where: (t) => t.teamId.equals(teamId));
    Set<int> ids = members.map((memb) {
      return memb.memberId;
    }).toSet();
    var nonMembers =
        await Member.db.find(session, where: (t) => t.id.notInSet(ids));
    return nonMembers;
  }

  Future<List<Member>> fetchTeamMembers(
      Session session, List<int> teamIds) async {
    var teamMember = await TeamMember.db
        .find(session, where: (t) => t.teamId.inSet(teamIds.toSet()));
    var memberViews = await Member.db.find(session,
        where: (t) => t.id.inSet(teamMember.map((member) {
              return member.memberId;
            }).toSet()));
    return memberViews;
  }

  Future<List<Project>> fetchTeamProjects(
      Session session, List<int> teamIds) async {
    var projectAssigned = await ProjectAssigned.db
        .find(session, where: (t) => t.teamId.inSet(teamIds.toSet()));
    var projects = await Project.db.find(session,
        where: (t) => t.id.inSet(projectAssigned.map((proj) {
              return proj.projectId;
            }).toSet()));
    return projects;
  }

  // Create Meeting
  Future<void> createMeeting(
      Session session,
      int teamId,
      String agenda,
      String url,
      DateTime time,
      Duration duration,
      String status,
      int creatorId,
      List<int> members) async {
    print(time.toLocal());
    var meetingsObj = Meetings(
        teamId: teamId,
        agenda: agenda,
        url: url,
        time: time,
        duration: duration,
        status: status,
        startedBy: creatorId,
        members: members);
    // ignore: unused_local_variable
    var meetingIns = await Meetings.db.insertRow(session, meetingsObj);
  }

  // Receive Meeting
  Future<List<Meetings>> fetchMeetings(
      Session session, List<int> teamIds) async {
    var meetings = await Meetings.db
        .find(session, where: (t) => t.teamId.inSet(teamIds.toSet()));
    return meetings;
  }

  // Update Meeting
  Future<void> updateMeeting(Session session, Meetings meeting) async {
    // ignore: unused_local_variable
    var updateMeeting = await Meetings.db.updateRow(session, meeting);
  }

  // Delete Meeting
  Future<void> deleteMeeting(Session session, int meetingId) async {
    var meetingObj = await Meetings.db.findById(session, meetingId);
    if (meetingObj != null) {
      // ignore: unused_local_variable
      var delMeeting = await Meetings.db.deleteRow(session, meetingObj);
    }
  }

  // Team chat functionalities
}
