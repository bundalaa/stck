class Request {
  String request_id;
  String _productName;
  String _product_Id;
  String _quantity;
  String _formula_id;
  String _total;
  String _status;
  String _registered;
  List materials;

  String get_productName() {
    return this._productName;
  }

  void set_productName(String _productName) {
    this._productName = _productName;
  }

  String get_product_Id() {
    return this._product_Id;
  }

  void set_product_Id(String _product_Id) {
    this._product_Id = _product_Id;
  }

  String get_quantity() {
    return this._quantity;
  }

  void set_quantity(String _quantity) {
    this._quantity = _quantity;
  }

  String get_request_id() {
    return this.request_id;
  }

  void set_request_id(String _request_id) {
    this.request_id = _request_id;
  }

  String get_formula_id() {
    return this._formula_id;
  }

  void set_formula_id(String _formula_id) {
    this._formula_id = _formula_id;
  }

  String get_total() {
    return this._total;
  }

  void set_total(String _total) {
    this._total = _total;
  }

  String get_status() {
    return this._status;
  }

  void set_status(String _status) {
    this._status = _status;
  }

  String get_registered() {
    return this._registered;
  }

  void set_registered(String _registered) {
    this._registered = _registered;
  }

  List getMaterials() {
    return this.materials;
  }

  void setMaterials(List materials) {
    this.materials = materials;
  }

  Request(
      this.request_id,
      this._productName,
      this._product_Id,
      this._registered,
      this._formula_id,
      this._quantity,
      this._status,
      this._total,
      this.materials);
}

class RawMaterial {
  String _material_id;
  String _name;
  String _quantity;
  String _table_id;
  String _package;
  String _formula_id;
  String _price;

  String get_material_id() {
    return this._material_id;
  }

  void set_material_id(String _material_id) {
    this._material_id = _material_id;
  }

  String get_name() {
    return this._name;
  }

  void set_name(String _name) {
    this._name = _name;
  }

  String get_quantity() {
    return this._quantity;
  }

  void set_quantity(String _quantity) {
    this._quantity = _quantity;
  }

  String get_table_id() {
    return this._table_id;
  }

  void set_table_id(String _table_id) {
    this._table_id = _table_id;
  }

  String get_package() {
    return this._package;
  }

  void set_package(String _package) {
    this._package = _package;
  }

  String get_formula_id() {
    return this._formula_id;
  }

  void set_formula_id(String _formula_id) {
    this._formula_id = _formula_id;
  }

  String get_price() {
    return this._price;
  }

  void set_price(String _price) {
    this._price = _price;
  }

  RawMaterial(this._material_id, this._name, this._quantity, this._table_id,
      this._package, this._formula_id, this._price);
}
