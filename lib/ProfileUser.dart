import 'package:ManagerPlantatii/main.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'UserPlantationPage.dart';
import 'UserStatisticsPage.dart';

void main() => runApp(ProfileUser());

class ProfileUser extends StatefulWidget {
  ProfileUser({this.user});
  final dynamic user;

  @override
  State<StatefulWidget> createState() {
    return ProfileUserImpl(userInfo: this.user);
  }
}

class ProfileUserImpl extends State<ProfileUser> {
  ProfileUserImpl({this.userInfo});
  final dynamic userInfo;

  Future<List<String>> postUser() async {
    int userID;
    int plantationID;
    String date = "";
    int quantity;

    String cameraScanResult = await scanner.scan();

    Map<String, dynamic> scan = jsonDecode(cameraScanResult);

    userID = scan["id"];
    plantationID = scan["plantation"];
    DateFormat format = new DateFormat("y-M-d");
    date = format.parse(scan["date"].toString()).toString();
    quantity = scan["quantity"];

    var body = jsonEncode({
      "worker": userID,
      "plantation": plantationID,
      "date": date,
      "quantity": quantity
    });

    var result = await http.post(
      "https://plantatii-vc5.conveyor.cloud/api/Activity/AddActivity",
      body: body,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.greenAccent, Colors.blueAccent])),
              child: Container(
                width: double.infinity,
                height: 275.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://www.iconfinder.com/data/icons/user-pictures/100/male3-512.png",
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        userInfo["Name"].toString(),
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "User",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 9.0,
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserPlantation(user: userInfo["UserID"])));
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              child: const Text('View Plantations',
                  style: TextStyle(fontSize: 18)),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserStatistics(user: userInfo["UserID"])));
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              child:
                  const Text('View Statistics', style: TextStyle(fontSize: 18)),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () {
              postUser();
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              child: const Text('Add Activity', style: TextStyle(fontSize: 18)),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              child: const Text('Logout', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
