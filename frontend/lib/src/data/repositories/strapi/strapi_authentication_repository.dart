import 'package:dio/dio.dart';
import 'package:greendrop/src/data/db/strapi.db.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/domain/models/user.dart';

class StrapiAuthenticationRepository extends IAuthenticationRepository {
  Dio dio = Dio();
  StrapiAPI api = StrapiAPI();
  late User _user;

  User get user => _user;

  // Add authorization token to every request
  StrapiAuthenticationRepository() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers["Authorization"] = api.getAuth();
        return handler.next(options);
      },
    ));
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
      Response userResponse =
          await dio.get(api.getUser(response.data["user"]["id"].toString()));
      dynamic data = userResponse.data;
      _user = User.fromJson(data);
    }
    return success;
  }

  @override
  void signOut(String email) {
    // TODO: implement signOut
  }
}
