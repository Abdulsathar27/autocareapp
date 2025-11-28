import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firebase_keys.dart';
import '../providers/user_provider.dart';

class UserController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------------------------------------------------------
  // UPLOAD PROFILE IMAGE
  // ---------------------------------------------------------
  Future<String?> uploadProfileImage(String uid, File file) async {
    try {
      final ref = _storage
          .ref()
          .child('${FirebaseKeys.userProfileImages}$uid.jpg');

      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (_) {
      return null;
    }
  }

  // ---------------------------------------------------------
  // UPDATE USER PROFILE
  // ---------------------------------------------------------
  Future<bool> updateProfile({
    required String uid,
    required UserProvider userProvider,
    String? name,
    String? email,
    String? phone,
    File? imageFile,
  }) async {
    try {
      String? imageUrl = userProvider.user?.profileImage;

      if (imageFile != null) {
        final uploaded = await uploadProfileImage(uid, imageFile);
        if (uploaded != null) imageUrl = uploaded;
      }

      final data = <String, dynamic>{};

      if (name != null) data[FirebaseKeys.name] = name;
      if (email != null) data[FirebaseKeys.email] = email;
      if (phone != null) data[FirebaseKeys.phone] = phone;
      if (imageUrl != null) data[FirebaseKeys.profileImage] = imageUrl;

      data[FirebaseKeys.updatedAt] = FieldValue.serverTimestamp();

      await _firestore
          .collection(FirebaseKeys.users)
          .doc(uid)
          .update(data);

      // 🔥 RELOAD the updated user
      await userProvider.loadUser(uid);

      return true;
    } catch (e) {
      return false;
    }
  }
}
