import 'package:flutter/material.dart';
import 'package:stck/pages/StoreKeeper/storeKeeperHome.dart';
import 'package:stck/pages/productionManager/productionManagerHome.dart';
import 'package:stck/pages/sales/salesHome.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Drawer(
          child: Column(
        children: <Widget>[
          // MediaQuery.removePadding(

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView(
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.pink,
                      ),
                      title: Text(
                        'Production manager',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return HomePage();
                        }));
                      }),
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.pink,
                      ),
                      title: Text('StoreKeeper',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return StoreHomePage();
                        }));
                      }),
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.pink,
                      ),
                      title: Text('Sales',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return SALESHOME();
                        }));
                      }),
                  Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          // removeTop: true,
          // context: context,
          // ),
        ],
      )),
    );
  }
}
