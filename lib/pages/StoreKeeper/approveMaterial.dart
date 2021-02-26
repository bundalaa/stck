import 'package:flutter/material.dart';
import 'package:stck/StockObjects/materialRequest.dart';

import 'package:stck/StockObjects/request.dart';

import 'package:stck/pages/api.dart';

class ApprovedMaterialRequest extends StatefulWidget {
  MaterialRequest materialrequest;
  String id;

  ApprovedMaterialRequest(this.materialrequest, this.id);

  @override
  _ApprovedMaterialRequestState createState() =>
      _ApprovedMaterialRequestState();
}

class _ApprovedMaterialRequestState extends State<ApprovedMaterialRequest> {
  List<MaterialRequest> materialrequest;
  List materials;

  @override
  Widget build(BuildContext context) {
    List<RMaterial> rawMaterials = widget.materialrequest.materials;
    return Scaffold(
        appBar: AppBar(
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
                    Text("APPROVE MATERIALS",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 15,
                    ),
                  ])),
        ),
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
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              rawMaterials[index].get_quantity() +
                                  'mls......................................................',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
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
                  var id = widget.materialrequest.get_id();
                  var response = await postProductionMaterialRequest(id);
                  print(response);

                  if (response.containsKey('code')) {
                    if (response['code'] == 200) {
                      id = response['id'];

                      showSuccessDialog();
                    } else {
                      setState(() {
                        print('Failed');
                      });
                    }
                  }
                },
                child: Text(
                  'APPROVE MATERIALS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
            Container(
              width: 1,
              height: 3,
              color: Colors.grey,
            ),
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
                    'Materials approved',
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
