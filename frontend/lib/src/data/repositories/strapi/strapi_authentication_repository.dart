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
  String? jwtToken;

  // Add authorization token to every request
  StrapiAuthenticationRepository._privateConstructor() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers["Authorization"] = "Bearer ${jwtToken ?? ""}";
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
      String firstname,
      String lastname,
      String birthdate,
      String street,
      String streetNo,
      String city,
      String zipCode) async {
    bool success = false;
    try {
      Response response = await dio.post(
        api.getRegister(),
        data: {
          "username": username,
          "email": email,
          "password": password,
        },
      );
      success = response.statusCode == 200;
      String jwt = response.data["jwt"];
      String userId = response.data["user"]["documentId"];
      String addressId =
          await createAddress(street, streetNo, city, zipCode, jwt);
      String userDetailId = await createUserDetail(
          username, email, firstname, lastname, birthdate, addressId, jwt);
      dio.put(api.connectUserDetail(userDetailId),
          data: {
            "data": {
              "users_permissions_user": {
                "connect": [userId]
              }
            }
          },
          options: Options(headers: {"Authorization": "Bearer $jwt"}));
    } catch (_) {
      success = false;
    }

    return success;
  }

  @override
  Future<bool> signIn(
      String email, String password, bool rememberMeTicked) async {
    Response response = await dio.post(api.getSignIn(),
        data: {"identifier": email, "password": password});
    bool success = response.statusCode == 200;

    String jwt = response.data["jwt"];

    if (success) {
      const secureStorage = FlutterSecureStorage();

      if (rememberMeTicked) {
        // only write jwt token to secure storage if user wants to stay logged in
        secureStorage.write(key: "jwt", value: jwt);
      }
      jwtToken = jwt;

      await fetchUser(response.data["user"]["id"].toString());
      secureStorage.write(key: "userId", value: _user!.userId);
    }
    return success;
  }

  @override
  void signOut() async {
    _user = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isLoggedIn");
    prefs.remove("userId");
    prefs.remove("jwt");
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
  Future<String> createAddress(String street, String streetNo, String city,
      String zipCode, String jwt) async {
    Response response = await dio.post(api.createAddress(),
        data: {
          "data": {
            "street": street,
            "street_no": streetNo,
            "city": city,
            "zip_code": zipCode,
            "is_primary": true
          }
        },
        options: Options(headers: {"Authorization": "Bearer $jwt"}));

    return response.data["data"]["documentId"];
  }

  @override
  Future<String> createUserDetail(
      String username,
      String email,
      String firstname,
      String lastname,
      String birthdate,
      String addressId,
      String jwt) async {
    Response response = await dio.post(api.createUserDetail(),
        data: {
          "data": {
            "username": username,
            "email": email,
            "first_name": firstname,
            "last_name": lastname,
            "green_drops": 50,
            "addresses": [addressId],
            "birthdate": birthdate
          }
        },
        options: Options(headers: {"Authorization": "Bearer $jwt"}));

    return response.data["data"]["documentId"];
  }

  @override
  Future<User> fetchUser(String id) async {
    Response response = await dio.get(api.getUser(id));
    dynamic data = response.data;
    _user = User.fromJson(data);
    return _user!;
  }
}
