import 'package:flutter/material.dart';
import 'package:neon/neon.dart';

import '../constants.dart';

class LyricsScreen extends StatelessWidget {
  const LyricsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg2.webp'),
                    fit: BoxFit.fill)),
            child: resultController.responseModel.result!.lyrics?['lyrics']! ==
                        null ||
                    resultController.responseModel.result!.lyrics?['lyrics']! ==
                        ''
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Neon(
                          text: 'No lyrics',
                          color: Colors.indigo,
                          fontSize: 36,
                          font: NeonFont.Automania,
                          flickeringText: true,
                          glowingDuration: const Duration(milliseconds: 1000),
                          flickeringLetters: const [0, 3, 4, 5, 6, 7, 8],
                        ),
                      ),
                      FittedBox(
                        child: Neon(
                          text: 'found for this song',
                          color: Colors.pink,
                          fontSize: 24,
                          font: NeonFont.Beon,
                          flickeringText: false,
                          glowingDuration: const Duration(milliseconds: 6000),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(5),
                    child: SingleChildScrollView(
                      child: Text(
                        resultController.responseModel.result!.lyrics!['lyrics']
                            .toString(),
                        style: TextStyle(
                            color: Colors.indigo.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  )),
      ),
    );
  }
}
