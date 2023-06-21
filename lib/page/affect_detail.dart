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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),

            child: Align(
              alignment: Alignment.topCenter,

                child: Container(
                  height: 400,
                  width: 400,
                  color: getRangeColor(aqi),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10,),
                      getAffectDetail(aqi),
                      const SizedBox(height: 20,),
                      Text(
                        getNumberAir(aqi),
                        style: TextStyle(fontSize: 28,color: getNameColor(aqi),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,40.0,8.0,0),
                        child: Text(
                          getDetailAffect(aqi),
                          style: TextStyle(
                            fontSize: 26,
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
      ),
    );
  }
}



