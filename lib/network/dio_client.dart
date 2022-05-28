import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_dio_example/models/models.dart';
import 'package:flutter_dio_example/network/network.dart';

// ignore: constant_identifier_names
const String API_KEY =
    'cdc9a8ca8aa17b6bed3aa3611a835105bbb4632514d7ca8cf55dbbc5966a7cae';

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Endpoints.baseURL,
            connectTimeout: Endpoints.connectionTimeout,
            receiveTimeout: Endpoints.receiveTimeout,
            responseType: ResponseType.json,
          ),
        );

  late final Dio _dio;

  Future<User?> getUser({required int id}) async {
    try {
      final response = await _dio.get('${Endpoints.users}/$id');
      return User.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<User?> createUser({required User user}) async {
    try {
      final response = await _dio.post(
        Endpoints.users,
        data: user.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $API_KEY'},
        ),
      );
      return User.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err);
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<void> deleteUser({required int id}) async {
    try {
      await _dio.delete(
        '${Endpoints.users}/$id',
        options: Options(
          headers: {'Authorization': 'Bearer $API_KEY'},
        ),
      );
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err);
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}
