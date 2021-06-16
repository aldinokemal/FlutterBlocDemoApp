import 'dart:io';
import 'package:my_app/config/setting.dart';
import 'package:my_app/repos/api/app_exception.dart';
import 'package:my_app/repos/models/login.dart';
import 'package:dio/dio.dart';

class LoginRepository {
  Future<dynamic> postLogin(String email, String password) async {
    try {
      var formData = FormData.fromMap({'email': email, 'password': password});
      final response = await Dio().post(Constants.authLogin, data: formData);
      return ApiLogin.fromJson(response.data);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      throw e.response!.data["message"];
    }
  }
}
