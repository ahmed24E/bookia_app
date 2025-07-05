import 'dart:developer';

import 'package:bookia_app/core/services/local/app_local_storage.dart';
import 'package:bookia_app/core/services/remote/dio_provider.dart';
import 'package:bookia_app/core/services/remote/endpoints.dart';
import 'package:bookia_app/features/profile/data/model/request/edit_user_model_params.dart';
import 'package:bookia_app/features/profile/data/model/response/get_profile_response/get_profile_response.dart';
import 'package:dio/dio.dart';

class ProfileRepo {
  static Future<GetProfileResponse?> getProfile() async {
    try {
      var response = await DioProvider.get(
          endpoint: AppEndpoints.getProfile,
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
          });
      log('-----1-------=');
      if (response.statusCode == 200) {
        log(response.data.toString());
        return GetProfileResponse.fromJson(response.data);
      } else {
        log('--------3-------');
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> updateProfile(UpdateUserModelParams model) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.updateProfile,
        data: FormData.fromMap({
          if (model.name != null) "name": model.name,
          if (model.phone != null) "phone": model.phone,
          if (model.address != null) "address": model.address,
          if (model.image != null)
            "image": MultipartFile.fromFile(
              model.image ?? '',
              filename: model.image?.split('/').last,
            ),
        }),
        headers: {
          "Authorization":
              "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
