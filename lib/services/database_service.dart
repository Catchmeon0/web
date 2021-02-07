import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web/models/UserModel.dart';
import 'package:web/models/activity_model.dart';
import 'package:web/utilities/constants.dart';

class DatabaseService {
  static void updateUser(UserModel user) {
    usersRef.doc(user.id).update({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'userTwitter': user.userTwitter,
      'userYoutube': user.userYoutube,
    });

    //update on collection user
    var __firestore = FirebaseFirestore.instance;
    var _usersRef = __firestore.collection('user');
    _usersRef.doc(user.id).update({
      'name': user.name,
      'userIds': {'twitter': user.userTwitter, 'youtube': user.userYoutube},
    });
  }

  static Future<QuerySnapshot> searchUsers(String name, String platform) {
    Future<QuerySnapshot> users;
  String _platform = platform.toLowerCase();
   if(_platform == "youtube"){
      users =
          usersRef.where('userYoutube', isGreaterThanOrEqualTo: name).get();

    }else if(_platform == "twitter"){
      users =
          usersRef.where('userTwitter', isGreaterThanOrEqualTo: name).get();
    } else
     users =
         usersRef.where('name', isGreaterThanOrEqualTo: name).get();

    return users;
  }

  static Future<bool> isFollowingUser(
      {String currentUserId, String userId}) async {
    DocumentSnapshot followingDoc = await followersRef
        .doc(userId)
        .collection('userFollowers')
        .doc(currentUserId)
        .get();
    return followingDoc.exists;
  }

  static Future<int> numFollowing(String userId) async {
    QuerySnapshot followingSnapshot =
        await followingRef.doc(userId).collection('userFollowing').get();
    return followingSnapshot.docs.length;
  }

  static Future<int> numFollowers(String userId) async {
    QuerySnapshot followersSnapshot =
        await followersRef.doc(userId).collection('userFollowers').get();
    return followersSnapshot.docs.length;
  }

  static Future<UserModel> getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.doc(userId).get();
    if (userDocSnapshot.exists) {
      return UserModel.fromDoc(userDocSnapshot);
    }
    return UserModel();
  }

  static void followUser({String currentUserId, String userId}) {
    // Add user to current user's following collection
    followingRef
        .doc(currentUserId)
        .collection('userFollowing')
        .doc(userId)
        .set({});
    // Add current user to user's followers collection
    followersRef
        .doc(userId)
        .collection('userFollowers')
        .doc(currentUserId)
        .set({});

    // add followed user id to the list
    var __firestore = FirebaseFirestore.instance;
    var _usersRef = __firestore.collection('user');
    _usersRef.doc(currentUserId).update({
      'userFollowed': FieldValue.arrayUnion([userId]),
    });
    addActivityItem(currentUserId: currentUserId, userId:userId);
  }

  static void unfollowUser({String currentUserId, String userId}) {
    // Remove user from current user's following collection
    followingRef
        .doc(currentUserId)
        .collection('userFollowing')
        .doc(userId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // Remove current user from user's followers collection
    followersRef
        .doc(userId)
        .collection('userFollowers')
        .doc(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // remove followed user id to the list
    var __firestore = FirebaseFirestore.instance;
    var _usersRef = __firestore.collection('user');
    _usersRef.doc(currentUserId).update({
      'userFollowed': FieldValue.arrayRemove([userId]),
    });
    removeActivityItem(currentUserId: currentUserId, userId:userId);
  }

  listofYoutubefromFollowedUsers(String currentUserId) async {
    List<String> result = [];
    var __firestore = FirebaseFirestore.instance;
    var _usersRef = __firestore.collection('user');
    DocumentSnapshot listYoutubeChannel =
        await _usersRef.doc(currentUserId).get();

     if(listYoutubeChannel.exists){
       List<dynamic> data = listYoutubeChannel.data()["userFollowed"];
       for(int i = 0; i<data.length; i++){
         DocumentSnapshot youtubeChannel = await usersRef.doc(data[i]).get();
         if (youtubeChannel.exists) {
           String _data = youtubeChannel.data()["userYoutube"];

           if (_data.isNotEmpty) {
             result.add(_data);
           }
         }

       }
     }

    print("databseservice");
    print(result);
    return result;
  }

  getUserChannelNameFromUserID(String userId) async {
    DocumentSnapshot listYoutubeChannel =
    await usersRef.doc(userId).get();
    var userChannelName = listYoutubeChannel.data()["userYoutube"];

    return userChannelName;

  }


  getUserTweetScreenNameFromUserID(String userId) async {
    DocumentSnapshot listYoutubeChannel =
    await usersRef.doc(userId).get();
    var userChannelName = listYoutubeChannel.data()["userTwitter"];

    return userChannelName;
  }

  static void addActivityItem(
      {String currentUserId, String userId}) {
    if (currentUserId != userId) {
      activitiesRef.doc(userId).collection('userActivities').add({
        'fromUserId': currentUserId,
        'timestamp': Timestamp.fromDate(DateTime.now()),
      });
    }
  }

  static void removeActivityItem(
      {String currentUserId, String userId}) {
    if (currentUserId != userId) {
      activitiesRef.doc(userId)
          .collection('userActivities')
          .where('fromUserId',isEqualTo: currentUserId)
          .get().then((value) =>
      {
        value.docs.forEach((element) {
          activitiesRef.doc(userId)
              .collection('userActivities')
              .doc(element.id)
              .delete().then((value) => print("deleted activity with Success!"));
        })
      });

    }
  }

  static Future<List<Activity>> getActivities(String userId) async {
    print('adding an activity');
    QuerySnapshot userActivitiesSnapshot = await activitiesRef
        .doc(userId)
        .collection('userActivities')
        .orderBy('timestamp', descending: true)
        .get();

    print(userActivitiesSnapshot);
    List<Activity> activity = userActivitiesSnapshot.docs
        .map((doc) => Activity.fromDoc(doc))
        .toList();
    return activity;
  }

  numFollowedUser(String CurrentUserID) async{
    List<String> followedUserList;
    QuerySnapshot followingSnapshot =
        await followingRef.doc(CurrentUserID).collection('userFollowing').get();

    return followingSnapshot.docs.length;


  }

}
