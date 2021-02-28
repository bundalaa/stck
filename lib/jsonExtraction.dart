import 'dart:convert';
import 'package:stck/StockObjects/RawMaterial.dart';
import 'package:stck/StockObjects/materialRequest.dart';
import 'package:stck/StockObjects/processingProduction.dart';
import 'package:stck/StockObjects/product.dart';
import 'package:stck/StockObjects/request.dart';

class JsonExtraction {
  List<Request> extractProductFromJson(String jsonString) {
    List<Request> requests = [];
    var resBody = jsonDecode(jsonString);
    List requestArray = resBody['requests'];
    for (int i = 0; i < requestArray.length; i++) {
      var request = requestArray[i];

      List<RawMaterial> materials = [];
      List materialArray = request['materials'];
      for (int y = 0; y < materialArray.length; y++) {
        var material = materialArray[y];

        materials.add(new RawMaterial(
            material['material_id'],
            material['name'],
            material['quantity'],
            material['table_id'],
            material['package'],
            material['formula_id'],
            material['price']));
      }

      DateTime registered = DateTime.parse(request['registered']);
      Duration duration = DateTime.now().difference(registered);

      requests.add(new Request(
          request['request_id'],
          request['product_name'],
          request['product_id'],
          "${duration.inMinutes} mins ago",
          request['formula_id'],
          request['quantity'],
          request['status'],
          request['total'],
          materials));
    }
    return requests;
  }

  List<MaterialObject> extractMaterialFromJson(String jsonString) {
    List<MaterialObject> materials = [];
    var resBody = jsonDecode(jsonString);
    List requestArray = resBody['products'];
    for (int i = 0; i < requestArray.length; i++) {
      var material = requestArray[i];

      materials.add(new MaterialObject(
          material['material_id'],
          material['name'],
          material['price'],
          material['package'],
          material['quantity'],
          material['status'],
          material['registeredBy']));
    }
    return materials;
  }

  List<ProcessingProduction> extractProcessedProductFromJson(
      String jsonString) {
    List<ProcessingProduction> products = [];
    var resBody = jsonDecode(jsonString);
    List requestArray = resBody['requests'];
    for (int i = 0; i < requestArray.length; i++) {
      var processedData = requestArray[i];

      products.add(new ProcessingProduction(
          processedData['request_id'],
          processedData['product_name'],
          processedData['product_id'],
          processedData['reqistered_by'],
          processedData['formula_id'],
          processedData['quantity'],
          processedData['status'],
          processedData['total']));
    }
    return products;
  }

  List<MaterialRequest> extractMaterialRequestFromJson(String jsonString) {
    List<MaterialRequest> materialrequests = [];
    var resBody = jsonDecode(jsonString);
    List requestArray = resBody['requests'];
    for (int i = 0; i < requestArray.length; i++) {
      var materialrequest = requestArray[i];

      List<RMaterial> materials = [];
      List materialArray = materialrequest['materials'];
      for (int y = 0; y < materialArray.length; y++) {
        var material = materialArray[y];

        materials.add(new RMaterial(
            material['material_id'],
            material['table_id'],
            material['name'],
            material['quantity'],
            material['package'],
            material['formula_id'],
            material['price']));
      }

      materialrequests.add(new MaterialRequest(
          materialrequest['id'],
          materialrequest['name'],
          materialrequest['request_id'],
          materialrequest['status'],
          materials));
    }
    return materialrequests;
  }

  List<Product> extractProductStoreFromJson(String jsonString) {
    List<Product> products = [];
    var resBody = jsonDecode(jsonString);
    List requestArray = resBody['products'];
    for (int i = 0; i < requestArray.length; i++) {
      var product = requestArray[i];

      products.add(new Product(
          product['product_id'],
          product['formulaId'],
          product['formulaStatus'],
          product['category'],
          product['name'],
          product['price'],
          product['quantity'],
          product['status'],
          product['registeredBy']));
    }
    return products;
  }
}
