import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'const.dart';
import 'models/city_model.dart';

void main() => runApp(const AirQualityApp());

class AirQualityApp extends StatelessWidget {
  const AirQualityApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const AirQualityHomePage(),
    );
  }
}

class AirQualityHomePage extends StatefulWidget {
  const AirQualityHomePage({Key? key}) : super(key: key);

  @override
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
          City city = City(cityName, aqi);
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
    // Gọi hàm searchCities khi mới vào màn hình và chưa tìm kiếm để lấy dữ liệu mặc định cho Hồ Chí Minh
    if (keyword.isEmpty) {
      searchCities('LonDon').then((foundCities) {
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
        title: const Center(child: Text('AirVisual')),
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
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              padding: const EdgeInsets.all(70.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getAqiColor(cities[0].aqi),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    cities[0].name,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: getNameColor(cities[0].aqi),
                    ),
                  ),
                  Text(
                    cities[0].aqi.toString(),
                    style: TextStyle(
                      fontSize: 60.0,
                      color: getNameColor(cities[0].aqi),
                    ),
                  ),
                  getAffect(cities[0].aqi),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
