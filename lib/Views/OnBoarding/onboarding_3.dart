// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Views/OnBoarding/Common/on_boarding.dart';

// ignore: must_be_immutable
class OnBoarding3View extends StatelessWidget {
  String title = "Connect & Converse with Solons";

  String subtitle = "Real time chats for effortless beauty consultations.";

  String imgPath = PathToImage.onBoard3;

  @override
  Widget build(BuildContext context) {
    return OnBoarding(path: imgPath, title: title, subtitle: subtitle);
  }
}
