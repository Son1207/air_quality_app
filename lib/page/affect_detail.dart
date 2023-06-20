import 'package:flutter/material.dart';

import '../const.dart';

class AffectDetailsPage extends StatelessWidget {
  static const String routeName = '/affect_details';

  final int aqi;

  const AffectDetailsPage({Key? key, required this.aqi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Affect Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          child: Container(
            height: 500,
            color: getAqiColor(aqi),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getAffect(aqi),
                const SizedBox(height: 20,),
                Text(
                  getNumberAir(aqi),
                  style: TextStyle(fontSize: 32,color: getNameColor(aqi),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,60.0,8.0,0),
                  child: Text(
                    getDetailAffect(aqi),
                    style: TextStyle(
                      fontSize: 32,
                      color: getNameColor(aqi),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


String getDetailAffect(int aqi) {
  if (aqi >= 0 && aqi <= 50) {
    return 'Air quality is considered satisfactory, and air '
        'pollution poses little or no risk';
  } else if (aqi >= 51 && aqi <= 100) {
    return 'Air quality is acceptable; however, for some '
        'pollutants there may be a moderate health concern'
        ' for a very small number of people who are unusually '
        'sensitive to air pollution.';
  } else if (aqi >= 101 && aqi <= 150) {
    return 'Members of sensitive groups may experience '
        'health effects. The general public is not likely '
        'to be affected.';
  } else if (aqi >= 151 && aqi <= 200) {
    return 'Everyone may begin to experience health effects; '
        'members of sensitive groups may experience more '
        'serious health effects';
  } else if (aqi >= 201 && aqi <= 300) {
    return 'Health warnings of emergency conditions. '
        'The entire population is more likely to be affected.';
  } else {
    return 'Health alert: everyone may experience more '
        'serious health effects';
  }
}
String getNumberAir(int aqi) {
  if (aqi >= 0 && aqi <= 50) {
    return '(0-50)';
  } else if (aqi >= 51 && aqi <= 100) {
    return '(51-100)';
  } else if (aqi >= 101 && aqi <= 150) {
    return '(101-150)';
  } else if (aqi >= 151 && aqi <= 200) {
    return '(151-200)';
  } else if (aqi >= 201 && aqi <= 300) {
    return '(201-300)';
  } else {
    return '(<300)';
  }
}

Object getColorDetail(int aqi) {
  if (aqi >= 0 && aqi <= 50) {
    return Colors.white;
  } else if (aqi >= 51 && aqi <= 100) {
    return Colors.black;
  } else if (aqi >= 101 && aqi <= 150) {
    return Colors.white;
  } else if (aqi >= 151 && aqi <= 200) {
    return Colors.white;
  } else if (aqi >= 201 && aqi <= 300) {
    return Colors.white;
  } else {
    return Colors.white;
  }
}
