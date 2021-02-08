import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web/utilities/constants.dart';
import 'dart:html' as html;
import 'package:path/path.dart' as Path;
import 'package:firebase/firebase.dart' as fb;

class StorageService {
  static Future<String> uploadUserProfileImage(
      String url, html.File imageFile) async {
    String photoId = Uuid().v4();
    File image = await compressImage(photoId, imageFile);

    if (url.isNotEmpty) {
      // Updating user profile image
      RegExp exp = RegExp(r'userProfile_(.*).jpg');
      photoId = exp.firstMatch(url)[1];
    }

    UploadTask uploadTask = storageRef
        .child('images/users/userProfile_$photoId.jpg')
        .putFile(image);
    TaskSnapshot storageSnap = await uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<File> compressImage(String photoId, html.File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
      image.relativePath,
      '$path/img_$photoId.jpg',
      quality: 70,
    );
    return compressedImageFile;
  }

  static Future<String> uploadImageToFirebaseAndShareDownloadUrl(
      MediaInfo info) async {
    File imageFileio;
    String mimeType = mime(Path.basename(info.fileName));
    final extension = extensionFromMime(mimeType);
    var metadata = fb.UploadMetadata(
      contentType: mimeType,
    );

    // html.File imageFile = new html.File(info.data, info.fileName, {'type': mimeType});
    //
    // final reader = html.FileReader();
    // reader.readAsDataUrl(imageFile);
    //
    // reader.onLoad.first.then((res) {
    //   final encoded = reader.result as String;
    //   final imageBase64 = encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');// this is to remove some non necessary stuff
    //   imageFileio = File.fromRawPath(base64Decode(imageBase64));
    // });
    //
    //
    //
    // UploadTask uploadTask = storageRef
    //     .child('images/users/images_${DateTime.now().millisecondsSinceEpoch}.${extension}')
    //     .putFile(imageFileio);
    // TaskSnapshot storageSnap = await uploadTask;
    // String downloadUrl = await storageSnap.ref.getDownloadURL();
    // return downloadUrl;


    fb.StorageReference ref = fb
        .app()
        .storage()
        .refFromURL('gs://catchmeon-4e321.appspot.com')
        .child(
        "images/users/images_${DateTime.now().millisecondsSinceEpoch}.${extension}");
    fb.UploadTask uploadTask = ref.put(info.data, metadata);

    fb.UploadTaskSnapshot taskSnapshot = await uploadTask.future;
    return taskSnapshot.ref.getDownloadURL().toString();
  }

}
