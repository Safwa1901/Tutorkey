// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter_application_1/controller/auth.dart';
// import 'package:flutter_application_1/model/global.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  // form validation key check
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String phone = '';
  late bool usertype; // Marked as late to initialize later
  int? userT; // Made nullable
  String error = '';
  bool _obscureText = true; // To toggle password visibility

  Color pl = Color(0xff440381);
  Color gn = Color(0xff22BF8D);
  Color pn = Color(0xffFF337E);
  Color yl = Color(0xffF0C742);

  final TextStyle _label = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double header = height * 0.2;
    final double body = height * 0.74;
    final double foot = height * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            // header
            Container(
              color: yl,
              height: header,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  ),
                ),
                height: 140,
                child: Center(
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),

            //form
            Container(
              height: body,
              decoration: BoxDecoration(
                color: yl,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    //name
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: _label,
                        labelText: 'Full Name',
                        fillColor: Colors.white,
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter name!' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),

                    //phone
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: _label,
                        labelText: 'Phone Number',
                        fillColor: Colors.white,
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter phone number!' : null,
                      onChanged: (val) {
                        setState(() => phone = val);
                      },
                    ),

                    //email
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: _label,
                        labelText: 'Email',
                        fillColor: Colors.white,
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter email!' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),

                    //password
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: _label,
                        labelText: 'Password',
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (val) =>
                          val!.length < 6 ? 'Password too short' : null,
                      obscureText: _obscureText,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),

                    //user type
                    SizedBox(height: 20.0),
                    DropdownButton<int>(
                      underline: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      style: _label,
                      hint: Text(
                        'Select Role',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: userT,
                      items: [
                        DropdownMenuItem(
                          child: Text('Tutor'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('Tutee'),
                          value: 2,
                        ),
                      ],
                      onChanged: (val) {
                        setState(() {
                          userT = val;
                          usertype = userT == 1; // true for Tutor, false for Tutee
                        });
                      },
                    ),

                    SizedBox(height: 30.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth.registerWithEmailAndPassword(
                              usertype,
                              name,
                              phone,
                              email,
                              password,
                            );

                            if (result == null) {
                              setState(() => error = 'Email invalid');
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Error message display
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              color: yl,
              alignment: Alignment.centerRight,
              height: foot,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  widget.toggleView();
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
