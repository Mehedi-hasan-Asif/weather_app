import 'dart:convert';

import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  Future<WeatherModel>getWeatherData(String searchText)async{
    String url ="$baseUrl&q=$searchText&days=7";
    try{
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        Map<String,dynamic>json=jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;
      }else{
        throw("No data found");
      }

    }catch(e){
      throw e.toString();
    }


  }
}