import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/api_service.dart';
import 'package:weather_app/ui/components/future_forecast_listitem.dart';
import 'package:weather_app/ui/components/hourly_weather.dart';
import 'package:weather_app/ui/components/todays_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  final _textFieldController = TextEditingController();
  String searchText = "auto:ip";
  _showTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Search location"),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(
              hintText: "search by city,zip,lang,lat",
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(onPressed: (){
              if(_textFieldController.text.isEmpty){
                return;
              }
              Navigator.pop(context,_textFieldController.text);
            }, child: Text("ok"),),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: () async{
            _textFieldController.clear();
            String text = await _showTextInputDialog(context);
            setState(() {
              searchText = text;
            });
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: () {
            searchText = "auto:ip";
            setState(() {

            });
          }, icon: Icon(Icons.my_location)),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;
              return SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      TodaysWeather(weatherModel: weatherModel),
                      SizedBox(height: 10),
                      Text(
                        "Weather by hours",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            Hour? hour = weatherModel
                                ?.forecast
                                ?.forecastday?[0]
                                .hour?[index];
                            return HourlyWeather(hour: hour);
                          },
                          itemCount:
                              weatherModel
                                  ?.forecast
                                  ?.forecastday?[0]
                                  .hour
                                  ?.length ??
                              0,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Next 7 days weather",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Forecastday? forecastday =
                              weatherModel?.forecast?.forecastday?[index];
                          return FutureForecastListitem(
                            forecastday: forecastday,
                          );
                        },
                        itemCount: weatherModel?.forecast?.forecastday?.length,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error has occurred"));
            }
            return Center(child: CircularProgressIndicator());
          },
          future: apiService.getWeatherData(searchText),
        ),
      ),
    );
  }
}
