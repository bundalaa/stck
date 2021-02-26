class MaterialObject {
  String materialId;
  String name;
  String price;
  String package;
  String quantity;
  String status;
  String registeredBy;

  String getMaterialId() {
    return this.materialId;
  }

  void setMaterialId(String materialId) {
    this.materialId = materialId;
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

  String getPackage() {
    return this.package;
  }

  void setPackage(String package) {
    this.package = package;
  }

  String getQuantity() {
    return this.quantity;
  }

  void setQuantity(String quantity) {
    this.quantity = quantity;
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

  MaterialObject(this.materialId, this.name, this.price, this.package,
      this.quantity, this.status, this.registeredBy);
}
