abstract class HttpService {
  Future<dynamic> get({String url});
  Future<dynamic> post({String url, Map<String, dynamic> data});
  Future<dynamic> delete({String url, int id});
}
