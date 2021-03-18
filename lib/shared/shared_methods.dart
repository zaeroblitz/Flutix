part of 'shared.dart';

Future<File> getImage() async {
  File image;
  final ImagePicker imagePicker = ImagePicker();

  var imagePath = await imagePicker.getImage(source: ImageSource.gallery);
  image = File(imagePath.path);

  return image;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask task = reference.putFile(image);
  StorageTaskSnapshot snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}
