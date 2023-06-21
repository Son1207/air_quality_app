import 'package:air_quality_app/page/affect_detail.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../const.dart';
import '../models/city_model.dart';

class AirQualityHomePage extends StatefulWidget {
  const AirQualityHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AirQualityHomePageState createState() => _AirQualityHomePageState();
}

class _AirQualityHomePageState extends State<AirQualityHomePage> {
  List<City> cities = [];
  String keyword = '';
  bool isSearching = false;
  bool isButtonPressed = false;

  Future<List<City>> searchCities(String keyword) async {
    final response = await http.get(
      Uri.parse(
          'http://api.waqi.info/search/?keyword=$keyword&token=abbd4584dc50636cd76cc43c1e4adeaed1ce525d'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> citiesData = data['data'];
      List<City> cities = [];

      for (var cityData in citiesData) {
        if (cityData['aqi'] != '-') {
          int aqi = int.parse(cityData['aqi']);
          String cityName = cityData['station']['name'];
          String tz = cityData['time']['tz'].split(" ")[0];
          String stime = cityData['time']['stime'].split(" ")[0];
          int vtime = cityData['time']['vtime'];
          City city = City(cityName, aqi, tz, stime, vtime);
          cities.add(city);
        }
      }

      return cities;
    } else {
      throw Exception('Failed to search cities');
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the searchCities function when entering the screen and no search keyword is provided to get default data for London
    if (keyword.isEmpty) {
      searchCities('Ho Chi Minh City').then((foundCities) {
        setState(() {
          cities = foundCities;
        });
      });
    }
  }

  void handleSearch(String value) {
    setState(() {
      keyword = value;
    });

    if (value.isNotEmpty) {
      setState(() {
        isSearching = true;
      });

      searchCities(value).then((foundCities) {
        setState(() {
          cities = foundCities;
          isSearching = false;
        });
      });
    } else {
      setState(() {
        cities = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AirVisual'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: handleSearch,
              decoration: const InputDecoration(
                labelText: 'Search City',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                filled: true,
              ),
            ),
          ),
          if (isSearching)
            const Center(child: CircularProgressIndicator())
          else if (cities.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return buildCityCard(cities[index]);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget buildCityCard(City city) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8, 0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipOval(
                  child: Container(
                    width: 400,
                    height: 400,
                    color: Colors.blue[400],
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AffectDetailsPage.routeName,
                          arguments: city.aqi,
                        );
                      },
                      child: SfRadialGauge(
                        // Radial gauge configuration
                        axes: <RadialAxis>[
                          RadialAxis(
                            showLabels: false,
                            showTicks: false,
                            minimum: 0,
                            maximum: 400,
                            axisLineStyle: const AxisLineStyle(
                              thickness: 10,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Colors.white54,
                            ),
                            ranges: <GaugeRange>[
                              GaugeRange(
                                startValue: 0,
                                endValue: city.aqi.toDouble(),
                                color: getRangeColor(city.aqi),
                              ),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                // Custom annotation widget inside the gauge
                                widget: Column(
                                  children: [
                                    Text(
                                      city.aqi.toString(),
                                      style: const TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    getAffect(city.aqi),
                                    Text(
                                      'Updated: ${city.stime.toString()}',
                                      style: const TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                    const SizedBox(height: 80,),
                                  ],
                                ),
                                angle: 90,
                                positionFactor: 0.4,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom:-80,
                  child: ClipOval(
                    child: Container(
                      height: 200,
                      width: 200,
                      color: Colors.white54,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Column(
                          children: [

                            IconButton(
                              iconSize: 35,
                              icon: Icon(
                                Icons.add_location,
                                color: isButtonPressed ? Colors.orange : Colors.black,
                              ),
                              onPressed: () async {
                                setState(() {
                                  isButtonPressed = !isButtonPressed;
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10,10,10,20),
                              child: Text(
                                city.name,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.brown,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
