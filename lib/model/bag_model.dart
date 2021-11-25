class BagModel {
  final String shoeId;
  final String shoeName;
  final String shoeColor;
  final String shoeSize;
  final String shoeImg;
  int selectNumber;

  //-------------
  String shoePrice;

  BagModel(
      {required this.shoeId,
      required this.shoeName,
      required this.shoeColor,
      required this.shoeSize,
      required this.shoeImg,
      required this.selectNumber,
      required this.shoePrice});

  factory BagModel.fromMap(var map) {
    return BagModel(
        shoeId: map['id'],
        shoeName: map['name'],
        shoeColor: map['color'],
        shoeSize: map['size'],
        shoeImg: map['image'],
        selectNumber: map['selectNumber'],
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
      'selectNumber': selectNumber
    };
  }
}
