// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProfileTutee extends StatefulWidget {
  @override
  _ProfileTuteeState createState() => _ProfileTuteeState();
}

class _ProfileTuteeState extends State<ProfileTutee> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _phone = '';
  String _bio = '';
  String _address = '';
  String _education = '';
  String _extra = '';

  Color yl = Color(0xffF0C742);
  Color wy = Colors.white;
  Color bl = Colors.black;

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    // Profile clone = profile;

    return Scaffold(
      backgroundColor: yl,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: _Appbar(bl: bl, wy: wy),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: wy,
          child: Container(
            decoration: BoxDecoration(
              color: yl,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Name
                  Text('Name'),
                  TextFormField(
                    initialValue: profile.fullName,
                    validator: (val) => val!.isEmpty ? 'Enter your name' : null,
                    onChanged: (val) {
                      setState(() {
                        _name = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),

                  // Phone Number
                  Text('Phone Number'),
                  TextFormField(
                    initialValue: profile.phoneNumber,
                    validator: (val) => val!.isEmpty ? 'Enter your phone number' : null,
                    onChanged: (val) {
                      setState(() => _phone = val);
                    },
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

                  // Examination (Extra Info)
                  Text('Examination'),
                  TextFormField(
                    initialValue: profile.extraInfo,
                    onChanged: (val) {
                      setState(() => _extra = val);
                    },
                  ),
                  SizedBox(height: 30.0),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_name.isEmpty) _name = profile.fullName;
                          if (_bio.isEmpty) _bio = profile.bio;
                          if (_phone.isEmpty) _phone = profile.phoneNumber;
                          if (_address.isEmpty) _address = profile.address;
                          if (_education.isEmpty) _education = profile.education;
                          if (_extra.isEmpty) _extra = profile.extraInfo;

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
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Appbar extends StatelessWidget {
  const _Appbar({
    Key? key,
    required this.bl,
    required this.wy,
  }) : super(key: key);

  final Color bl;
  final Color wy;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Feather.chevron_left,
          color: bl,
          size: 35,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: wy,
      title: Text(
        'MANAGE PROFILE',
        style: TextStyle(
          color: bl,
          fontSize: 27,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
      ),
    );
  }
}
