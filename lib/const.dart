import 'package:flutter/material.dart';

Color getAqiColor(int aqi) {
  if (aqi < 50) {
    return const Color(0xFF00e400);
  } else if (aqi < 100) {
    return const Color(0xFFffff00);
  } else if (aqi < 150) {
    return const Color(0xFFff7e00);
  } else if (aqi < 200) {
    return const Color(0xFFff0000);
  } else if (aqi < 300) {
    return const Color(0xFF99004c);
  } else {
    return const Color(0xFF7e0023);
  }
}

Color getNameColor(int aqi) {
  if (aqi < 50) {
    return Colors.white;
  } else if (aqi < 100) {
    return Colors.black;
  } else {
    return Colors.white;
  }
}

Color getNameColor1(int aqi) {
  if (aqi < 50) {
    return Colors.black;
  } else if (aqi < 100) {
    return Colors.black;
  } else {
    return Colors.black;
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
        color: Colors.black,
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


