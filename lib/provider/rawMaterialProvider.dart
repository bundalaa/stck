import 'package:flutter/foundation.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stck/StockObjects/PurchaseNote.dart';
import 'package:stck/pages/signIn/sign_in.dart';

class RawMaterialProvider with ChangeNotifier {
  RawMaterialProvider() {
    getData();
  }

  List<RawMat> rawMaterials = [];
  final String url =
      "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api";

//get raw materials
  Future getData() async {
    final response = await http.post(url,
        headers: {'accept': 'application/json'},
        body: {"code": "102", "api": "120", "user_id": userId});

    debugPrint(response.body);
    String serverResponse = response.body;
    var resbody = jsonDecode(serverResponse);
    int code = resbody['code'];
    if (code == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      rawMaterials.clear();
      responseMap['products'].forEach((rawMaterial) {
        rawMaterials.add(RawMat.fromMap(rawMaterial));
      });
      notifyListeners();
    }
    debugPrint(rawMaterials.toString());
  }

  // //get raw materials sent
  // Future getMaterialSent() async {
  //   final response = await http.post(url,
  //       headers: {'accept': 'application/json'},
  //       body: {"code": "110", "api": "140", "user_id": userId});

  //   debugPrint(response.body);
  //   String serverResponse = response.body;
  //   var resbody = jsonDecode(serverResponse);
  //   int code = resbody['code'];
  //   if (code == 200) {
  //     Map<String, dynamic> responseMap = jsonDecode(response.body);
  //     rawMaterials.clear();
  //     responseMap['requests'].forEach((rawMaterial) {
  //       rawMaterials.add(RawMat.fromMap(rawMaterial));
  //     });
  //     notifyListeners();
  //   }
  //   debugPrint(rawMaterials.toString());
  // }
}
