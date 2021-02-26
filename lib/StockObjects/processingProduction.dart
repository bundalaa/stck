class ProcessingProduction {
  String _requestId;
  String _productName;
  String _productId;
  String _quantity;
  String _formulaId;
  String _total;
  String _status;
  String _registeredBy;

  String get_requestId() {
    return this._requestId;
  }

  void set_requestId(String _requestId) {
    this._requestId = _requestId;
  }

  String get_productName() {
    return this._productName;
  }

  void set_productName(String _productName) {
    this._productName = _productName;
  }

  String get_productId() {
    return this._productId;
  }

  void set_productId(String _productId) {
    this._productId = _productId;
  }

  String get_quantity() {
    return this._quantity;
  }

  void set_quantity(String _quantity) {
    this._quantity = _quantity;
  }

  String get_formulaId() {
    return this._formulaId;
  }

  void set_formulaId(String _formulaId) {
    this._formulaId = _formulaId;
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

  String get_registeredBy() {
    return this._registeredBy;
  }

  void set_registeredBy(String _registeredBy) {
    this._registeredBy = _registeredBy;
  }

  ProcessingProduction(
    this._requestId,
    this._productName,
    this._productId,
    this._registeredBy,
    this._formulaId,
    this._quantity,
    this._status,
    this._total,
  );
}
