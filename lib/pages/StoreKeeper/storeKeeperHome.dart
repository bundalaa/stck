import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stck/StockObjects/PurchaseNote.dart';
import 'package:stck/StockObjects/materialRequest.dart';
import 'package:stck/StockObjects/request.dart';
import 'package:stck/jsonExtraction.dart';
import 'package:stck/pages/StoreKeeper/approveMaterial.dart';
import 'package:stck/pages/StoreKeeper/purchaseSummary.dart';
import 'package:stck/pages/signIn/sign_in.dart';
import 'package:stck/provider/purchaseProvider.dart';
import 'package:stck/provider/rawMaterialProvider.dart';
import 'package:http/http.dart' as http;
import 'package:stck/pages/StoreKeeper/SearchMaterial.dart';
import 'package:stck/pages/StoreKeeper/productionDetails.dart';
import 'dart:convert';

String id;

class StoreHomePage extends StatefulWidget {
  Request request;

  @override
  _StoreHomePageState createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  int _n = 0;
  // List data;
  List productdata;
  int _value = 1;
  // List<Request> requests;
  List<MaterialRequest> materialrequests;
  List materials;

  final String url =
      "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api";
  //fn to increase number size
  void add() {
    setState(() {
      _n++;
    });
  }

//fn to decrease number size
  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  //get prdctin material request
  Future getMaterialRequest() async {
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
        materialrequests =
            JsonExtraction().extractMaterialRequestFromJson(serverResponse);
      });
      debugPrint(materialrequests.toString());
      debugPrint(materials.toString());
    }
  }

//get products frm stre
  Future getJsonData() async {
    final response = await http.post(url, headers: {
      'accept': 'application/json'
    }, body: {
      "code": "102",
      "api": "130",
      "user_id": userId,
      // "data":{"request_id":"f5f6ecc5f712b7646bd58bd309b044df"}
    });

    debugPrint(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      productdata = convertDataToJson['products'];
    });
    debugPrint(productdata.toString());
  }

  @override
  void initState() {
    super.initState();
    getJsonData();
    getMaterialRequest();
  }

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = Provider.of<PurchaseProvider>(context);
    final rawMaterialProvider = Provider.of<RawMaterialProvider>(context);
    // List<RawMaterial> rawMaterials = widget.request.materials;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFF00897B),
              title: Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'STORE',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ]),
              actions: [
                Row(
                  children: [
                    IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchMaterial()));
                        }),
                    nomalPopMenu()
                  ],
                )
              ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    text: 'PRODUCTS',
                  ),
                  Tab(
                    text: 'MATERIALS',
                  ),
                  Tab(
                    text: 'REQUESTS',
                  ),
                ],
              )),
          body: TabBarView(children: [
            Expanded(
              child: SizedBox(
                height: 200,
                child: RefreshIndicator(
                  onRefresh: getJsonData,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 5, right: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductionDetails(
                                      category: productdata[index]['category'],
                                      name: productdata[index]['name'],
                                      quantity: productdata[index]['quantity'],
                                      price: productdata[index]['price'],
                                    )));
                          },
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
                              title: Row(
                                children: [
                                  Text(
                                    'Product Name:  ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    productdata[index]['name'],
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              subtitle: Row(children: [
                                Text(
                                  'Category:  ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  productdata[index]['category'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: productdata == null ? 0 : productdata.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                  ),
                ),
              ),
            ),
            (Container(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                    child: Card(
                      child: Container(
                        height: 60,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF00897B),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              alertDialog(context,
                                  rawMaterialProvider.rawMaterials[index],
                                  purchaseProvider: purchaseProvider);
                            });
                          },
                          title: Row(
                            children: [
                              Text(
                                'name: ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                rawMaterialProvider.rawMaterials[index].name,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          subtitle: Row(children: [
                            Text(
                              'Quantity: ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              rawMaterialProvider.rawMaterials[index].quantity,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: rawMaterialProvider.rawMaterials.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            )),
            (Container(
              child: RefreshIndicator(
                onRefresh: getMaterialRequest,
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 5, right: 5),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ApprovedMaterialRequest(
                                      materialrequests[index], id)));
                            },
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
                                leading: Icon(Icons.notification_important,
                                    color: Colors.black),
                                title: Text(
                                  materialrequests[index].get_name(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  materialrequests[index].get_status(),
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold),
                                ),
                                //
                              ),
                            )));
                  },
                  itemCount:
                      materialrequests == null ? 0 : materialrequests.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                ),
              ),
            ))
          ]),
          // bottomNavigationBar: BottomAppBar(
          //     child: Container(
          //   color: Color(0xFF00897B),
          //   child: FlatButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (BuildContext context) =>
          //                   PurchaseSummary()));
          //     },
          //     child: Icon(Icons.arrow_forward_ios,
          //         size: 30, color: Colors.white),
          //   ),
          // )
          // )
        ));
  }

  //  Dialog of fill quantity
  alertDialog(BuildContext context, RawMat rawMaterial,
      {@required PurchaseProvider purchaseProvider}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return ListView(shrinkWrap: true, children: [
                Center(
                  child: Text(
                    rawMaterial.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.red,
                        ),
                        height: 40,
                        width: 55,
                        child: new FlatButton(
                          onPressed: () {
                            setState(() {
                              if (_n != 0) _n--;
                            });
                          },
                          child: new Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      new Text('$_n.0',
                          style: new TextStyle(
                              fontSize: 40.0, color: Colors.grey)),
                      Container(
                        height: 40,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.green,
                        ),
                        child: new FlatButton(
                          onPressed: () {
                            setState(() {
                              _n++;
                            });
                          },
                          child: new Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ]),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 4),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 88,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.grey[400],
                        ),
                        child: FlatButton(
                          child: new Text(
                            "CANCEL",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          height: 40,
                          width: 88,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.grey[400],
                          ),
                          child: FlatButton(
                            child: new Text(
                              "SAVE",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              String materialId = rawMaterial.materialId;
                              int quantity = _n;

                              var response = await purchaseProvider
                                  .postQuantity(materialId, quantity);
                              print(response);

                              if (response['success']) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PurchaseSummary()));
                              } else {
                                print(response['message']);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]);
            }),
          );
        });
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
                    Icons.logout,
                    color: Colors.black,
                    size: 10,
                  ),
                ),
                Text('log out', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            )),
      ],
      onSelected: (int value) {
        switch (value) {
          case 1:
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
