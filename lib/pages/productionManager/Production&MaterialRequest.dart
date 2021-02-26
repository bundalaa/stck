import 'package:flutter/material.dart';

import 'package:stck/StockObjects/request.dart';

import 'package:stck/pages/api.dart';

class ProductionAndMaterialRequest extends StatefulWidget {
  Request request;
  String requestId;

  ProductionAndMaterialRequest(this.request, this.requestId);

  @override
  _ProductionAndMaterialRequestState createState() =>
      _ProductionAndMaterialRequestState();
}

class _ProductionAndMaterialRequestState
    extends State<ProductionAndMaterialRequest> {
  List<Request> requests;
  List materials;

  @override
  Widget build(BuildContext context) {
    List<RawMaterial> rawMaterials = widget.request.materials;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 170),
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: IconButton(
                  iconSize: 20,
                  color: Colors.white,
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              backgroundColor: Color(0xFF00897B),
              flexibleSpace: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text("PRODUCTION DETAILS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 15),
                        Expanded(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Product Name",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)))),
                        Expanded(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 60),
                                  child: Text(
                                      widget.request
                                          .get_productName()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ))),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Product Quantity",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)))),
                        Expanded(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                      widget.request
                                              .get_quantity()
                                              .toString()
                                              .toUpperCase() +
                                          'kg',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ))),
                      ])),
            )),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
              child: Container(
                height: 48,
                width: 100,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Color(0xFF00897B)),
                  ),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: Text(
                    rawMaterials[index].get_name(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          rawMaterials[index].get_quantity() +
                              'mls.....................................................',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: rawMaterials == null ? 0 : rawMaterials.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
              color: Color(0xFF00897B),
              child: FlatButton(
                onPressed: () async {
                  var requestId = widget.request.get_request_id();
                  var response = await postProductionMaterialRequest(requestId);
                  print(response);

                  if (response.containsKey('code')) {
                    if (response['code'] == 200) {
                      requestId = response['request_id'];

                      showSuccessDialog();
                    } else {
                      setState(() {
                        print('Failed');
                      });
                    }
                  }
                },
                child: Text(
                  'REQUEST MATERIALS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
            // Container(
            //   width: 1,
            //   height: 3,
            //   color: Colors.grey,
            // ),
            // Expanded(
            //     child: Container(
            //   color: Color(0xFF00897B),
            //   child: FlatButton(
            //     onPressed: () async {
            //       var requestId = widget.request.get_request_id();
            //       var response = await postProductionRequest(requestId);
            //       print(response);

            //       if (response.containsKey('code')) {
            //         if (response['code'] == 200) {
            //           requestId = response['request_id'];

            //           showSuccessDialog();
            //         } else {
            //           setState(() {
            //             print('Failed');
            //           });
            //         }
            //       }
            //     },
            //     child: Text(
            //       'START PROCESS',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 10,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // )),
          ],
        )));
  }

  Future<void> showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Request sent',
                    style: TextStyle(color: Color(0xFF00897B), fontSize: 20),
                  ),
                )),
                SizedBox(height: 20),
                Icon(
                  Icons.check_box,
                  size: 50,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Card(
                child: Container(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: Text(
                        'OK',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
