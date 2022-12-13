import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

Widget resultList() => Expanded(
      child: ListView.builder(
          itemCount: resultController.results.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final result = resultController.results[index];
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.20),
                border: Border.all(color: Colors.indigo),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/${result.title}.png',
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: 150,
                ),
                trailing: Container(
                  height: 35,
                  width: 60,
                  decoration: const BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Center(
                    child: Text(
                      'Listen',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onTap: () async {
                  final Uri _url = Uri.parse(result.url.toString());

                  if (await canLaunchUrl(_url)) {
                    await launchUrl(_url, mode: LaunchMode.externalApplication);
                  } else {
                    Get.defaultDialog(
                        title: "Couldn't launch url",
                        middleText: "The request url is invalid");
                  }
                },
              ),
            );
          }),
    );
