import 'package:flutter/material.dart';
import 'package:stck/StockObjects/processingProduction.dart';
import 'package:stck/StockObjects/request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stck/jsonExtraction.dart';
import 'package:stck/pages/api.dart';
import 'package:stck/pages/productionManager/MaterialRequest.dart';
import 'package:stck/pages/productionManager/materialNote.dart';
import 'package:stck/pages/signIn/sign_in.dart';

String requestId;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _value = 1;
  List<Request> requests = [];
  List<ProcessingProduction> products;
  List materials;

  //get prdctin request
  Future getRequest() async {
    final response = await http.post(
        "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api",
        headers: {'accept': 'application/json'},
        body: {"code": "109", "api": "140", "user_id": userId});

    debugPrint(response.body);
    String serverResponse = response.body;
    var resbody = jsonDecode(serverResponse);
    int code = resbody['code'];
    if (code == 200) {
      setState(() {
        var convertDataToJson = jsonDecode(response.body);
        requests = JsonExtraction().extractProductFromJson(serverResponse);
      });
      debugPrint(requests.toString());
      debugPrint(materials.toString());
    }
  }

  //get processing request
  Future getProcessingProduct() async {
    final response = await http.post(
        "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api",
        headers: {'accept': 'application/json'},
        body: {"code": "108", "api": "140", "user_id": userId});

    debugPrint(response.body);
    String serverResponse = response.body;
    var resbody = jsonDecode(serverResponse);
    int code = resbody['code'];
    if (code == 200) {
      setState(() {
        var convertDataToJson = jsonDecode(response.body);
        products =
            JsonExtraction().extractProcessedProductFromJson(serverResponse);
      });
      debugPrint(products.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getRequest();
    getProcessingProduct();
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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFF00897B),
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'PRODUCTION',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              actions: <Widget>[nomalPopMenu()],
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    text: 'PENDING',
                  ),
                  Tab(
                    text: 'PROCESSING',
                  ),
                ],
              )),
          body: TabBarView(
            children: [
              Container(
                child: RefreshIndicator(
                  onRefresh: getRequest,
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 5, right: 5),
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
                                  builder: (context) => MaterialRequest(
                                      requests[index], requestId)));
                            },
                            child: Card(
                              child: ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('assets/images/zoazoa.png')
                                      // ),
                                      ),
                                ),
                                title: Text(
                                  requests[index].get_productName(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      requests[index].get_quantity() + 'litres',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  getTimeElapsed(
                                      requests[index].get_registered()),
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: requests == null ? 0 : requests.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                  ),
                ),
              ),
              RefreshIndicator(
                onRefresh: getProcessingProduct,
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 5, right: 5),
                        child: Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF00897B),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/images/zoazoa.png')
                                    // ),
                                    ),
                              ),
                              title: Text(
                                products[index].get_productName(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      products[index].get_quantity() + 'litres',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    products[index].get_status(),
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Container(
                                      height: 17,
                                      width: 17,
                                      child: InkWell(
                                        onTap: () async {
                                          showSuccessDialog(
                                              context, products[index]);
                                        },
                                        child: Image(
                                            image: AssetImage(
                                                'assets/icons/note.png')),
                                      ))),
                            )));
                  },
                  itemCount: products == null ? 0 : products.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                ),
              ),
            ],
          ),
        ));
  }

  Widget nomalPopMenu() {
    return new PopupMenuButton<int>(
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        new PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Icon(
                  Icons.category,
                  color: Colors.black,
                  size: 10,
                ),
              ),
              Text('material note',
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        new PopupMenuItem<int>(
            value: 2,
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text(
                    'log out',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )),
      ],
      onSelected: (int value) {
        switch (value) {
          case 1:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MaterialNote()));
            break;
          case 2:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Login()));
            break;
        }
      },
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
    );
  }

  Future<void> showSuccessDialog(
      BuildContext context, ProcessingProduction product) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
              child: ListBody(
            children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Center(
                  child: Text(
                    'Are you want to approve product completion',
                    style: TextStyle(color: Color(0xFF00897B), fontSize: 20),
                  ),
                ),
              )),
              SizedBox(height: 20),
              Icon(
                Icons.check_box,
                size: 50,
              ),
              //     ],
              // actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    TextButton(
                      child: Card(
                        child: Container(
                            height: 30,
                            width: 55,
                            child: Center(
                              child: Text(
                                'NO',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Card(
                        child: Container(
                            height: 30,
                            width: 55,
                            child: Center(
                              child: Text(
                                'YES',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      onPressed: () async {
                        var requestId = product.get_requestId();
                        var response = await postCompleteProduction(requestId);
                        print(response);

                        if (response.containsKey('code')) {
                          if (response['code'] == 200) {
                            requestId = response['request_id'];
                            Navigator.of(context).pop();
                            _approveProductCompletion(context);
                          } else {
                            setState(() {
                              print('Failed');
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ));
        }));
      },
    );
  }

  _approveProductCompletion(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.approval),
                  title: new Text('Production complete'),
                ),
              ],
            ),
          );
        });
  }
}
