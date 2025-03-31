import 'package:http/http.dart' as http;
import 'package:smalltin/core/constants/api_string.dart';

class FieldApi {
  Future<http.Response?> getAllFields() async {
    try {
      var res = await http.get(ApiString.endPoint("fields"));
      return res;
    } catch (e) {
      return null;
    }
  }
}
