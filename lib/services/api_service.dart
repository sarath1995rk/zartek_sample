import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zartek_sample/others/responses/food_resp.dart';

class ApiService {
  Future<Food?> fetchData() async {
    final url = Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');

    final response = await http.get(url);
    Food? foodItems;

    if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);
      // var dat = foodFromJson(response.body);

      foodItems = Food.fromJson(data[0]);
      return foodItems;
    } else {
      print(response.reasonPhrase);
      return foodItems;
    }
  }
}
