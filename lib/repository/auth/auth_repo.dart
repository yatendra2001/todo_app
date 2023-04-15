import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:todo_app/repository/auth/base_auth_repo.dart';
import 'package:todo_app/utils/session_manager.dart';

class AuthRepo extends BaseAuthRepo {
  late Client client;
  late Account account;
  final SessionManager sessionManager = SessionManager();

  AuthRepo() {
    client = Client()
      ..setEndpoint("http://localhost/v1")
      ..setProject("643a8920d822f0edb885")
      ..setSelfSigned(status: true);
    account = Account(client);
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final user = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await account.createEmailSession(
        email: email,
        password: password,
      );

      final user = await account.get();
      await sessionManager.setLoggedIn(true);
      log(user.toMap().toString());
    } catch (error) {
      log("sign in error: ${error.toString()}");
    }
  }

  @override
  Future<void> logout() {
    return Future.wait([
      account.deleteSession(sessionId: 'current'),
      sessionManager.setLoggedIn(false),
    ]);
  }
}
