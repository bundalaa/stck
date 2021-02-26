import 'package:flutter/material.dart';

class ProductionDetails extends StatelessWidget {
  String name = "";
  String price = "";
  String quantity = "";
  String category = "";

  ProductionDetails(
      {Key key, this.name, this.price, this.quantity, this.category})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF00897B),
          title: Text(name.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              color: Colors.white,
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, top: 30, right: 15),
          child: Container(
            height: 360,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              border: Border.all(
                color: Colors.grey[350],
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 8),
                child: Container(
                  height: 100,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[800],
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text('CATEGORY NAME',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      Text(category,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  height: 100,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[800],
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text('QUANTITY',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    Text(quantity,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38))
                  ]),
                ),
              ),
              Container(
                height: 100,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[800],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text('PRICE',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  Text(price,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38)),
                ]),
              )
            ]),
          ),
        ));
  }
}
