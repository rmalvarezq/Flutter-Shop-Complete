import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopflutter/login/models/admin.dart';

class AdminProvider {
  CollectionReference _collectionReference;
  AdminProvider() {
    _collectionReference = FirebaseFirestore.instance.collection('Admin');
    // print('Collection Created');
  }

  Future<void> create(Admin admin) async {
    String errorMessage;
    try {
      return _collectionReference.doc(admin.id).set(admin.toJson());
    } catch (error) {
      errorMessage = error.code;
    }
    if (errorMessage != null)  return Future.error(errorMessage);
  }
}
