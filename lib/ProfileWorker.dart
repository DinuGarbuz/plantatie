import 'package:ManagerPlantatii/WorkerStatisticsPage.dart';
import 'package:ManagerPlantatii/main.dart';
import 'package:flutter/material.dart';

void main() => runApp(ProfileWorker());

class ProfileWorker extends StatefulWidget {
  ProfileWorker({this.worker});
  final dynamic worker;

  @override
  State<StatefulWidget> createState() {
    return ProfileWorkerImpl(workerInfo: this.worker);
  }
}

class ProfileWorkerImpl extends State<ProfileWorker> {
  ProfileWorkerImpl({this.workerInfo});
  final dynamic workerInfo;

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
                        workerInfo["Name"].toString(),
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Worker",
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
                          WorkerStatistics(worker: workerInfo["WorkerID"])));
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
