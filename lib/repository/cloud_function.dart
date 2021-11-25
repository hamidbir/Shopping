import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_shoe/model/bag_model.dart';
import 'package:shopping_shoe/model/shoe.dart';

class CloudFunction {
  static final firebaseIns = FirebaseFirestore.instance;

  static final CollectionReference users = firebaseIns.collection('users');
  static final CollectionReference newProduct = firebaseIns.collection('shoes');

  Future<void> saveUser(String uid, String email, String username) async {
    Map<String, dynamic> user = {
      'uid': uid,
      'email': email,
      'username': username,
      'role': 'user',
    };
    await users.doc(uid).set(user);
  }

  Future<void> saveNewShoe(Map<String, dynamic> shoe, String uid) async {
    await newProduct.doc(uid).set(shoe);
  }

  Future<void> updateViewShoe(Map<String, dynamic> shoe, String uid) async {
    await newProduct.doc(uid).set(shoe);
  }

  Future<void> updateNumberBag(BagModel bag, String uid,
      {int updateNumber = -5}) async {
    await users
        .doc(uid)
        .collection('cart')
        .where('id', isEqualTo: bag.shoeId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        users.doc(uid).collection('cart').doc(element.id).update({
          "selectNumber": updateNumber == -5 ? bag.selectNumber : updateNumber
        });
      });
    });
  }

  Future<void> updateNumberShoe(String id, int updateValue) async {
    await newProduct.doc(id).update({"number": updateValue});
  }

  Future<int> paymentNumberBag(BagModel bag) async {
    int ret = -1;
    await newProduct.doc(bag.shoeId).get().then((value) {
      var res = value.get("number");
      print('res: $res');
      print('bag: ${bag.selectNumber}');
      if (res < bag.selectNumber) {
        if (res == 0) {
          print('res1: $res');
          ret = -3;
        } else {
          print('res2: $res');
          ret = res;
        }
      } else {
        int min = res - bag.selectNumber;
        print('min: $min');
        updateNumberShoe(bag.shoeId, min);
        print('res5: $res');
        ret = -2;
      }
    });
    return ret;
  }

  Future<List<QueryDocumentSnapshot>> getnewProducts() async {
    final res = await newProduct.get();

    return res.docs;
  }

  Future<DocumentSnapshot> getUserDetail(String uid) async {
    return await users.doc(uid).get();
  }

  // Future<List<QueryDocumentSnapshot>> getCategory(String inCategory) async {
  //   final QuerySnapshot docRefrence =
  //       await category.where('category', isEqualTo: inCategory).get();
  //   final res = await category
  //       .doc(docRefrence.docs[0]['id'])
  //       .collection('products')
  //       .get();

  //   return res.docs;
  // }
  Future<void> addToCart(String uid, Map<String, dynamic> productMap) async {
    await users.doc(uid).collection('cart').add(productMap);
  }

  Future<List<QueryDocumentSnapshot>> getFromCart(String uid) async {
    final res = await users.doc(uid).collection('cart').get();
    return res.docs;
  }

  Future<void> addToafavorites(
      Map<String, dynamic> productMap, String uid) async {
    await users.doc(uid).collection('favorites').add(productMap);
  }

  Future<void> delAsFavorites(Shoe shoe, String uid) async {
    await users
        .doc(uid)
        .collection('favorites')
        .where('id', isEqualTo: shoe.id)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        users
            .doc(uid)
            .collection('favorites')
            .doc(element.id)
            .delete()
            .then((value) => debugPrint('Success'));
      });
    });
  }

  Future<void> delAsCart(BagModel shoe, String uid) async {
    await users
        .doc(uid)
        .collection('cart')
        .where('id', isEqualTo: shoe.shoeId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        users
            .doc(uid)
            .collection('cart')
            .doc(element.id)
            .delete()
            .then((value) => debugPrint('Success'));
      });
    });
  }

  Future<List<QueryDocumentSnapshot>> getFromFavorites(String uid) async {
    final res = await users.doc(uid).collection('favorites').get();
    return res.docs;
  }
}
