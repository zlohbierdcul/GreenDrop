
import 'package:greendrop/src/domain/models/user.dart';

abstract class IAuthenticationRepository {
  User? getUser();
  Future<bool> signIn(String email, String password);
  void signOut();
  Future<bool> register(String username, String email, String password,
      String forename, String lastname, String birthdate, String street, String housenumber,
      String town, String plz);
  void updateUser(User user);
  Future<User> fetchUser(String id);
}