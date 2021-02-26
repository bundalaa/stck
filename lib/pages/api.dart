import 'package:http/http.dart' as http;
import 'package:stck/pages/productionManager/productionManagerHome.dart';
import 'dart:convert';
import 'package:stck/pages/signIn/sign_in.dart';

Future<Map<String, dynamic>> loginUser(
    String phonenumber, String password) async {
  String url =
      "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api/";
  final response = await http.post(url,
      headers: {"accept": "application/json"},
      body: json.encode({
        "api": "100",
        "code": "102",
        "data": {"phone_number": phonenumber, "password": password}
      }));
  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}

//post prdctin request
// Future postProductionRequest(String requestId) async {
//   final response = await http.post(
//     "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api",
//     headers: {
//       "Content-Type": "application/json",
//     },
//     body: json.encode({
//       "code": "103",
//       "api": "140",
//       "user_id": userId,
//       "data": {"request_id": requestId}
//     }),
//   );

//   var convertedDatatoJson = jsonDecode(response.body);
//   return convertedDatatoJson;
// }

//post prdctin material request
Future postProductionMaterialRequest(String id) async {
  final response = await http.post(
    "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api",
    headers: {
      "Content-Type": "application/json",
    },
    body: json.encode({
      "code": "106",
      "api": "140",
      "user_id": userId,
      "data": {"id": id}
    }),
  );

  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}

//post complete production
Future postCompleteProduction(String requestId) async {
  final response = await http.post(
    "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api",
    headers: {
      "Content-Type": "application/json",
    },
    body: json.encode({
      "code": "107",
      "api": "140",
      "user_id": userId,
      "data": {"request_id": requestId}
    }),
  );

  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}

//post complete purchase note
Future postCompletePurchasenote(String id) async {
  final response = await http.post(
    "http://ec2-13-58-137-105.us-east-2.compute.amazonaws.com/GraceProduction/index.php/Api",
    headers: {
      "Content-Type": "application/json",
    },
    body: json.encode({
      "code": "109",
      "api": "100",
      "user_id": userId,
      "data": {"request_id": requestId}
    }),
  );

  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}
