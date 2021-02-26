import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stck/pages/StoreKeeper/purchaseSummary.dart';

class SearchMaterial extends StatefulWidget {
  @override
  _SearchMaterialState createState() => _SearchMaterialState();
}

class _SearchMaterialState extends State<SearchMaterial> {
  TextEditingController _textController = TextEditingController();
  bool isSearching = false;
  List data;
  List dataDisplay;
  int _n = 0;
  final String url =
      "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api";

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

//get raw materials
  Future getData() async {
    final response = await http.post(url, headers: {
      'accept': 'application/json'
    }, body: {
      "code": "102",
      "api": "120",
      "user_id": "6f27e9c8c5bfc27db203dbb928d07334"
    });

    debugPrint(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['products'];
    });
    debugPrint(data.toString());
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        data.addAll(value);
        dataDisplay = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00897B),
        // actions: [
        //           IconButton(
        //                   color: Colors.white,
        //                   icon: Icon(Icons.cancel),
        //                    onPressed: () { }
        //                 )

        //         ],
        title: TextField(
          style: TextStyle(color: Colors.white),
          onChanged: (name) {
            name = name.toLowerCase();
            setState(() {
              dataDisplay = data.where((products) {
                var dataDiplay = products.name.toLowerCase();
                return dataDiplay.contains(name);
              }).toList();
            });
          },
          controller: _textController,
          decoration: InputDecoration(
              hintText: "Search raw material...",
              hintStyle: TextStyle(color: Colors.white)
              // enabledBorder:UnderlineInputBorder(borderSide:BorderSide(color: Color(0xFF00897B)) )
              ),
        ),
      ),
      body: ListView.separated(
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
                    // setState(() {
                    alertDialog(
                      context,
                    );
                    // });
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => alertDialog(
                    //       // String  str: data[index]['name']
                    //         )));
                    //         // )
                    //         // )
                  },
                  title: Row(
                    children: [
                      Text(
                        'name: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dataDisplay[index]['name'],
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dataDisplay[index]['quantity'],
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
        itemCount: dataDisplay == null ? 0 : dataDisplay.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }

  alertDialog(BuildContext context) {
    //  String str = "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  'p',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => PurchaseSummary()));
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
}
