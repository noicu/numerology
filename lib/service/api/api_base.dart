import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:numerology/model/PageBean.dart';

class ApiBase {
  //用户登录后的token
  static String jwt = "test/1";
  //
  static Dio dio = new Dio();
  //用户访问的主机
  static String host = "0755yicai.com";

  static Future<PageBean> postPage<T>(
      String url, dynamic postData, dynamic tranFn(Map<String, dynamic> m),
      {bool enableJwt = true}) async {
    var m = await post(url, postData, enableJwt: enableJwt);
    if (m["code"] as int >= 200) {
      PageBean bean = PageBean.fromMap(m["data"]);
      List items =
          ((m["data"] as Map)["data"] as List).map((x) => tranFn(x)).toList();
      bean.data = items;
      return bean;
    }

    throw m["msg"];
  }

  //最基本的post类型，返回结果是response中的map<string,dynamic>
  static post(String url, dynamic postData, {bool enableJwt = true}) async {
    String host = "http://${ApiBase.host}";
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    if (enableJwt) headers['Jwt'] = jwt;
    dynamic r = await dio.post(
      host + url,
      data: postData,
      options: Options(headers: headers),
    );
    return jsonDecode(r.data);
  }
}
