import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../constants/firebase_keys.dart';

class UserRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  Future<void> createUser(UserModel user) async {
    await firestore.collection(FirebaseKeys.users).doc(user.id).set({
      FirebaseKeys.name: user.name,
      FirebaseKeys.email: user.email,
      FirebaseKeys.phone: user.phone,
      FirebaseKeys.profileImage: user.profileImage,
      FirebaseKeys.createdAt: FieldValue.serverTimestamp(),
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await firestore.collection(FirebaseKeys.users).doc(uid).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    return UserModel.fromMap(data, doc.id);
  }

Future<UserModel> updateUser(
  UserModel user, {
  required String name,
  required String email,
  required String phone,
  File? imageFile,
}) async {

  String? imageUrl = user.profileImage;

  await firestore.collection(FirebaseKeys.users).doc(user.id).update({
    FirebaseKeys.name: name,
    FirebaseKeys.email: email,
    FirebaseKeys.phone: phone,
    FirebaseKeys.profileImage: imageUrl,
    FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
  });

  // Fetch latest user data
  final doc = await firestore.collection(FirebaseKeys.users).doc(user.id).get();
  return UserModel.fromMap(doc.data()!, doc.id);
}


}
