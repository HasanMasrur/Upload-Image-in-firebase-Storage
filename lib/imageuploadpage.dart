import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;

class ImageUploadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageUploadPage();
  }
}

class _ImageUploadPage extends State<ImageUploadPage> {
  StorageReference storageRef = FirebaseStorage.instance.ref();
  File file;
  String postid = Uuid().v4();
  bool isloading = false;
  _getimage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxHeight: 400).then((File image) {
      setState(() {
        file = image;
      });
      return Navigator.pop(context);
    });
  }

  _selecteimage() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Text('Pick in image'),
                FlatButton(
                    onPressed: () {
                      _getimage(context, ImageSource.camera);
                    },
                    child: Text(
                      'Use Camara',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () {
                    _getimage(context, ImageSource.gallery);
                  },
                  child: Text('Use  Gallery',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPload image'),
      ),
      body: Column(
        children: [
          isloading ? LinearProgressIndicator() : Text(''),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 50, top: 50),
                  width: 240,
                  height: 200,
                  child: CircleAvatar(
                    radius: 80,
                    child: ClipOval(
                      child: SizedBox(
                          height: 180,
                          width: 180,
                          child: (file != null)
                              ? Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                )
                              : Image(
                                  image: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/image-upload-6a8b8.appspot.com/o/post_3c0d09f3-ba55-4de4-9f6f-00d7f0a4fa77.jpg?alt=media&token=05964063-5375-4e8a-adc5-10a86371d0a3'),
                                  fit: BoxFit.cover,
                                )),
                    ),
                  )),
              Container(
                padding: EdgeInsets.only(top: 160),
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.camera),
                  onPressed: () {
                    _selecteimage();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            color: Colors.orange,
            child: FlatButton(
                onPressed: isloading
                    ? null
                    : () {
                        handelsubmit();
                      },
                child: Text('submit')),
          )
        ],
      ),
    );
  }

  handelsubmit() async {
    setState(() {
      isloading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(file);
    setState(() {
      isloading = false;
      clearImage();
    });
  }

  clearImage() {
    setState(() {
      file = null;
    });
  }

  compressImage() async {
    final temDir = await getTemporaryDirectory();
    final path = temDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressImageFile = File('$path/img_$postid.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      file = compressImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
        storageRef.child('post_$postid.jpg').putFile(imageFile);

    StorageTaskSnapshot storagesnap = await uploadTask.onComplete;
    String downloadurl = await storagesnap.ref.getDownloadURL();
    print(downloadurl);

    return downloadurl;
  }
}
