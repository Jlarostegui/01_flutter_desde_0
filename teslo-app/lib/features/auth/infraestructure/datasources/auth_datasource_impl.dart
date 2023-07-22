import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/infrastruture.dart';

class AuthDatasourceImpl extends AuthDataSource {
  final dio = Dio(
    BaseOptions(baseUrl: Environment.apiUrl),
  );

  @override
  Future<User> chechAuthStatus({String? token}) {
    // TODO: implement chechAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login({String? email, String? password}) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {email: email, password: password},
      );
      final User user = UserMapper.userJsonToEntity(response.data);
      return user;
    } catch (e) {
      throw WrongCredentials();
    }
  }

  @override
  Future<User> register({String? email, String? password, String? fullName}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
