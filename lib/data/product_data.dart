import 'dart:convert';
import 'package:http/http.dart' as http;

var ProductData;

Future<void> getDummyUser() async {
  var url = Uri.parse("https://jsonplaceholder.typicode.com/users");
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      ProductData = jsonDecode(response.body);
    } else {
      print("Failed to get user. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error occurred: $e");
  }
}
