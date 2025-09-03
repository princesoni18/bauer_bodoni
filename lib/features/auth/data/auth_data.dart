 
import 'package:bodoni/core/utils/logger.dart';
import 'package:bodoni/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<UserModel> login(String email, String password) async {
    Logger.info('RemoteDataSource: Attempting login for $email');
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Logger.info('RemoteDataSource: Firebase signIn success for $email');
      final userDoc = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      Logger.info('RemoteDataSource: Firestore user fetch success for $email');
      return UserModel.fromFirestore(userDoc);
    } catch (e) {
      Logger.error('RemoteDataSource: Login error for $email: $e');
      rethrow;
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    Logger.info('RemoteDataSource: Attempting register for $email, name: $name');
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Logger.info('RemoteDataSource: Firebase createUser success for $email');
      final userModel = UserModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        createdAt: DateTime.now(),
      );
      await firestore
          .collection('users')
          .doc(credential.user!.uid)
.set(userModel.toFirestore());
      Logger.info('RemoteDataSource: Firestore user creation success for $email');
      return UserModel(id: credential.user!.uid, email: email, name: name, createdAt: DateTime.now());
    } catch (e) {
      Logger.error('RemoteDataSource: Register error for $email: $e');
      rethrow;
    } 
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;

    final userDoc = await firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) return null;

    return UserModel.fromFirestore(userDoc);
  }
}