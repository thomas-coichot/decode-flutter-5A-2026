import '../../services/api_service.dart';

class ModelRepository {
  final String uri;
  final Function fromJson;

  const ModelRepository({required this.uri, required this.fromJson});

  Future getAll({Map<String, String>? query}) async {
    return ApiService().request(
      uri: uri,
      httpMethod: HttpMethod.get,
      queryParams: query,
      parser: (res) {
        return res['results'].map((e) => fromJson(e)).toList();
      },
    );
  }

  Future addOrUpdate({required Map<String, dynamic> data, String? id}) async {
    return ApiService().request(
      uri: uri,
      httpMethod: id != null ? HttpMethod.put : HttpMethod.post,
      data: data,
      id: id,
      parser: fromJson,
    );
  }

  Future delete(String id) {
    return ApiService().request(
      uri: uri,
      httpMethod: HttpMethod.delete,
      id: id,
    );
  }

  Future get(String id) {
    return ApiService().request(
      uri: uri,
      id: id,
      parser: fromJson,
    );
  }
}
