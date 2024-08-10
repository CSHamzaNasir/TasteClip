abstract class AuthBaseRepository {
  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String about,
    String address,
    String userImg,
  );

  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}
