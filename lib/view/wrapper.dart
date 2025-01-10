// ignore_for_file: prefer_const_constructors

import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/view/authenticate/authenticate.dart';
import 'package:flutter_application_1/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
// return Home();
print("Authenticated user ID: ${user}");
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
