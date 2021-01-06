import 'result_model.dart';

class ItemModel {
  int _page;
  List<Result> _results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    List<Result> temp = [];
    if (parsedJson != null) {
      _page = parsedJson['page'];
      for (int i = 0; i < parsedJson['results'].length; i++) {
        Result result = Result(parsedJson['results'][i]);
        temp.add(result);
      }
    }
    _results = temp;
  }

  List<Result> get results => _results;

  int get page => _page;
}
