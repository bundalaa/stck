import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stck/StockObjects/materialRequest.dart';
import 'package:stck/jsonExtraction.dart';
import 'package:stck/pages/api.dart';
import 'package:stck/pages/productionManager/viewReceivedMaterialNoteMaterial.dart';
import 'package:stck/pages/productionManager/viewSentMaterialNoteMaterial.dart';
import 'package:stck/pages/signIn/sign_in.dart';
import 'package:http/http.dart' as http;

String id;

class MaterialNote extends StatefulWidget {
  MaterialRequest materialrequest;
  @override
  _MaterialNoteState createState() => _MaterialNoteState();
}

class _MaterialNoteState extends State<MaterialNote> {
  List<MaterialRequest> sentmaterialrequests = [];
  List<MaterialRequest> receivedmaterialrequests = [];

  List materials;
  //get  material request sent
  Future getMaterialRequestSent() async {
    final response = await http.post(
        "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api",
        headers: {'accept': 'application/json'},
        body: {"code": "110", "api": "140", "user_id": userId});

    debugPrint(response.body);
    String serverResponse = response.body;
    var resbody = jsonDecode(serverResponse);
    int code = resbody['code'];
    if (code == 200) {
      setState(() {
        var convertDataToJson = jsonDecode(response.body);
        sentmaterialrequests =
            JsonExtraction().extractMaterialRequestFromJson(serverResponse);
      });
      debugPrint(sentmaterialrequests.toString());
    }
  }

  //get  material request sent
  Future getMaterialRequestReceived() async {
    final response = await http.post(
        "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api",
        headers: {'accept': 'application/json'},
        body: {"code": "111", "api": "140", "user_id": userId});

    debugPrint(response.body);
    String serverResponse = response.body;
    var resbody = jsonDecode(serverResponse);
    int code = resbody['code'];
    if (code == 200) {
      setState(() {
        var convertDataToJson = jsonDecode(response.body);
        receivedmaterialrequests =
            JsonExtraction().extractMaterialRequestFromJson(serverResponse);
      });
      debugPrint(receivedmaterialrequests.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getMaterialRequestSent();
    getMaterialRequestReceived();
  }

  String getTimeElapsed(String registered) {
    int registeredTime = 0;
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int SECOND_MILLIS = 1000;
    int MINUTE_MILLIS = 60 * SECOND_MILLIS;
    int HOUR_MILLIS = 60 * MINUTE_MILLIS;
    final int DAY_MILLIS = 24 * HOUR_MILLIS;

    var parsedDate = DateTime.parse(registered);
    registeredTime = parsedDate.millisecondsSinceEpoch;

    int timeDifference = currentTime - registeredTime;

    if (timeDifference < MINUTE_MILLIS) {
      return "just now";
    } else if (timeDifference < 2 * MINUTE_MILLIS) {
      return "a min";
    } else if (timeDifference < 50 * MINUTE_MILLIS) {
      return "${(timeDifference / MINUTE_MILLIS).toStringAsFixed(0)} mins";
    } else if (timeDifference < 90 * MINUTE_MILLIS) {
      return "an hour";
    } else if (timeDifference < 24 * HOUR_MILLIS) {
      return "${(timeDifference / HOUR_MILLIS).toStringAsFixed(0)} hours";
    } else if (timeDifference < 48 * HOUR_MILLIS) {
      return "yesterday";
    } else {
      return "${(timeDifference / DAY_MILLIS).toStringAsFixed(0)} days";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<RMaterial> rawmaterialsSent = [];
    sentmaterialrequests.forEach((materialRequestSent) {
      rawmaterialsSent = rawmaterialsSent + materialRequestSent.materials;
    });
    List<RMaterial> rawmaterialsreceived = [];
    receivedmaterialrequests.forEach((materialRequestreceived) {
      rawmaterialsreceived =
          rawmaterialsreceived + materialRequestreceived.materials;
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF00897B),
            leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text('MATERIAL NOTE',
                style: TextStyle(
                  color: Colors.white,
                )),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  text: 'SENT',
                ),
                Tab(
                  text: 'RECEIVED',
                ),
              ],
            )),
        body: TabBarView(
          children: [
            Container(
              child: RefreshIndicator(
                onRefresh: getMaterialRequestSent,
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                      child: Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF00897B),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewMaterialsSent(
                                      sentmaterialrequests[index], id)));
                            },
                            child: ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Icon(Icons.send_and_archive),
                              ),
                              title: Text(
                                sentmaterialrequests[index].get_name(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                getTimeElapsed(sentmaterialrequests[index]
                                    .get_registered()),
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: sentmaterialrequests == null
                      ? 0
                      : sentmaterialrequests.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                ),
              ),
            ),
            ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                    child: Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF00897B),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ReceivedMaterialsSent(
                                    receivedmaterialrequests[index], id)));
                          },
                          child: ListTile(
                            leading: Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Icon(Icons.details_sharp)),
                            title: Text(
                              receivedmaterialrequests[index].get_name(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )));
              },
              itemCount: receivedmaterialrequests == null
                  ? 0
                  : receivedmaterialrequests.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
