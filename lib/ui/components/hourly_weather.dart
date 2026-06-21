import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_model.dart';

class HourlyWeather extends StatelessWidget {
  final Hour? hour;
  const HourlyWeather({super.key, this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  hour?.tempC?.round().toString() ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text("o", style: TextStyle(color: Colors.white)),
            ],
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.teal,
            ),
            child: Image.network("http:${hour?.condition?.icon}"),
          ),
          Text(
            DateFormat.j().format(DateTime.parse(hour?.time?.toString() ?? ""),),
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
