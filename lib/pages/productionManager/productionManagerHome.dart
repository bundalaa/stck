import 'package:flutter/material.dart';
import 'package:stck/StockObjects/processingProduction.dart';
import 'package:stck/StockObjects/request.dart';
import 'package:stck/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stck/jsonExtraction.dart';
import 'package:stck/pages/api.dart';
import 'package:stck/pages/productionManager/Production&MaterialRequest.dart';
import 'package:stck/pages/productionManager/materialNote.dart';
import 'package:stck/pages/signIn/sign_in.dart';

String requestId;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _value = 1;
  List<Request> requests;
  List<ProcessingProduction> products;
  bool presscomplete = false;
  bool pressIncomplete = false;
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
                                  builder: (context) =>
                                      ProductionAndMaterialRequest(
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
                                  requests[index].get_registered(),
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.black,
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
                              trailing:
                                  //  Column(
                                  //   children: [
                                  // FlatButton(
                                  //     // shape: new RoundedRectangleBorder(
                                  //     //     borderRadius:
                                  //     //         new BorderRadius.circular(18.0),
                                  //     //     side: BorderSide(color: Colors.grey)),
                                  //     color: presscomplete
                                  //         ? Color(0xFF00897B)
                                  //         : Colors.grey,
                                  //     textColor: Colors.white,
                                  //     child: pressIncomplete
                                  //         ? Text("complete")
                                  //         : Text("Incomplete"),
                                  //     //    style: TextStyle(fontSize: 14)
                                  //     onPressed: () {
                                  //       setState(() async {
                                  //         var requestId =
                                  //             products[index].get_requestId();
                                  //         var response =
                                  //             await postCompleteProduction(
                                  //                 requestId);
                                  //         print(response);

                                  //         if (response.containsKey('code')) {
                                  //           if (response['code'] == 200) {
                                  //             requestId =
                                  //                 response['request_id'];
                                  //             presscomplete = !presscomplete;
                                  //           } else {
                                  //             setState(() {
                                  //               print('Failed');
                                  //             });
                                  //           }
                                  //         }
                                  //         pressIncomplete = !pressIncomplete;
                                  //       });
                                  //     }),
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Navigator.pushNamed(
                                  //             context, storeKeeperHome);
                                  //       },
                                  //       child: Image(
                                  //           image: AssetImage(
                                  //               'assets/icons/note.png')),
                                  //     )
                                  //   ],
                                  // )
                                  Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Container(
                                          height: 17,
                                          width: 17,
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.pushNamed(
                                              //     context, storeKeeperHome);
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
}
