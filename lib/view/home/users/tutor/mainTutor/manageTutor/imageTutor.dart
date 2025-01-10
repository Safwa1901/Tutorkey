// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers

import 'dart:io';
import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageTutor extends StatefulWidget {
  @override
  _ImageTutorState createState() => _ImageTutorState();
}

class _ImageTutorState extends State<ImageTutor> {
  File? _image; // Use nullable type

  // Image Picker
  Future<void> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source); // Updated to pickImage

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String? returnURL; // Use nullable type

  Future<void> uploadImage(BuildContext context) async {
    if (_image == null) {
      // Check if image is selected before uploading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image to upload.')),
      );
      return;
    }

    final firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profile_images/${_image!.path.split('/').last}'); // Save with a unique name
    await firebaseStorageRef.putFile(_image!); // Using the non-null assertion operator
    print('Image Uploaded!');

    // Get the download URL
    returnURL = await firebaseStorageRef.getDownloadURL();
    await ProfileDataService(uid: Provider.of<Profile>(context, listen: false).uid)
        .updateProfileImageData(returnURL!); // Use non-null assertion
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    print('URL: $returnURL');

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Profile Image'),
      ),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              ClipOval(
                child: SizedBox(
                  height: 300.0,
                  width: 300.0, // Set width to 300 for a round image
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover) // Use non-null assertion
                      : Image.network(
                          profile.image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              RawMaterialButton(
                fillColor: Theme.of(context).colorScheme.secondary, // Updated to colorScheme
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
                elevation: 8,
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                padding: EdgeInsets.all(15),
                shape: CircleBorder(),
              ),
              ElevatedButton( // Updated to ElevatedButton
                onPressed: () {
                  uploadImage(context);
                },
                child: Text('Upload'),
              ),
              ElevatedButton( // Updated to ElevatedButton
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
