import 'package:flutter_application_1/controller/auth.dart';
import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/feedbackTutor/feedwrapper.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/homeTutor/homeTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/manageTutor/subjectTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/scheduleTutor/scheduleTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/testwrapperTutor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class DashboardTutor extends StatefulWidget {
  const DashboardTutor({Key? key}) : super(key: key);

  @override
  _DashboardTutorState createState() => _DashboardTutorState();
}

class _DashboardTutorState extends State<DashboardTutor> {
  Color yl = Color(0xffF0C742);
  Color wy = Colors.white;
  Color bl = Colors.black;

  TextStyle menu = TextStyle(
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final profile = Provider.of<Profile>(context);

    final double height = MediaQuery.of(context).size.height;
    final double top = height * 0.6;
    final double bottom = height * 0.4;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            //top
            Container(
              height: top,
              decoration: BoxDecoration(
                color: yl,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(45),
                ),
              ),
              padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
              child: Column(
                children: <Widget>[
                  // logout section
                  LogoutSection(yl: yl, auth: _auth),

                  ProfileSection(wy: wy, profile: profile),

                  // sub menu
                  SizedBox(height: 30),
                  MenuSection(wy: wy, menu: menu),
                ],
              ),
            ),

            //tutor session
            TutorSection(bottom: bottom, yl: yl, bl: bl, menu: menu),
          ],
        ),
      ),
    );
  }
}

class LogoutSection extends StatelessWidget {
  const LogoutSection({
    Key? key, // Use '?' for nullable key
    required this.yl, // Marked as required
    required AuthService auth, // Marked as required
  })  : _auth = auth, // Assign the auth parameter to the _auth field
        super(key: key);

  final Color yl;
  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
  return Container(
    color: yl,
    alignment: Alignment.centerRight,
    width: double.infinity,
    child: TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(20),
        // backgroundColor: Colors.white, // Uncomment if you want a background color
      ),
      onPressed: () async {
        await _auth.signOut();
      },
      child: Text(
        'LOGOUT',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        ),
      ),
    );
  }
}

class MenuSection extends StatelessWidget {
  // Removed 'const' to avoid the issue with the non-constant field
  const MenuSection({
    Key? key, // Use '?' for nullable key
    required this.wy, // Use 'required' for the fields
    required this.menu, // Use 'required' for the fields
  }) : super(key: key);

  final Color wy;
  final TextStyle menu;


  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //profile
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Feather.user,
                    color: wy,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeTutor()),
                    );
                  },
                ),
              ),

              // schedule
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Feather.calendar,
                    color: wy,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScheduleTutor()),
                    );
                  },
                ),
              ),

              //subject
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Feather.book_open,
                    color: wy,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SubjectTutor()),
                    );
                  },
                ),
              ),


              
            ],
          ),
          //menu title
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: 60,
                  child: Text('Profile',
                      style: menu, textAlign: TextAlign.center)),
              Container(
                  width: 60,
                  child: Text('Schedule',
                      style: menu, textAlign: TextAlign.center)),
              Container(
                  width: 60,
                  child: Text('Subject',
                      style: menu, textAlign: TextAlign.center)),
            //   Container(
            //       width: 63,
            //       child: Text('Feedssback',
            //           style: menu, textAlign: TextAlign.center)),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  ProfileSection({
    Key? key, // Make key nullable for null-safety
    required this.wy, // Mark as required
    required this.profile, // Mark as required
  }) : super(key: key);

  final Color wy;
  final Profile profile;
  final _formKey = GlobalKey<FormState>();
  //TextEditingController _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _price = profile.price;

    return Stack(
      children: <Widget>[
        Container(
          height: 200,
          width: double.infinity,
        ),
        Positioned(
          right: 13,
          child: Container(
            padding: EdgeInsets.only(left: 58),
            height: 170,
            width: 270,
            decoration: BoxDecoration(
              color: wy,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  profile.fullName,
                  style: TextStyle(fontSize: 23),
                ),
                Text(profile.bio),
                //Text(profile.phoneNumber),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 48,
          left: 10,
          child: ClipOval(
            child: SizedBox(
              height: 130.0,
              width: 130.0,
              child: Image.network(
                profile.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 6,
          right: 50,
          child: Container(
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 10),
                Text(
                  'RM',
                  style: TextStyle(color: wy, fontSize: 20),
                ),
                Text(
                  profile.price.toStringAsFixed(2),
                  style: TextStyle(color: wy, fontSize: 20),
                ),
                Text(
                  '/hour',
                  style: TextStyle(color: wy),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(
                    Feather.edit,
                    color: wy, // Assuming 'wy' is a defined color
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Stack(
                              clipBehavior: Clip
                                  .none, // Use clipBehavior instead of overflow
                              children: <Widget>[
                                Positioned(
                                  right: -40.0,
                                  top: -40.0,
                                  child: InkResponse(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: CircleAvatar(
                                      radius:
                                          20.0, // Set a radius for the CircleAvatar
                                      child: Icon(Icons.close,
                                          color: Colors
                                              .white), // Color of the close icon
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: "Enter new price rate",
                                          ),
                                          keyboardType: TextInputType.number,
                                          initialValue: _price.toString(),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly, // Updated to FilteringTextInputFormatter
                                          ],
                                          onChanged: (val) {
                                            // Check if the input is not empty before parsing
                                            if (val.isNotEmpty) {
                                              _price = double.parse(val);
                                            } else {
                                              _price =
                                                  0.0; // Reset to default or handle as needed
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a price rate'; // Error message if empty
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          child: Text("Submit"),
                                          onPressed: () async {
                                            await ProfileDataService(
                                                    uid: profile.uid)
                                                .updatePriceData(_price);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                )
              ],
            ),
            height: 50,
            width: 200,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class TutorSection extends StatelessWidget {
  const TutorSection({
    Key? key, // Use '?' for null safety
    required this.bottom,
    required this.yl,
    required this.bl,
    required this.menu,
  }) : super(key: key);

  final double bottom; // Not nullable since it's required
  final Color yl; // Not nullable since it's required
  final Color bl; // Not nullable since it's required
  final TextStyle menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottom,
      color: yl,
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    FontAwesome.bookmark,
                    color: Colors.red[900],
                    size: 30,
                  ),
                  onPressed: null,
                ),
                Text(
                  'Tutor Session',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //pending
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: yl,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Feather.clock,
                      color: bl,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestWrapperTutor(
                            destination: 'pending',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //ongoing
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: yl,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.history,
                      color: bl,
                      size: 37,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestWrapperTutor(
                            destination: 'accept',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //unpaid
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: yl,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Feather.dollar_sign,
                      color: bl,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestWrapperTutor(
                            destination: 'unpaid',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            //menu title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    width: 55,
                    child: Text('Pending',
                        style: menu, textAlign: TextAlign.center)),
                Container(
                    width: 55,
                    child: Text('Ongoing',
                        style: menu, textAlign: TextAlign.center)),
                Container(
                    width: 55,
                    child: Text('Unpaid',
                        style: menu, textAlign: TextAlign.center)),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //complete
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: yl,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Feather.check,
                      color: bl,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestWrapperTutor(
                            destination: 'complete',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //unpaid
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: yl,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Feather.x,
                      color: bl,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestWrapperTutor(
                            destination: 'reject',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            //menu title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    width: 75,
                    child: Text('Completed',
                        style: menu, textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    child: Text('Rejected',
                        style: menu, textAlign: TextAlign.center)),
              ],
            ),
          ],
        ),
        height: bottom,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
          ),
        ),
      ),
    );
  }
}
