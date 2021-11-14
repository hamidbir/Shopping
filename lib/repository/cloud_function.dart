import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/utils/storage.dart';

class CloudFunction {
  static final firebaseIns = FirebaseFirestore.instance;

  static final CollectionReference users = firebaseIns.collection('users');
  static final CollectionReference category =
      firebaseIns.collection('category');
  static final CollectionReference newProduct = firebaseIns.collection('shoes');
  static final CollectionReference trending =
      firebaseIns.collection('trending');
  static final CollectionReference banners = firebaseIns.collection('banners');

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

  Future<List<QueryDocumentSnapshot>> getnewProducts() async {
    final res = await newProduct.get();

    return res.docs;
  }

  Future<DocumentSnapshot> getUserDetail(String uid) async {
    return await users.doc(uid).get();
  }

  Future<List<QueryDocumentSnapshot>> getCategory(String inCategory) async {
    final QuerySnapshot docRefrence =
        await category.where('category', isEqualTo: inCategory).get();
    final res = await category
        .doc(docRefrence.docs[0]['id'])
        .collection('products')
        .get();

    return res.docs;
  }

  Future<List<QueryDocumentSnapshot>> getTrend() async {
    final res = await trending.get();
    return res.docs;
  }

  Future<void> addToCart(String uid, Map<String, dynamic> productMap) async {
    await users.doc(uid).collection('cart').add(productMap);
  }

  Future<List<QueryDocumentSnapshot>> getFromCart(String uid) async {
    final res = await users.doc(uid).collection('cart').get();
    return res.docs;
  }

  Future<void> addToafavorites(
      Map<String, dynamic> productMap, String uid) async {
    //final uid = Storage().getUid();
    await users.doc(uid).collection('favorites').add(productMap);
  }

  Future<void> delAsFavorites(Shoe shoe, String uid) async {
    //final uid = Storage().getUid();
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
            .then((value) => print('Success'));
      });
    });
  }

  Future<List<QueryDocumentSnapshot>> getFromFavorites(String uid) async {
    final res = await users.doc(uid).collection('favorites').get();
    return res.docs;
  }

  Future<void> checkOut() async {
    final uid = Storage().getUid();
    final cartCollection = await users.doc(uid).collection('cart').get();
    for (var doc in cartCollection.docs) {
      await firebaseIns.runTransaction((Transaction transaction) async {
        /*await*/ transaction.delete(doc.reference);
      });
    }
  }

  Future<List<QueryDocumentSnapshot>> getBannerImage() async {
    // final uid = Storage().getUid();
    final res = await banners.get();
    return res.docs;
  }
}
