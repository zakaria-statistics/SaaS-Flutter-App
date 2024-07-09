import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_web_app/features/user_auth/presentation/backend/entities/user_entity.dart';


class UserRepository {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

  Future<UserEntity> getUser(String id) async {
    DocumentSnapshot doc = await usersCollection.doc(id).get();
    return UserEntity.fromSnapshot(doc);
  }

  Future<UserEntity> getUsers() async {
    DocumentSnapshot doc = await usersCollection.doc().get();
    return UserEntity.fromSnapshot(doc);
  }

  Future<void> addUser(UserEntity user) async {
    await usersCollection.doc(user.id).set(user.toJson());
  }

  Future<void> updateUser(UserEntity user) async {
    await usersCollection.doc(user.id).update(user.toJson());
  }
}
