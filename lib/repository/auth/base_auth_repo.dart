abstract class BaseAuthRepo {
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password, required String name});
  Future<void> logout();
}
