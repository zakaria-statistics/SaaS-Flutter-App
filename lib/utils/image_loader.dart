import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageLoader {
  final FirebaseStorage _storage = FirebaseStorage.instanceFor(
    bucket: "gs://firstapp-6a3b2.appspot.com",
  );

  Future<String> getImageUrl(String urlPath) async {
    final ref = _storage.ref().child(urlPath);
    try {
      final url = await ref.getDownloadURL();
      print("holly molly start getImage");
      print(url);
      print("holly molly end getImage");
      return url;
    } catch (error) {
      print("Error getting image URL: $error");
      return '';
    }
  }

  Future<String> openPicker(String path) async {
    String urlSnapshot = '';
    FilePickerResult? result;
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      Uint8List? uploadFile = result.files.single.bytes;
      String fileName = result.files.single.name;
      Reference reference = _storage.ref().child('/images/$path/$fileName');
      final UploadTask uploadTask = reference.putData(uploadFile!);
      TaskSnapshot snapshot = await uploadTask;
      urlSnapshot = await snapshot.ref.getDownloadURL();
      print(urlSnapshot);
    }
    return urlSnapshot;
  }
}
