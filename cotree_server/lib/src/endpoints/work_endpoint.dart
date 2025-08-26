import 'package:cotree_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class WorkEndpoint extends Endpoint {
  // Create Work Offer
  Future<void> createWorkOffer(
      Session session,
      int authorId,
      String authorName,
      String title,
      String pay,
      String offerType,
      String location,
      String description,
      int duration,
      List<String> qualifications) async {
    // Create Offer Object
    var offerObj = Offers(
      title: title,
      acceptingApplications: true,
      isActive: true,
      author: authorId,
      authorName: authorName,
      pay: pay,
      offerType: offerType,
      location: location,
      description: description,
      duration: duration,
      qualifications: qualifications,
    );
    // Insert Offer Object
    // ignore: unused_local_variable
    var insertOff = await Offers.db.insertRow(session, offerObj);
  }

  // Fetch Available Work Offers
  // Using Retrieve All for now
  Future<List<Offers>> fetchOffers(Session session) async {
    var offersList =
        await Offers.db.find(session, where: (t) => t.isActive.equals(true));
    return offersList;
  }

  // Stop Accepting Applications
  Future<int> haltApplications(Session session, int offerId, bool halt) async {
    var offerData = await Offers.db.findById(session, offerId);
    if (offerData != null) {
      offerData.acceptingApplications = halt;
      await Offers.db.updateRow(session, offerData);
      return 0;
    }
    return 1;
  }

  // Close Work Offer
  Future<int> closeOffer(Session session, int offerId) async {
    var offerData = await Offers.db.findById(session, offerId);
    if (offerData != null) {
      // Set offer status to inactive
      offerData.isActive = false;
      // push changes
      await Offers.db.updateRow(session, offerData);
      return 0;
    }
    return 1;
  }

  // Delete Work Offer
  Future<void> deleteOffer(Session session, int? userId, int? offerId) async {
    var offerObj = await Offers.db.findById(session, offerId!);
    if (offerObj!.author == userId) {
      // For all not shortlisted applications, set status to not shortlisted
      var applications = await Applications.db
          .find(session, where: (t) => t.offerId.equals(offerId));
      for (int i = 0; i < applications.length; i++) {
        if (applications[i].status != "Shortlisted") {
          applications[i].status = "Not Shortlisted";
          // Update the applications
        }
      }
      // ignore: unused_local_variable
      var updateApplication =
          await Applications.db.update(session, applications);
      // Delete Work Offer
      // ignore: unused_local_variable
      var delOffer = await Offers.db.deleteRow(session, offerObj);
    }
  }

  // Submit Application
  Future<void> submitApplication(Session session, Offers offerData,
      int? applicantId, String description, List<int> qualifyIndices) async {
    // Create Application Obj
    var application = Applications(
        individualId: applicantId!,
        shortDescription: description,
        qualifyIndices: qualifyIndices,
        offerId: offerData.id!,
        status: "Submitted");
    // ignore: unused_local_variable
    var insertApplication =
        await Applications.db.insertRow(session, application);
  }
  // Review Application

  // Withdraw Application
  Future<void> withdrawApplication(
      Session session, int offerId, int? applicantId) async {
    // Retrieve Application Id
    var application = await Applications.db.find(session,
        where: (t) =>
            t.offerId.equals(offerId) & t.individualId.equals(applicantId));
    // delete application object
    // ignore: unused_local_variable
    var delApplication = Applications.db.deleteRow(session, application[0]);
  }

  // Retrieve User Applications
  Future<List<Applications>> fetchUserApplications(
      Session session, int userId) async {
    var applicationData = await Applications.db
        .find(session, where: (t) => t.individualId.equals(userId));
    return applicationData;
  }

  Future<List<Offers>> getOffersData(
      Session session, List<int> offerIds) async {
    List<Offers> offerInfo = [];
    for (int i = 0; i < offerIds.length; i++) {
      var offerData = await Offers.db.findById(session, offerIds[i]);
      offerInfo.add(offerData!);
    }
    return offerInfo;
  }

  Future<List<Offers>> fetchSearchOffers(
      Session session, String pattern) async {
    var offers = await Offers.db
        .find(session, where: (t) => t.title.ilike("%$pattern%"));
    return offers;
  }

  Future<List<Offers>> fetchAuthorOffers(Session session, int userId) async {
    var offers =
        await Offers.db.find(session, where: (t) => t.author.equals(userId));
    return offers;
  }

  Future<void> changeApplicationStatus(
      Session session, Applications application, String newStatus) async {
    //
    application.status = newStatus;
    await Applications.db.updateRow(session, application);
  }

  Future<List<Applications>> fetchApplicationsForReview(
      Session session, int offerId) async {
    var applications = await Applications.db
        .find(session, where: (t) => t.offerId.equals(offerId));
    return applications;
  }

  Future<bool> hasApplied(Session session, int userId, int offerId) async {
    var applications = await Applications.db.find(session,
        where: (t) =>
            t.individualId.equals(userId) & t.offerId.equals(offerId));
    if (applications.isEmpty) {
      return false;
    }
    return true;
  }
}
