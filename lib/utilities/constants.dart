import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firestore = FirebaseFirestore.instance;
final storageRef = FirebaseStorage.instance.ref();
final usersRef = _firestore.collection('users');
final followersRef = _firestore.collection('followers');
final followingRef = _firestore.collection('following');
final activitiesRef = _firestore.collection('activities');
