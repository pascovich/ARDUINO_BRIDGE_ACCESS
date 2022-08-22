import 'package:dio/dio.dart';
import 'package:updetecteurpoid/logic/app_helper.dart';

class Repository {
  String getHistoric = "/historique";
  String parameterRoute = "/parametre";

  Future<Response> getAllHistoric() async {
    var response = await httpGet(
      serviceApi: getHistoric,
    );
    return response;
  }

  Future<Response> setParameter({double? weight}) async {
    var response = await httpPost(serviceApi: parameterRoute, data: {
      "poids": weight,
    });
    return response;
  }
}
