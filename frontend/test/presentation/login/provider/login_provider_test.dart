import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/presentation/login/provider/login_provider.dart';

void main() {
  late LoginProvider loginProvider;

  setUp(() {
    loginProvider = LoginProvider();
  });

  group('LoginProvider Tests (Reine Logik, Navigator-Exception ignorieren)', () {
    test('Anfangswerte: isPasswordVisible, rememberMeTicked, isLoading, loginFailed', () {
      expect(loginProvider.isPasswordVisible, false);
      expect(loginProvider.rememberMeTicked, false);
      expect(loginProvider.isLoading, false);
      expect(loginProvider.loginFailed, false);
    });

    test('setIsPasswordVisible(true) setzt isPasswordVisible auf true', () {
      loginProvider.setIsPasswordVisible(true);
      expect(loginProvider.isPasswordVisible, true);
    });

    test('setRememberMeTicked(true) setzt rememberMeTicked auf true', () {
      loginProvider.setRememberMeTicked(true);
      expect(loginProvider.rememberMeTicked, true);
    });
  });
}
