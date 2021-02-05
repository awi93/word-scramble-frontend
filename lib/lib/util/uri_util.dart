import 'package:flutter/foundation.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';

class UriUtil {
  static buildUri(String baseUrl, {Map<String, String> queries}) {
    String url = MixUtil.apiHost;

    url += baseUrl;

    int i = 0;

    /**
     * Check whether the current url has contain query string before.
     */
    RegExp regExp =
        new RegExp(r'/\?.+=.*/g', caseSensitive: false, multiLine: false);
    if (regExp.hasMatch(url)) {
      i = 1;
    }

    /**
     * Put the query string into the url
     */
    if (queries != null) {
      queries.forEach((key, value) {
        if (i == 0) {
          url += "?";
        } else {
          url += "&";
        }
        url += key + "=" + value;
        i++;
      });
    }

    return url;
  }
}
