import 'package:flutter/material.dart';

Color getNameColor(int aqi) {
  if (aqi < 50) {
    return Colors.white;
  } else if (aqi < 100) {
    return Colors.black;
  } else {
    return Colors.white;
  }
}


Text getAffect(int aqi) {
  if (aqi < 50) {
    return const Text(
      'Good',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
  } else if (aqi < 100) {
    return const Text(
      'Moderate',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white ,
      ),
    );
  } else if (aqi < 150) {
    return const Text(
      'Unhealthy',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
  } else if (aqi < 200) {
    return const Text(
      'Unhealthy',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
  } else if (aqi < 300) {
    return const Text(
      'Very Unhealthy',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
  } else {
    return const Text(
      'Hazardous',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
  }
}

Text getAffectDetail(int aqi) {
  if (aqi < 50) {
    return const Text(
      'Good',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
  } else if (aqi < 100) {
    return const Text(
      'Moderate',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.black ,
      ),
    );
  } else if (aqi < 150) {
    return const Text(
      'Unhealthy',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
  } else if (aqi < 200) {
    return const Text(
      'Unhealthy',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
  } else if (aqi < 300) {
    return const Text(
      'Very Unhealthy',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
  } else {
    return const Text(
      'Hazardous',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
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

Color getRangeColor(int aqi) {
  if (aqi >= 0 && aqi <= 50) {
    return const Color(0xFF00e400); // Change the color for the range 0-50
  } else if (aqi >= 51 && aqi <= 100) {
    return const Color(0xFFffff00); // Change the color for the range 51-100
  } else if (aqi >= 101 && aqi <= 150) {
    return const Color(0xFFff7e00); // Change the color for the range 101-150
  } else if (aqi >= 151 && aqi <= 200) {
    return const Color(0xFFff0000); // Change the color for the range 151-200
  } else if (aqi >= 201 && aqi <= 300) {
    return const Color(0xFF99004c); // Change the color for the range 201-300
  } else {
    return const Color(0xFF7e0023); // Change the color for values above 300
  }
}

String getDetailAffect(int aqi) {
  if (aqi >= 0 && aqi <= 50) {
    return 'Air quality is considered satisfactory, and air pollution poses '
        'little or no risk';
  } else if (aqi >= 51 && aqi <= 100) {
    return 'Air quality is acceptable; however, for some pollutants there may '
        'be a moderate health concern for a very small number of people who '
        'are unusually sensitive to air pollution.';
  } else if (aqi >= 101 && aqi <= 150) {
    return 'Members of sensitive groups may experience health effects. '
        'The general public is not likely to be affected.';
  } else if (aqi >= 151 && aqi <= 200) {
    return 'Everyone may begin to experience health effects; members of '
        'sensitive groups may experience more serious health effects';
  } else if (aqi >= 201 && aqi <= 300) {
    return 'Health warnings of emergency conditions. '
        'The entire population is more likely to be affected.';
  } else {
    return 'Health alert: everyone may experience more serious health effects';
  }
}


