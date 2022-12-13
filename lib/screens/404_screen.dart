import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neon/neon.dart';
import 'package:rive/rive.dart';

import '/constants.dart';

class NotFound extends StatefulWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  State<NotFound> createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  late RiveAnimationController _controller;
  @override
  void initState() {
    _controller = SimpleAnimation('Animation_no_records');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade100,
        body: WillPopScope(
            onWillPop: () async {
              resultController.onClose();
              Get.toNamed('/home');
              return false;
            },
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg2.webp'),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0, right: 10, left: 10),
                child: Column(
                  children: [
                    FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Neon(
                          text: 'Song Not Found',
                          color: Colors.indigo,
                          fontSize: 36,
                          font: NeonFont.Membra,
                          flickeringText: true,
                          flickeringLetters: const [0, 5, 9, 10, 11, 12, 13],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .5,
                      child: RiveAnimation.network(
                        'https://public.rive.app/community/runtime-files/1233-2377-no-records.riv',
                        controllers: [_controller],
                        onInit: (_) => setState(() {
                          _controller.isActive;
                        }),
                        placeHolder: RiveAnimation.asset(
                          'assets/rive/loading.riv',
                          controllers: [homeController.loading],
                          // Update the play state when the widget's initialized
                          onInit: (_) => setState(() {
                            homeController.loading.isActive;
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
