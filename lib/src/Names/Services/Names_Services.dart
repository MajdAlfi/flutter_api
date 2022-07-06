import 'package:flutter/material.dart';
import 'package:flutter_api/src/Names/Models/Models.dart';
import 'package:flutter_api/src/Names/Models/get_set_data.dart';
import 'package:flutter_api/src/Names/Screens/Display_names_Screen.dart';
import 'package:http/http.dart' as http;

class namesServices {
  Future<Names_Kurd> fetchListNames() async {
    MyApp _appSrc = MyApp();
    Uri _NamesUri = Uri(
        scheme: "https",
        host: "nawikurdi.com",
        path: "api",
        queryParameters: {
          "limit": Values.LimitV,
          "gender": Values.GenderV,
          "sort": Values.SortV,
          "offset": "0"
        });

    http.Response _response =
        await http.get(_NamesUri).catchError((err) => print(err));
    Names_Kurd _JsNames = Names_Kurd.fromJson(_response.body);
    return _JsNames;
  }
}
