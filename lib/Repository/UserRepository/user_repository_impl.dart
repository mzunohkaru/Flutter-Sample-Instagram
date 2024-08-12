import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Model/Entity/User/user.dart';
import 'user_repository.dart';

part 'user_repository_impl.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl(FirebaseFirestore.instance);
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<User> fetchUser({required String uid}) {
    return _firestore.collection("users").doc(uid).get().then((value) {
      return User.fromJson(value.data()!);
    });
  }
}
