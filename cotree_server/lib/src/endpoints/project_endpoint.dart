import 'dart:typed_data';

import 'package:cotree_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ProjectEndpoint extends Endpoint {
  Future<void> removeProject(
      Session session, int spaceId, int projectId) async {
    // get project obj
    var projectObj = await Project.db.findFirstRow(session,
        where: (t) => t.spaceId.equals(spaceId) & t.id.equals(projectId));
    if (projectObj != null) {
      // remove tasks
      var removeTasks = await Task.db
          .deleteWhere(session, where: (t) => t.projectId.equals(projectId));
      // ignore: unused_local_variable
      var removeAssignedTadsks = await TaskAssigned.db.deleteWhere(session,
          where: (t) => t.taskId.inSet(removeTasks.map((task) {
                return task.id!;
              }).toSet()));
      // remove docs
      // ignore: unused_local_variable
      var removeDocs = await Documents.db
          .deleteWhere(session, where: (t) => t.projectId.equals(projectId));
      // delete file from storage
      // remove assigned teams
      // ignore: unused_local_variable
      var assignedTeams = await ProjectAssigned.db
          .deleteWhere(session, where: (t) => t.projectId.equals(projectId));
      // remove project
      // ignore: unused_local_variable
      var removeProject = await Project.db.deleteRow(session, projectObj);
    }
  }

  Future<void> changeProjectStatus(
      Session session, int projectId, String newStatus) async {
    var projectData = await Project.db.findById(session, projectId);
    projectData!.status = newStatus;
    // ignore: unused_local_variable
    var updProject = await Project.db.updateRow(session, projectData);
  }

  Future<List<Teams>> fetchExcludedProjectTeams(
      Session session, int projectId) async {
    var projectTeams = await ProjectAssigned.db
        .find(session, where: (t) => t.projectId.equals(projectId));
    var teams = await Teams.db.find(session,
        where: (t) => t.id.notInSet(projectTeams.map((proj) {
              return proj.teamId;
            }).toSet()));
    return teams;
  }

  Future<void> updateAssignedTeams(
      Session session,
      int projectId,
      List<int> deletedTeamsIds,
      List<int> addedTeamsIds,
      bool deleteDocuments) async {
    var members = await TeamMember.db
        .find(session, where: (t) => t.teamId.inSet(deletedTeamsIds.toSet()));
    Set<int> idSet = (members.map((memb) {
      return memb.memberId;
    }).toSet());
    // delete from teams assigned
    if (deletedTeamsIds.isNotEmpty) {
      // ignore: unused_local_variable
      var delAssignedTeams = await ProjectAssigned.db.deleteWhere(session,
          where: (t) =>
              t.projectId.equals(projectId) &
              t.teamId.inSet(deletedTeamsIds.toSet()));
      // delete from taskboard
      // ignore: unused_local_variable
      var delTasks = await TaskAssigned.db
          .deleteWhere(session, where: (t) => t.memberId.inSet(idSet));
      // If asked for, delete the documents as well
      if (deleteDocuments) {
        // ignore: unused_local_variable
        var delDocs = await Documents.db
            .deleteWhere(session, where: (t) => t.uploadedBy.inSet(idSet));
      }
    }
    // add new assigned teams
    if (addedTeamsIds.isNotEmpty) {
      List<ProjectAssigned> newTeams = [];
      for (int i = 0; i < addedTeamsIds.length; i++) {
        var team =
            ProjectAssigned(projectId: projectId, teamId: addedTeamsIds[i]);
        newTeams.add(team);
      }
      // ignore: unused_local_variable
      var insAssigned = await ProjectAssigned.db.insert(session, newTeams);
    }
  }

  // Creating a document
  Future<String> uploadFile(Session session, int projectId, int memberId,
      ByteData fileData, String filename) async {
    String path = "/files/$filename";
    // ignore: unused_local_variable
    final file = await session.storage
        .storeFile(storageId: "public", path: path, byteData: fileData);
    final verify =
        await session.storage.fileExists(storageId: "public", path: path);
    if (verify) {
      print("File Uploaded Successfully");
      var uri =
          await session.storage.getPublicUrl(storageId: "public", path: path);
      var documentsObj = Documents(
          projectId: projectId,
          title: filename,
          url: uri.toString(),
          uploadedBy: memberId,
          uploadedAt: DateTime.now());
      // ignore: unused_local_variable
      var documentsIns = Documents.db.insertRow(session, documentsObj);
      return uri.toString();
    }
    return "";
  }

  // Fetching documents
  Future<List<Documents>> fetchDocuments(Session session, int projectId) async {
    var documents = await Documents.db
        .find(session, where: (t) => t.projectId.equals(projectId));
    return documents;
  }

  // Deleting a document
  Future<int> deleteDocument(Session session, int documentId) async {
    var documentsObj = await Documents.db.findById(session, documentId);
    if (documentsObj != null) {
      // ignore: unused_local_variable
      var deleteDocument = Documents.db.deleteRow(session, documentsObj);
      // write code to delete the file from the server as well
      return 1;
    }
    return 0;
  }

  // Creating a task
  Future<Task?> createTask(
      Session session, Task task, List<int> assignedIds) async {
    try {
      var taskObj = Task(
          projectId: task.projectId,
          taskName: task.taskName,
          status: task.status,
          deadline: task.deadline);
      var taskIns = await Task.db.insertRow(session, taskObj);
      List<TaskAssigned> assignedObjs = [];
      for (int i = 0; i < assignedIds.length; i++) {
        assignedObjs
            .add(TaskAssigned(taskId: taskIns.id!, memberId: assignedIds[i]));
      }
      // ignore: unused_local_variable
      var insAssigned = await TaskAssigned.db.insert(session, assignedObjs);
      var createdTask = await Task.db.findById(session, taskIns.id!,
          include: Task.include(
            assigned: TaskAssigned.includeList(),
          ));
      return createdTask;
    } catch (err) {
      return null;
    }
  }

  // Fetching tasks
  Future<List<Task>> fetchMemberTasks(Session session, int memberId) async {
    List<Task> taskData = [];
    try {
      final tasks = await Task.db.find(
        session,
        where: (t) =>
            t.deadline.notEquals(null) &
            //t.deadline.greaterThan(DateTime.now()) &
            t.assigned.any((a) => a.memberId.equals(memberId)),
        include: Task.include(
          assigned: TaskAssigned.includeList(),
        ),
      );
      return tasks;
    } catch (err) {
      return taskData;
    }
  }

  Future<List<Task>> fetchTasks(Session session, List<int> projectId) async {
    var tasks = await Task.db.find(session,
        where: (t) => t.projectId.inSet(
              projectId.map((ids) {
                return ids;
              }).toSet(),
            ),
        include: Task.include(
          assigned: TaskAssigned.includeList(),
        ));
    return tasks;
  }

  Future<Project> fetchProject(Session session, int projectId) async {
    var project = await Project.db.findById(session, projectId);
    return project!;
  }

  Future<List<Teams>> fetchProjectTeams(
      Session session, List<int> projectIds) async {
    var projAssigned = await ProjectAssigned.db
        .find(session, where: (t) => t.projectId.inSet(projectIds.toSet()));
    var teams = await Teams.db.find(session,
        where: (t) => t.id.inSet(projAssigned.map((proj) {
              return proj.teamId;
            }).toSet()));
    return teams;
  }

  Future<List<Member>> fetchProjectMembers(
      Session session, int projectId) async {
    var projAssigned = await ProjectAssigned.db
        .find(session, where: (t) => t.projectId.equals(projectId));
    print(projAssigned);
    var teams = await TeamMember.db.find(session,
        where: (t) => t.teamId.inSet(projAssigned.map((proj) {
              return proj.teamId;
            }).toSet()));
    print(teams);
    var members = await Member.db.find(session,
        where: (t) => t.id.inSet(teams.map((team) {
              return team.memberId;
            }).toSet()));
    print(members);
    return members;
  }

  // Editing a task
  Future<void> updateTask(Session session, Task taskObj) async {
    // ignore: unused_local_variable
    var tasks = await Task.db.updateRow(session, taskObj);
  }

  // Deleting a task
  Future<void> deleteTask(Session session, int taskId) async {
    var task = await Task.db.findById(session, taskId);
    if (task != null) {
      // ignore: unused_local_variable
      var delTask = await Task.db.deleteRow(session, task);
    }
  }
}
