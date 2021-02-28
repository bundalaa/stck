import 'package:flutter/material.dart';
import 'package:stck/StockObjects/materialRequest.dart';

class ViewMaterialsSent extends StatefulWidget {
  MaterialRequest materialrequest;
  String id;

  ViewMaterialsSent(this.materialrequest, this.id);

  @override
  _ViewMaterialsSentState createState() => _ViewMaterialsSentState();
}

class _ViewMaterialsSentState extends State<ViewMaterialsSent> {
  MaterialRequest materialrequests;
  List materials;

  @override
  Widget build(BuildContext context) {
    List<RMaterial> rawMaterials = widget.materialrequest.materials;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 20,
          color: Colors.white,
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF00897B),
        title: Text(widget.materialrequest.get_name().toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
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
    );
  }
}
