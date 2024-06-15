import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  UpdateUserWallet(String id, int amount) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"Wallet": amount});
  }

  // Future addFoodItem(Map<String, dynamic> foodItemMap, String id) async {
  //   return await FirebaseFirestore.instance
  //       .collection("foodItems")
  //       .doc(id)
  //       .set(foodItemMap);
  // }

  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance.collection("products").snapshots();
  }

  Future addFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Cart")
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return await FirebaseFirestore.instance.collection("users").doc(id).collection("Cart").snapshots();
  }

  Future deleteFoodCart(String id, String docId) async {
    return await FirebaseFirestore.instance.collection("users").doc(id).collection("Cart").doc(docId).delete();
  }

}
