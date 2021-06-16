import 'dart:io';

import 'package:my_app/config/setting.dart';
import 'package:my_app/repos/api/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:my_app/repos/models/register.dart';

class RegisterRepository {
  Future<dynamic> postRegister(String email, String password, String fullname) async {
    try {
      var formData = FormData.fromMap({'email': email, 'password': password, 'fullname': fullname});
      final response = await Dio().post(Constants.authRegister, data: formData);
      return ApiRegister.fromJson(response.data);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      throw e.response!.data["message"];
    }
  }
}
