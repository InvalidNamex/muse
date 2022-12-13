import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../constants.dart';

Center recordAnimation() {
  return Center(
      child: SizedBox(
    height: 250,
    width: 250,
    child: Stack(
      children: [
        RiveAnimation.asset(
          'assets/rive/now_playing.riv',
          placeHolder: Center(
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.indigo.shade100,
              child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/play.webp')),
            ),
          ),
          controllers: [homeController.nowPlaying],
        ),
        Center(
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.indigo.shade100,
            child: const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/play.webp')),
          ),
        ),
      ],
    ),
  ));
}
