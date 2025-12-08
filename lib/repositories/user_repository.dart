import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../constants/firebase_keys.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<void> createUser(UserModel user) async {
    await _firestore.collection(FirebaseKeys.users).doc(user.id).set({
      FirebaseKeys.name: user.name,
      FirebaseKeys.email: user.email,
      FirebaseKeys.phone: user.phone,
      FirebaseKeys.profileImage: user.profileImage,
      FirebaseKeys.createdAt: FieldValue.serverTimestamp(),
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection(FirebaseKeys.users).doc(uid).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    return UserModel.fromMap(data, doc.id);
  }

  Future<void> updateUser(UserModel user, {required String name, required String email, required String phone, File? imageFile}) async {
    await _firestore.collection(FirebaseKeys.users).doc(user.id).update({
      FirebaseKeys.name: user.name,
      FirebaseKeys.phone: user.phone,
      FirebaseKeys.profileImage: user.profileImage,
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }
}
