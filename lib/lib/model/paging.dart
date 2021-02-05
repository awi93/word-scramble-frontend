import 'package:equatable/equatable.dart';

class Paging<T> extends Equatable {
  int _currentPage;
  int _from;
  int _to;
  int _perPage;
  int _total;
  int _lastPage;
  String _firstPageUrl;
  String _lastPageUrl;
  String _nextPageUrl;
  String _prevPageUrl;
  String _path;
  List<T> _data;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
  }

  int get from => _from;

  set from(int value) {
    _from = value;
  }

  List<T> get data => _data;

  set data(List<T> value) {
    _data = value;
  }

  String get path => _path;

  set path(String value) {
    _path = value;
  }

  String get prevPageUrl => _prevPageUrl;

  set prevPageUrl(String value) {
    _prevPageUrl = value;
  }

  String get nextPageUrl => _nextPageUrl;

  set nextPageUrl(String value) {
    _nextPageUrl = value;
  }

  String get lastPageUrl => _lastPageUrl;

  set lastPageUrl(String value) {
    _lastPageUrl = value;
  }

  String get firstPageUrl => _firstPageUrl;

  set firstPageUrl(String value) {
    _firstPageUrl = value;
  }

  int get lastPage => _lastPage;

  set lastPage(int value) {
    _lastPage = value;
  }

  int get total => _total;

  set total(int value) {
    _total = value;
  }

  int get perPage => _perPage;

  set perPage(int value) {
    _perPage = value;
  }

  int get to => _to;

  set to(int value) {
    _to = value;
  }

  fromJson(Map<String, dynamic> json, List<T> data) {
    if (json == null)
      return null;
    this.currentPage = json["current_page"];
    this.to = json["to"];
    this.perPage = (json["per_page"] is String)
        ? int.parse(json["per_page"])
        : json["per_page"];
    this.total = json["total"];
    this.lastPage = json["last_page"];
    this.from = json["from"];
    this.firstPageUrl = json["first_page_url"];
    this.lastPageUrl = json["last_page_url"];
    this.nextPageUrl = json["next_page_url"];
    this.prevPageUrl = json["prev_page_url"];
    this.path = json["path"];

    this.data = data;
  }

  @override
  List<Object> get props => [firstPageUrl];
}
