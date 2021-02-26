import 'package:flutter/material.dart';
import 'package:stck/constants/constants.dart';
import 'package:stck/drawer.dart';
import 'package:stck/pages/productionManager/productionManagerHome.dart';
import 'package:stck/pages/StoreKeeper/storeKeeperHome.dart';
import 'package:stck/pages/signIn/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:stck/provider/purchaseProvider.dart';
import 'package:stck/provider/rawMaterialProvider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => PurchaseProvider()),
    ChangeNotifierProvider(create: (_) => RawMaterialProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (BuildContext context) => Login(),
        login: (BuildContext context) => Login(),
        productionManagerhomePage: (BuildContext context) => HomePage(),
        storeKeeperHome: (BuildContext context) => StoreHomePage(),
        drawer: (BuildContext context) => DrawerPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ), // home: Login(),
    );
  }
}
