class BagModel {
  final String shoeId;
  final String shoeName;
  final String shoeColor;
  final String shoeSize;
  final String shoeImg;

  //-------------
  final String shoePrice;

  BagModel(
      {required this.shoeId,
      required this.shoeName,
      required this.shoeColor,
      required this.shoeSize,
      required this.shoeImg,
      required this.shoePrice});

  factory BagModel.fromMap(var map) {
    return BagModel(
        shoeId: map['id'],
        shoeName: map['name'],
        shoeColor: map['color'],
        shoeSize: map['size'],
        shoeImg: map['image'],
        //shoeQuantity: map['id'],
        shoePrice: map['price']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': shoeId,
      'name': shoeName,
      'price': shoePrice,
      'color': shoeColor,
      'size': shoeSize,
      'image': shoeImg,
    };
  }
}
