import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:elib/helpers/colors.dart';

class NairaSign extends StatelessWidget {
  final double? height;
  final Color? color;
  NairaSign({this.height = 22.0, this.color = bluePrimaryColor});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/currency/naira.svg",
      color: color!,
      height: height!,
    );
  }
}
