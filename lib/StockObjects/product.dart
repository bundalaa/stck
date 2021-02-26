class Product {
  String productId;
  String name;
  String price;
  String category;
  String quantity;
  String formulaId;
  String formulaStatus;
  String status;
  String registeredBy;

  String getProductId() {
    return this.productId;
  }

  void setProductId(String productId) {
    this.productId = productId;
  }

  String getName() {
    return this.name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getPrice() {
    return this.price;
  }

  void setPrice(String price) {
    this.price = price;
  }

  String getCategory() {
    return this.category;
  }

  void setCategory(String category) {
    this.category = category;
  }

  String getQuantity() {
    return this.quantity;
  }

  void setQuantity(String quantity) {
    this.quantity = quantity;
  }

  String getFormulaId() {
    return this.formulaId;
  }

  void setFormulaId(String formulaId) {
    this.formulaId = formulaId;
  }

  String getFormulaStatus() {
    return this.formulaStatus;
  }

  void setFormulaStatus(String formulaStatus) {
    this.formulaStatus = formulaStatus;
  }

  String getStatus() {
    return this.status;
  }

  void setStatus(String status) {
    this.status = status;
  }

  String getRegisteredBy() {
    return this.registeredBy;
  }

  void setRegisteredBy(String registeredBy) {
    this.registeredBy = registeredBy;
  }

  Product(this.productId, this.formulaId, this.formulaStatus, this.category,
      this.name, this.price, this.quantity, this.status, this.registeredBy);
}
