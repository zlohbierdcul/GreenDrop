
import 'package:greendrop/src/domain/models/user.dart';

abstract class IAuthenticationRepository {
  Future<bool> signIn(String email, String password);
  void signOut(String email);
  void register(User user);
}