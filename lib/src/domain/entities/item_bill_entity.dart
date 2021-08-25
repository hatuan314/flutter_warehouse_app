class ItemBillEntity {
  String name;
  int qty;
  int price;
  int totalPrice;

  ItemBillEntity({this.name, this.qty, this.price, this.totalPrice});

  factory ItemBillEntity.fromJson(Map<String, dynamic> json) => ItemBillEntity(
    name: json['name'],
    qty: json['qty'],
    price: json['price'],
    totalPrice: json['totalPrice'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'qty': qty,
    'price': price,
    'totalPrice': totalPrice
  };
}