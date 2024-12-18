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

  static final StrapiAuthenticationRepository _singleton = StrapiAuthenticationRepository._privateConstructor() ;

  factory StrapiAuthenticationRepository() {
    return _singleton;
  }

  @override
  User? getUser() {
    return _user;
  }

  @override
  void register(User user) {
    // TODO: implement register
  }

  @override
  Future<bool> signIn(String email, String password) async {
    Response response = await dio.post(api.getSignIn(),
        data: {"identifier": email, "password": password},
        options:
            Options(headers: {"Authorization": "Bearer ${api.getAuth()}"}));
    bool success = response.statusCode == 200;

    if (success) {
      await fetchUser(response.data["user"]["id"].toString());
      const secureStorage = FlutterSecureStorage();
      secureStorage.write(key: "userId", value: _user!.id);
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
    dio.put(api.updateUser(user), data: user.toJson());
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
  void addAddress(Address address) {
    _user?.addresses.add(address);
    dio.put(api.addAddress(), data: {"data": address.toJson()});
  }

  @override
  Future<User> fetchUser(String id) async {
    Response response = await dio.get(api.getUser(id));
    dynamic data = response.data;
    _user = User.fromJson(data);
    return _user!;
  }
}
