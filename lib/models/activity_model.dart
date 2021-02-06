import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String id;
  final String fromUserId;
  final Timestamp timestamp;

  Activity({
    this.id,
    this.fromUserId,
    this.timestamp,
  });

  factory Activity.fromDoc(DocumentSnapshot doc) {
    return Activity(
      id: doc.id,
      fromUserId: doc.data()['fromUserId'],
      timestamp: doc.data()['timestamp'],
    );
  }
}
