
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> saveImageToFirebase(File image) async {
  try{
    FirebaseStorage storage = FirebaseStorage.instance;
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = storage.ref().child('images/$imageName');
    await storageReference.putFile(image);
    String downloadUrl = await storageReference.getDownloadURL();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('images').add({
      'id': DateTime.now().toIso8601String(),
      'url': downloadUrl,
    });

    return downloadUrl;
  } catch(e){
    print(e);
    return null;
  }
}