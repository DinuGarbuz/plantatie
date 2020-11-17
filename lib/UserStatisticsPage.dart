import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(UserStatistics());

class UserStatistics extends StatefulWidget {
  UserStatistics({this.user});
  final int user;

  @override
  State<StatefulWidget> createState() {
    return UserStatisticsImpl(userInfo: this.user);
  }
}

class UserStatisticsImpl extends State<UserStatistics> {
  UserStatisticsImpl({this.userInfo});
  final int userInfo;
  List<dynamic> statistics = new List();

  @override
  void initState() {
    super.initState();
    getPlantations();
  }

  Future<void> getPlantations() async {
    var result = await http.get(
        "https://plantatii-vc5.conveyor.cloud/api/Activity/GetUserStatistics?userId=" +
            userInfo.toString());
    var jsonResult = result.body;
    setState(() {
      statistics = json.decode(jsonResult);
    });
    print(statistics);
  }

  @override
  Widget build(BuildContext context) {
    if (statistics == null || statistics.isEmpty) {
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
              "User Statistics Page",
              style: TextStyle(
                fontSize: 36.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            for (var statistic in statistics)
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
                  child: Text(
                    "Numele plantatiei: " +
                        statistic["Name"].toString() +
                        "\n" +
                        "Tipul: " +
                        statistic["Type"] +
                        "\n" +
                        "Cantitate: " +
                        statistic["Quantity"].toString() +
                        "\n" +
                        "MuncitorID: " +
                        statistic["WorkerFK"].toString(),
                  ))
          ],
        ),
      );
  }
}
