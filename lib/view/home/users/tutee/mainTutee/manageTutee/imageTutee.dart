// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';
import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageTutee extends StatefulWidget {
  @override
  _ImageTuteeState createState() => _ImageTuteeState();
}

class _ImageTuteeState extends State<ImageTutee> {
  File? _image;
  String? returnURL;

  // Image Picker
  Future getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future uploadImage(BuildContext context) async {
    if (_image == null) return;

    try {
      Reference firebaseStorage = FirebaseStorage.instance.ref().child('images/${_image!.path.split('/').last}');
      UploadTask uploadTask = firebaseStorage.putFile(_image!);

      await uploadTask.whenComplete(() => print('Image uploaded'));

      returnURL = await firebaseStorage.getDownloadURL();
      print('Download URL: $returnURL');
    } catch (e) {
      print('Error occurred while uploading image: $e');
    }
  }

  String getURL() {
    return returnURL ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Profile Image'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            ClipOval(
              child: SizedBox(
                height: 150.0,
                width: 150.0,
                child: (_image != null)
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : Image.network(
                        profile.image,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              icon: Icon(Icons.add_a_photo),
              label: Text('Choose from Gallery'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await uploadImage(context);
                if (returnURL != null) {
                  await ProfileDataService(uid: profile.uid).updateProfileImageData(getURL());
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image Uploaded Successfully')));
                }
              },
              child: Text('Upload Image'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
                backgroundColor: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
