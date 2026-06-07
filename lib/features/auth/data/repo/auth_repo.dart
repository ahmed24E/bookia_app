import 'dart:developer';

import 'package:bookia_app/core/services/remote/dio_provider.dart';
import 'package:bookia_app/core/services/remote/endpoints.dart';
import 'package:bookia_app/features/auth/data/model/request/user_model_params.dart';
import 'package:bookia_app/features/auth/data/model/response/user_model_response/user_model_response.dart';

class AuthRepo {
  static Future<UserModelResponse?> register(UserModelParams params) async {
    try {
      var response = await DioProvider.post(
          endpoint: AppEndpoints.register, data: params.toJson());
      // var url = Uri.parse(AppEndpoints.baseUrl + AppEndpoints.register);
      // var response = await http.post(url, body: params.toJson());
      log('-------1--------');
      if (response.statusCode == 201) {
        // var strToJson = jsonDecode(response.body);
        return UserModelResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<UserModelResponse?> login(UserModelParams params) async {
    try {
      var response = await DioProvider.post(
          endpoint: AppEndpoints.login, data: params.toJson());
      log('-------1--------');
      if (response.statusCode == 200) {
        return UserModelResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }
}
