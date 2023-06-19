import 'package:flutter/material.dart';

Color getAqiColor(int aqi) {
  if (aqi < 50) {
    return Colors.green;
  } else if (aqi < 100) {
    return Colors.yellow;
  } else {
    return Colors.red;
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

Text getAffect(int aqi){
  if (aqi < 50) {
    return const Text('Good',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,color: Colors.white),);
  } else if (aqi < 100) {
    return const Text('Moderate',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,color: Colors.black),);
  } else {
    return const Text('Unhealthy',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,color: Colors.white),);
  }
}