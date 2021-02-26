import 'package:flutter/material.dart';

class PurchaseNote {
  String requestId;
  String total;
  String status;
  String registeredBy;
  List<RawMat> materials = [];

  PurchaseNote(
      {@required this.requestId,
      @required this.total,
      @required this.status,
      @required this.registeredBy,
      @required this.materials});

  static PurchaseNote fromMap(Map<String, dynamic> purchaseMap) {
    List<RawMat> materials = [];

    purchaseMap['materials'].forEach((material) {
      materials.add(RawMat.fromMap(material));
    });

    return PurchaseNote(
        requestId: purchaseMap['request_id'],
        registeredBy: purchaseMap['reqistered_by'],
        status: purchaseMap['status'],
        total: purchaseMap['total'],
        materials: []);
  }
}

class RawMat {
  String requestId;
  String materialId;
  String price;
  String quantity;
  String total;
  String status;
  String name;

  RawMat(
      {@required this.requestId,
      @required this.materialId,
      @required this.price,
      @required this.quantity,
      @required this.total,
      @required this.status,
      @required this.name});

  static RawMat fromMap(Map<String, dynamic> materialMap) {
    return RawMat(
        requestId: materialMap['request_id'],
        materialId: materialMap['material_id'],
        price: materialMap['price'],
        quantity: materialMap['quantity'],
        total: materialMap['total'],
        status: materialMap['status'],
        name: materialMap['name'] ?? "Unkown");
  }
}
