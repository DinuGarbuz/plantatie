import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() => runApp(UserPlantation());

class UserPlantation extends StatefulWidget {
  UserPlantation({this.user});
  final int user;

  @override
  State<StatefulWidget> createState() {
    return UserPlantationImpl(userInfo: this.user);
  }
}

class UserPlantationImpl extends State<UserPlantation> {
  UserPlantationImpl({this.userInfo});
  final int userInfo;
  List<dynamic> plantations = new List();

  @override
  void initState() {
    super.initState();
    getPlantations();
  }

  Future<void> getPlantations() async {
    var result = await http.get(
        "https://plantatii-vc5.conveyor.cloud/api/Plantation/GetUserPlantations?userId=" +
            userInfo.toString());
    var jsonResult = result.body;
    setState(() {
      plantations = json.decode(jsonResult);
    });
    print(plantations);
  }

  @override
  Widget build(BuildContext context) {
    if (plantations == null || plantations.isEmpty) {
      return Scaffold(
        body: Text("Se incarca..."),
      );
    } else
      return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Text(
              "User Plantation Page",
              style: TextStyle(
                fontSize: 36.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            for (var plantation in plantations)
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.only(
                      left: 100, top: 16, right: 100, bottom: 16),
                  margin: EdgeInsets.only(
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Text("Numele plantatiei: " +
                      plantation["Name"].toString() +
                      "\n" +
                      "Tipul: " +
                      plantation["Type"]))
          ],
        ),
      );
  }
}
