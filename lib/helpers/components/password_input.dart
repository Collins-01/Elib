import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/util_helpers.dart';

class PasswordInput extends StatefulWidget {
  final String? hintText;
  final String? title;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final double titleSpacing;
  final TextEditingController? controller;
  final Function? validator;
  bool readOnly;
  bool hidePassword;

  PasswordInput(
      {this.hintText,
      this.title,
      this.titleFontSize = 14.0,
      this.titleFontWeight = FontWeight.w400,
      this.titleSpacing = 10,
      this.controller,
      this.readOnly = false,
      this.hidePassword = true,
      this.validator});

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != ""
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title!,
                      style: textStyle(
                          color: textColor,
                          fontSize: widget.titleFontSize,
                          fontWeight: widget.titleFontWeight),
                    ),
                    SizedBox(
                      height: widget.titleSpacing,
                    ),
                  ],
                )
              : const Text(""),
          SizedBox(
            // height: 60,
            child: TextFormField(
              obscureText: widget.hidePassword,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.visiblePassword,
              readOnly: widget.readOnly,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: textStyle(color: textColor),
              decoration: secondaryDecoration.copyWith(
                hintText: widget.hintText,
                hintStyle: textStyle(
                    color: const Color(0xff818181),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
                fillColor: inputFieldBoderColorBg,
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              controller: widget.controller,
              validator: validateMobile,
            ),
          )
        ],
      ),
    );
  }

  String? validateMobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value!.length == 0) {
      return '*Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return '*Please enter valid mobile number';
    }
    return null;
  }
}
