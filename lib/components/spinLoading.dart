import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loader() {
  return SpinKitWave(
    itemBuilder: (_, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.blue : Colors.green,
        ),
      );
    },
  );
}

final spinkit2 = SpinKitSquareCircle(
  color: Colors.white,
  size: 50.0,
);

final spinkit3 = SpinKitDoubleBounce(
  color: Colors.blue,
  size: 50.0,
);
