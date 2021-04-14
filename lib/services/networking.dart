import 'dart:convert';
import 'package:http/http.dart' as http;

class NetWorkData {
  String url;
  NetWorkData({this.url});
  http.Response response;
  Future getData() async {
    response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      var jsonDecodedData = jsonDecode(data);

      return jsonDecodedData;
    } else {
      print(response.statusCode);
    }
  }
}
