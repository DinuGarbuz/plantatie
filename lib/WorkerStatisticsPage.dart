import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(WorkerStatistics());

class WorkerStatistics extends StatefulWidget {
  WorkerStatistics({this.worker});
  final int worker;

  @override
  State<StatefulWidget> createState() {
    return WorkerStatisticsImpl(workerInfo: this.worker);
  }
}

class WorkerStatisticsImpl extends State<WorkerStatistics> {
  WorkerStatisticsImpl({this.workerInfo});
  final int workerInfo;
  List<dynamic> statistics = new List();

  @override
  void initState() {
    super.initState();
    getPlantations();
  }

  Future<void> getPlantations() async {
    var result = await http.get(
        "https://plantatii-vc5.conveyor.cloud/api/Activity/GetWorkerStatistics?workerId=" +
            workerInfo.toString());
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
              "Worker Statistics Page",
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
                  child: Text("Numele plantatiei: " +
                      statistic["Name"].toString() +
                      "\n" +
                      "Tipul: " +
                      statistic["Type"] +
                      "\n" +
                      "Cantitate: " +
                      statistic["Quantity"].toString()))
          ],
        ),
      );
  }
}
