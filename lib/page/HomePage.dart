import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      searchCities('VietNam').then((foundCities) {
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
                itemCount: cities.length,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: getAqiColor(city.aqi),
                ),
                child: Column(
                  children: [
                    Text(
                      city.name,
                      maxLines: 3,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: getNameColor(city.aqi),
                      ),
                    ),
                    Text(
                      city.aqi.toString(),
                      style: TextStyle(
                        fontSize: 40.0,
                        color: getNameColor(city.aqi),
                      ),
                    ),
                    getAffect(city.aqi),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0,8.0,0,0),
                      child: Image(image: AssetImage('assets/image/timezone.png'),width: 20,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4.0,8.0,0,0),
                      child: Text(
                        'Timezone: ${city.tz}',style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0,8.0,0,0),
                      child: Image(image: AssetImage('assets/image/time.png'),width: 20,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4.0,8.0,0,0),
                      child: Text(
                        'Local Time: ${city.stime}',style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0,8.0,0,0),
                      child: Image(image: AssetImage('assets/image/clock.png'),width: 20,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4.0,8.0,0,0),
                      child: Text(
                        'Numeric Time: ${city.vtime}',style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
