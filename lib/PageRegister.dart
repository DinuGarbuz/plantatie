import 'package:ManagerPlantatii/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


//void main() => runApp(RegisterPage());

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String name = "";
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final userController = TextEditingController();

  Future<List<String>> postUser() async {
    var body = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
    });

    var result = await http.post(
      "https://plantatii-vc5.conveyor.cloud/api/User/AddUser",
      body: body,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
  }

  Future<List<String>> postWorker() async {
    var body = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
    });

    var result = await http.post(
      "https://plantatii-vc5.conveyor.cloud/api/Worker/AddWorker",
      body: body,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var borderSide = BorderSide(color: Colors.grey[200]);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.blue[900],
              Colors.blue[800],
              Colors.blue[400]
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Manager Plantatie",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(13, 72, 161, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: TextField(
                                  controller: TextEditingController()..text = name,
                                  onChanged: (value) {
                                    name = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: TextField(
                                  controller: TextEditingController()..text = email,
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: borderSide)),
                                child: TextField(
                                  controller: TextEditingController()..text = password,
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: borderSide)),
                                child: TextField(
                                  controller: userController,
                                  decoration: InputDecoration(
                                      hintText: "User type",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          onPressed: (){
                            print('Register Button Pressed');
                            if (userController.text == "user")
                              {
                                  postUser();
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HomePage()));
                              }
                            else
                              if(userController.text == "worker")
                              {
                                postWorker();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomePage()));
                              }
                            },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[600],
                                borderRadius: BorderRadius.circular(50)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 16),
                            child: const Text('Register',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          onPressed: () {
                            print('Already have an account Button Pressed');
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => HomePage()));
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[600],
                                borderRadius: BorderRadius.circular(50)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 16),
                            child: const Text('Already have an account',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

