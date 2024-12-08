
import 'package:greendrop/src/domain/models/user.dart';

abstract class IAuthenticationRepository {
  User? getUser();
  Future<bool> signIn(String email, String password);
  void signOut();
  void register(User user);
  void updateUser(User user);
  Future<User> fetchUser(String id);
}