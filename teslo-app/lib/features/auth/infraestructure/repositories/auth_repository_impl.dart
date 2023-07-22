import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/infrastruture.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({AuthDataSource? dataSource})
      : dataSource = dataSource ?? AuthDatasourceImpl();

  @override
  Future<User> chechAuthStatus({String? token}) {
    return dataSource.chechAuthStatus(token: token ?? '');
  }

  @override
  Future<User> login({String? email, String? password}) {
    return dataSource.login(email: email ?? '', password: password ?? '');
  }

  @override
  Future<User> register({String? email, String? password, String? fullName}) {
    return dataSource.register(
        email: email ?? '', fullName: fullName ?? '', password: password ?? '');
  }
}
