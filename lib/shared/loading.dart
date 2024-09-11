import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage("assets/startbackground.jpg"), // Add your image here
          fit: BoxFit.cover,
        ),
      ),
      //color: Colors.pink[100],
      child: const Center(
          child: SpinKitChasingDots(
        color: Colors.white,
        size: 250.0,
      )),
    );
  }
}
