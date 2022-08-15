import 'dart:convert';

import 'package:data_oson_aptek/src/model/oson_aptek_messag_model.dart';
import 'package:http/http.dart' as http;

class AppProvider {
  static String baseUrl = "https://test.osonapteka.uz/api/m11/errormessage";

  Future<List<OsonAptekMessageModel>> getOsonAptek() async {
    String url = baseUrl;
    http.Response response = await http.get(Uri.parse(url));
    final osonAptekMessageModel =
        osonAptekaMessageModelFromJson(utf8.decode(response.bodyBytes));
    return osonAptekMessageModel;
  }
}
