import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopflutter/login/models/client.dart';

class ClientProvider {
  CollectionReference _collectionReference;
  ClientProvider() {
    _collectionReference = FirebaseFirestore.instance.collection('Clients');
    print('Collection Created');
  }

  Future<void> create(Client client) async {
    String errorMessage;
    try {
      return _collectionReference.doc(client.id).set(client.toJson());
    } catch (error) {
      errorMessage = error.code;
    }
    if (errorMessage != null)  return Future.error(errorMessage);
  }
}
