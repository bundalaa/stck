import 'package:flutter/foundation.dart';
import 'package:stck/StockObjects/PurchaseNote.dart';
import 'dart:convert';
import 'package:stck/pages/signIn/sign_in.dart';
import 'package:http/http.dart' as http;

class PurchaseProvider with ChangeNotifier {
  final List<PurchaseNote> purchases = [];

  final String url =
      "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api";

  //get purchase note
  Future getPurchase() async {
    final response = await http.post(url,
        headers: {'accept': 'application/json'},
        body: {"code": "106", "api": "120", "user_id": userId});

    debugPrint(response.body);
    String serverResponse = response.body;
    var resbody = jsonDecode(serverResponse);
    int code = resbody['code'];
    if (code == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      purchases.clear();
      responseMap['data'].forEach((purchaseMap) {
        purchases.add(PurchaseNote.fromMap(purchaseMap));
      });
      notifyListeners();
      debugPrint(purchases.toString());
    }
  }

  //post quantity
  Future<Map<String, dynamic>> postQuantity(
      String materialId, int quantity) async {
    final response = await http.post(url,
        headers: {'accept': 'application/json'},
        body: jsonEncode({
          "code": "105",
          "api": "120",
          "user_id": userId,
          "data": {
            'registered_by': userId,
            "materials": [
              {"material_id": materialId, "quantity": quantity},
            ]
          }
        }));

    bool success = false;
    String message = '';
    String responseBody = response.body;
    responseBody = responseBody.replaceAll('"material":[', '"materials":[');
    debugPrint("WWWWWWWWWWWWWWWWWW: " + responseBody);
    Map<String, dynamic> responseMap = jsonDecode(responseBody);
    if (responseMap.containsKey('code')) {
      if (responseMap['code'] == 200) {
        success = true;
        message = responseMap['msg'];

        purchases.add(PurchaseNote.fromMap(responseMap['data']));

        notifyListeners();
      } else {
        success = false;
        message = 'Something went wrong';
      }
    } else {
      success = false;
      message = "Something went wrong";
    }
    return {'success': success, 'message': message};
  }
}
