import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiSarvice {
  static ApiSarvice apiSarvice = ApiSarvice._();
  ApiSarvice._();

  Future<String?> fetchData() async {
    String api = 'https://sheetdb.io/api/v1/acbqwn2nsxapm';
    Uri uri = Uri.parse(api);
    Response response = await http.get(uri);

    if (response.statusCode == 200) {
      print('Api Called');
      return response.body;
    } else {
      return null;
    }
  }
}
