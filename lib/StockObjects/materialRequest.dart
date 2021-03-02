class MaterialRequest {
  String _id;
  String _request_id;
  String _name;
  String _registered;
  String _status;
  List materials;

  String get_id() {
    return this._id;
  }

  void set_id(String _id) {
    this._id = _id;
  }

  String get_request_id() {
    return this._request_id;
  }

  void set_request_id(String _request_id) {
    this._request_id = _request_id;
  }

  String get_name() {
    return this._name;
  }

  void set_name(String _name) {
    this._name = _name;
  }

  String get_registered() {
    return this._registered;
  }

  void set_registered(String _registered) {
    this._registered = _registered;
  }

  String get_status() {
    return this._status;
  }

  void set_status(String _status) {
    this._status = _status;
  }

  List getMaterials() {
    return this.materials;
  }

  void setMaterials(List materials) {
    this.materials = materials;
  }

  MaterialRequest(this._id, this._name, this._request_id, this._status,
      this._registered, this.materials);
}

class RMaterial {
  String _table_id;
  String _material_id;
  String _name;
  String _quantity;
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

  RMaterial(this._material_id, this._table_id, this._name, this._quantity,
      this._package, this._formula_id, this._price);
}
