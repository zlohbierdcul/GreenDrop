import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greendrop/src/data/db/strapi.db.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StrapiAuthenticationRepository extends IAuthenticationRepository {
  Dio dio = Dio();
  StrapiAPI api = StrapiAPI();
  User? _user;

  // Add authorization token to every request
  StrapiAuthenticationRepository._privateConstructor() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers["Authorization"] = api.getAuth();
        return handler.next(options);
      },
    ));
  }

  static final StrapiAuthenticationRepository _singleton =
      StrapiAuthenticationRepository._privateConstructor();

  factory StrapiAuthenticationRepository() {
    return _singleton;
  }

  @override
  User? getUser() {
    return _user;
  }

  @override
  Future<bool> register(
      String username,
      String email,
      String password,
      String forename,
      String lastname,
      String birthdate,
      String street,
      String housenumber,
      String town,
      String plz) async {
    Response response = await dio.post(
      api.getRegister(),
      data: {"username": username, "email": email, "password": password},
    );

    bool success = response.statusCode == 200;

    User user = User(
        id: response.data["user"]["documentId"].toString(),
        userId: response.data["user"]["id"].toString(),
        userDetailId:
            response.data["user"]['user_detail']["documentId"].toString(),
        userName: username,
        firstName: forename,
        lastName: lastname,
        birthdate: birthdate,
        greenDrops: 0,
        eMail: email,
        addresses: [
          Address(
              id: "000",
              street: street,
              streetNumber: housenumber,
              zipCode: plz,
              city: town,
              isPrimary: true)
        ]);
    if (success) {
      updateUser(user);
    }

    return success;
  }

  @override
  Future<bool> signIn(String email, String password) async {
    Response response = await dio.post(api.getSignIn(),
        data: {"identifier": email, "password": password});
    bool success = response.statusCode == 200;

    if (success) {
      await fetchUser(response.data["user"]["id"].toString());
      const secureStorage = FlutterSecureStorage();
      secureStorage.write(key: "userId", value: _user!.userId);
    }
    return success;
  }

  @override
  void signOut() async {
    _user = null;
    // remove "remember me" token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isLoggedIn");
  }

  @override
  void updateUser(User user) {
    _user = user;
    dio.put(api.updateUser(user), data: {"data": user.toJson()});
  }

  @override
  void updateUserAddress(Address address) {
    _user?.changeAddress(address);
    dio.put(api.updateAddress(address), data: {"data": address.toJson()});
  }

  @override
  void deleteAddress(Address address) {
    _user?.addresses.remove(address);
    dio.delete(api.deleteAddress(address));
  }

  @override
  void addAddress(Address address) async {
    Response r =
        await dio.post(api.addAddress(), data: {"data": address.toJson()});
    String id = r.data["data"]['documentId'].toString();

    address.updateId(id);

    await dio.put(api.connectAddressToUser(_user!.userDetailId), data: {
    "data": {
        "addresses": {
            "connect": [id]
        }
    }
});

    updateUser(_user!);
  }

  @override
  Future<User> fetchUser(String id) async {
    Response response = await dio.get(api.getUser(id));
    dynamic data = response.data;
    _user = User.fromJson(data);
    return _user!;
  }
}
