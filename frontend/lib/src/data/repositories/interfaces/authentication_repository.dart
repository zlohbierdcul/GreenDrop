import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/user.dart';

abstract class IAuthenticationRepository {
  User? getUser();
  Future<bool> signIn(String email, String password, bool rememberMeTicked);
  void signOut();
  Future<bool> register(
      String username,
      String email,
      String password,
      String firstname,
      String lastname,
      String birthdate,
      String street,
      String streetNo,
      String city,
      String zipCode);
  void updateUser(User user);
  void updateUserAddress(Address address);
  void addAddress(Address address);
  void deleteAddress(Address address);
  Future<User> fetchUser(String id);
  Future<String> createAddress(String street, String streetNo, String city, String zipCode, String jwt);
  Future<String> createUserDetail(String username, String email, String firstname, String lastname, String birthdate, String addressId, String jwt);
}
