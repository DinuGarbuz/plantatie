import 'package:ManagerPlantatii/ProfileUser.dart';
import 'package:ManagerPlantatii/ProfileWorker.dart';
import 'package:ManagerPlantatii/PageRegister.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final emailController = TextEditingController();
final passwordController = TextEditingController();

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = new List();
  List<dynamic> workers = new List();
  int userId = 0;

  @override
  void initState() {
    super.initState();
    getUsers();
    getWorkers();
  }

  Future<void> getUsers() async {
    var result = await http
        .get("https://plantatii-vc5.conveyor.cloud/api/User/GetUsers");
    var jsonResult = result.body;
    setState(() {
      users = json.decode(jsonResult);
    });
    print(users);
  }


  Future<void> getWorkers() async {
    var result = await http
        .get("https://plantatii-vc5.conveyor.cloud/api/Worker/GetWorkers");
    var jsonResult = result.body;
    setState(() {
      workers = json.decode(jsonResult);
    });
    print(workers);
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
                    "Log In",
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
                                  controller: emailController,
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
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
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
                          onPressed: () {
                            var loggedIn = false;
                            print('Login Button Pressed');
                            //verificam daca e user
                            for (var user in users) {
                              if (user["Email"].toString() ==
                                      emailController.text.trim() &&
                                  user["Password"].toString() ==
                                      passwordController.text.trim()) {
                                //userId = user["UserID"];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileUser(user: user)));
                                loggedIn = true;
                              }
                            }
                            //verificam daca e worker
                            for (var worker in workers) {
                              if (worker["Email"].toString() ==
                                      emailController.text.trim() &&
                                  worker["Password"].toString() ==
                                      passwordController.text.trim()) {
                                //userId = user["UserID"];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileWorker(worker: worker)));
                                loggedIn = true;
                              }
                            }
                            if (!loggedIn) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content:
                                          Text('Wrong username or password'),
                                    );
                                  });
                            }
                            emailController.clear();
                            passwordController.clear();
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
                            child: const Text('Log In',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RaisedButton(
                          onPressed: () {
                            print('Register Button Pressed');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
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
                                horizontal: 20, vertical: 8),
                            child: const Text('Register',
                                style: TextStyle(fontSize: 14)),
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
