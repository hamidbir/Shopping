import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shopping_shoe/utils/map_function.dart';

class Shoe {
  final String id;
  final String name;

  final List<String> category;
  final List<String> imageURL;
  final String price;
  final List<String> colors;
  final List<String> size;
  final String description;
  //-------------------------------
  int view;
  int number;
  var isFav = 'Idle'.obs;

  Shoe({
    required this.id,
    required this.name,
    required this.category,
    required this.imageURL,
    required this.price,
    required this.colors,
    required this.size,
    required this.description,
    this.view = 0,
    this.number = 0,
  });
  factory Shoe.fromMap(/*Map<String, dynamic>*/ var map) {
    return Shoe(
        id: map['id'],
        name: map['name'],
        category: listFromMap(map['category']),
        imageURL: listFromMap(map['imageURL']),
        price: map['price'],
        colors: listFromMap(map['colors']),
        size: listFromMap(map['size']),
        description: map['description'],
        view: map['view'],
        number: map['number']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': listToMap(category),
      'imageURL': listToMap(imageURL),
      'price': price,
      'colors': listToMap(colors),
      'size': listToMap(size),
      'description': description,
      'view': view,
      'number': number,
    };
  }
}
