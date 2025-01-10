// ignore_for_file: prefer_const_constructors

import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/manageTutor/imageTutor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTutor extends StatefulWidget {
  @override
  _ProfileTutorState createState() => _ProfileTutorState();
}

class _ProfileTutorState extends State<ProfileTutor> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _phone = '';
  String _bio = '';
  String _address = '';
  String _education = '';
  String _extra = '';

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile Setting'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Image button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageTutor()),
                  );
                },
                child: Text('Change Profile Image'),
              ),
              SizedBox(height: 20.0),

              // Name
              Text('Name'),
              TextFormField(
                initialValue: profile.fullName,
                onChanged: (val) {
                  setState(() {
                    _name = val.isEmpty ? profile.fullName : val;
                  });
                },
                validator: (val) => val!.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 20.0),

              // Phone number
              Text('Phone Number'),
              TextFormField(
                initialValue: profile.phoneNumber,
                onChanged: (val) {
                  setState(() => _phone = val);
                },
                validator: (val) => val!.isEmpty ? 'Enter your phone number' : null,
              ),
              SizedBox(height: 20.0),

              // Bio
              Text('Bio'),
              TextFormField(
                initialValue: profile.bio,
                onChanged: (val) {
                  setState(() => _bio = val);
                },
              ),
              SizedBox(height: 20.0),

              // Address
              Text('Address'),
              TextFormField(
                initialValue: profile.address,
                onChanged: (val) {
                  setState(() => _address = val);
                },
              ),
              SizedBox(height: 20.0),

              // Education
              Text('Education'),
              TextFormField(
                initialValue: profile.education,
                onChanged: (val) {
                  setState(() => _education = val);
                },
              ),
              SizedBox(height: 20.0),

              // Experience
              Text('Experience'),
              TextFormField(
                initialValue: profile.extraInfo,
                onChanged: (val) {
                  setState(() => _extra = val);
                },
              ),
              SizedBox(height: 20.0),

              // Save button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Default to existing profile data if the fields are empty
                    _name = _name.isEmpty ? profile.fullName : _name;
                    _bio = _bio.isEmpty ? profile.bio : _bio;
                    _phone = _phone.isEmpty ? profile.phoneNumber : _phone;
                    _address = _address.isEmpty ? profile.address : _address;
                    _education = _education.isEmpty ? profile.education : _education;
                    _extra = _extra.isEmpty ? profile.extraInfo : _extra;

                    await ProfileDataService(uid: profile.uid).updateProfileData(
                      _name,
                      _bio,
                      _phone,
                      _address,
                      _education,
                      _extra,
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Set the button color
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
