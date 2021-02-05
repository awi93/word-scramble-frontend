import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:word_scramble_frontend/lib/error/error_response_exception.dart';
import 'package:word_scramble_frontend/lib/model/access_token.dart';
import 'package:word_scramble_frontend/lib/repo/auth_repo.dart';
import 'package:word_scramble_frontend/lib/util/uri_util.dart';

class MixUtil {
  static SharedPreferences _preferences;
  static SharedPreferences get preferences => _preferences;
  static String apiHost = "http://128.199.217.247";
  static String clientId = "2";
  static String clientPassword = "CnFdkOsD1NYQMsa67ryxpfWWxHi7F7e0zJWOWleC";
  static http.Client _client;

  static http.Client get client => _client;

  static setupPreferences() async {
    MixUtil._preferences = await SharedPreferences.getInstance();
  }

  /**
   * This method is used to setup http Client for the first time and prevent the http client to be instanciate for more than one time.
   */
  static setupHttpClient() {
    if (MixUtil._client == null) {
      MixUtil._client = new http.Client();
    }
  }

  static DateTime millisToDateTime(int millis) {
    if (millis == null) return null;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    return date;
  }

  static int datetimeToMillis(DateTime date) {
    if (date == null) return null;
    return date.millisecondsSinceEpoch;
  }

  ///This method is to combine default header with header parsed from argument
  static Map<String, String> _processHeaders(Map<String, String> headers) {
    Map<String, String> defaultHeaders = {};

    /**
     * Put in Access Token if Exist
     */
    AccessToken token = AuthRepo.instance().getAccessToken();
    if (token != null) {
      defaultHeaders["authorization"] = "Bearer " + token.accessToken;
    }

    /**
     * Combining defaultHeaders with headers from arguments
     */
    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    return defaultHeaders;
  }

  ///This method is to process url and query
  static String _processUri(String url, {Map<String, String> queries}) {
    String requestUrl = UriUtil.buildUri(url, queries: queries);

    return requestUrl;
  }

  ///This method is used to get standard IO Timeout from remote config
  static Duration _getIoTimeout() {
    return Duration(seconds: 120);
  }

  static Future<http.Response> get(String url,
      {Map<String, String> headers,
      Map<String, String> queries,
      bool fullUrl = false}) async {
    final http.Response response = await MixUtil.client
        .get((fullUrl) ? url : _processUri(url, queries: queries),
            headers: _processHeaders(headers))
        .timeout(_getIoTimeout());

    return response;
  }

  static Future<http.Response> post(String url, Map<String, dynamic> body,
      {Map<String, String> headers, Map<String, String> queries}) async {
    if (headers == null) {
      headers = {};
    }
    headers["Content-Type"] = "application/json";

    final String stringBody = jsonEncode(body);

    final http.Response response = await MixUtil.client
        .post(_processUri(url, queries: queries),
            headers: _processHeaders(headers), body: stringBody)
        .timeout(_getIoTimeout());

    return response;
  }

  static Future<http.Response> put(String url, Map<String, dynamic> body,
      {Map<String, String> headers, Map<String, String> queries}) async {
    if (headers == null) {
      headers = {};
    }
    headers["Content-Type"] = "application/json";

    final String stringBody = jsonEncode(body);

    final http.Response response = await MixUtil.client
        .put(_processUri(url, queries: queries),
            headers: _processHeaders(headers), body: stringBody)
        .timeout(_getIoTimeout());

    return response;
  }

  static ErrorResponseException httpResponseToException(
      http.Response response) {
    final Map<String, dynamic> errors = jsonDecode(response.body);
    Map<String, List<String>> errorMsgs;
    if (errors.containsKey("errors")) {
      errorMsgs = new Map();
      Map<String, dynamic> tempErrors = errors["errors"];
      for (String key in tempErrors.keys) {
        errorMsgs[key] = List<String>.from(tempErrors[key]);
      }
    }
    return new ErrorResponseException(
        response.statusCode, errors["error"], errorMsgs);
  }

  static showAlert(BuildContext context, String conten, VoidCallback callback) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Text(conten),
            ),
            actions: [
              FlatButton(onPressed: callback, child: Text("Try Again"))
            ],
          );
        });
  }
}
