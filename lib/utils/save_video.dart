import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadVideo(String videoUrl) async {
    Reference ref = _storage.ref().child('videos/${DateTime.now()}.mp4');
    await ref.putFile(File(videoUrl));
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }
  Future<String> uploadImage(File? imageUrl, String filetype) async {
    Reference ref = _storage.ref().child('videos/${DateTime.now().millisecondsSinceEpoch}');
    final metadata = SettableMetadata(contentType: filetype);
    await ref.putFile(imageUrl!,metadata);
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> saveVideoData(
      String videoDownloadUrl, String imageDownloadUrl,String name, String descript) async {
    await _firestore.collection('videos').add(
      {
        'videoURL': videoDownloadUrl,
        'imageURL': imageDownloadUrl,
        'timeStamp': FieldValue.serverTimestamp(),
        'name': name,
        'description':descript
      },
    );
  }
}
