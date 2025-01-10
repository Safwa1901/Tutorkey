import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/view/home/users/homewrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
print("Authenticated1 user ID: ${user.uid}");
    return StreamProvider<Profile?>.value(
      // value: ProfileDataService(uid: user!.uid).profile, 
      value: ProfileDataService(uid: user.uid).profile,
      initialData: null,
      catchError: (_, __) => null, 
      child: MaterialApp(
        home: HomeWrapper(),
      ),
    );
  }
}
