import 'dart:io';
import 'package:dio/dio.dart';

const String baseUrl = "http://192.168.32.168:8000";

httpGet({String? serviceApi, Map<String, dynamic>? parameters}) async {
  try {
    return await Dio()
        .get(
          "$baseUrl$serviceApi",
          queryParameters: parameters,
          options: Options(
            headers: {
              "X-Requested-With": "XMLHttpRequest",
            },
          ),
        )
        .timeout(
          const Duration(seconds: 30),
        )
        .catchError(
          (onError) {},
        );
  } catch (_) {}
}

httpPost({String? serviceApi, Map<String, dynamic>? data}) async {
  String lang =
      Platform.localeName.substring(0, Platform.localeName.indexOf('_'));

  try {
    return await Dio().post(
      "$baseUrl$serviceApi",
      options: Options(
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          'Content-Type': 'application/json',
          'lang': lang,
        },
        // validateStatus: (status) {
        //   return status! < 500;
        // },
      ),
      data: data,
    );
  } catch (_) {}
}

httpPutWithToken({String? serviceApi, var data}) async {
  try {
    return await Dio()
        .put(
          "$baseUrl$serviceApi",
          data: data,
          options: Options(
            headers: {
              'X-Requested-With': 'XMLHttpRequest',
            },
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        )
        .timeout(
          const Duration(seconds: 30),
        );
  } catch (_) {}
}
