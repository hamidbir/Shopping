import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shopping_shoe/utils/map_function.dart';

class Shoe {
  final String id;
  final String name;
//  final String brand;

  final List<String> category;
  final List<String> imageURL;
  final String price;
  final List<String> colors;
  final List<String> size;
  final String description;
  var isFav = 'Idle'.obs;
  //final double rating;

  Shoe({
    required this.id,
    required this.name,
    //    required this.brand,
    required this.category,
    required this.imageURL,
    required this.price,
    required this.colors,
    required this.size,
    required this.description,
    //required this.rating
  });
  factory Shoe.fromMap(/*Map<String, dynamic>*/ var map) {
    return Shoe(
      id: map['id'],
      name: map['name'],
      //  brand: map['brand'],
      category: listFromMap(map['category']),
      imageURL: listFromMap(map['imageURL']),
      price: map['price'],
      colors: listFromMap(map['colors']),
      size: listFromMap(map['size']),
      description: map['description'],
      //rating: map['rating'].toDouble(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      //'brand': brand,
      'category': listToMap(category),
      'imageURL': listToMap(imageURL),
      'price': price,
      'colors': listToMap(colors),
      'size': listToMap(size),
      'description': description,
      //'rating': rating,
    };
  }
}
