import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stck/provider/purchaseProvider.dart';

class PurchaseSummary extends StatefulWidget {
  PurchaseSummary();

  @override
  _PurchaseSummaryState createState() => _PurchaseSummaryState();
}

class _PurchaseSummaryState extends State<PurchaseSummary> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = Provider.of<PurchaseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF00897B),
        leading: IconButton(
          iconSize: 20,
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text(
              'Purchase Summary',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 10),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
              child: Text('PRODUCT LISTS',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 253),
                    child: Text(
                        purchaseProvider.purchases.last.materials[index].name,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                            purchaseProvider
                                    .purchases.last.materials[index].quantity +
                                'x' +
                                purchaseProvider
                                    .purchases.last.materials[index].price,
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                            purchaseProvider
                                .purchases.last.materials[index].total,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              );
            },
            itemCount: purchaseProvider.purchases.last.materials.length,
          ),
          SizedBox(height: 200),
          Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text('TOTAL:',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(getTotal(purchaseProvider) + '/=',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    ),
                  ])),
        ],
      ),
    );
  }

  String getTotal(PurchaseProvider purchaseProvider) {
    int total = 0;
    purchaseProvider.purchases.last.materials.forEach((material) {
      total = total + int.parse(material.total);
    });
    return "$total";
  }
}
