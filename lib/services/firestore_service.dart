import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FireStoreService {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .doc(userModel.id)
        .set(userModel.toJson());
  }
}