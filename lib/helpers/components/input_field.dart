import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/util_helpers.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final String title;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final TextEditingController? controller;
  final VoidCallback? validator;
  final Function(String)? onChanged;
  final Widget? prefix;
  final Widget? suffix;
  bool digitOnly, passwordInput, readOnly;
  int maxLine;
  final double titleSpacing;

  InputField(
      {Key? key,
      this.hintText = "",
      this.title = "",
      this.titleFontSize = 14.0,
      this.titleFontWeight = FontWeight.w400,
      this.titleSpacing = 10,
      this.controller,
      this.validator,
      this.onChanged,
      this.prefix,
      this.suffix,
      this.digitOnly = false,
      this.passwordInput = false,
      this.readOnly = false,
      this.maxLine = 1})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != ""
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: textStyle.copyWith(
                          color: textColor,
                          fontSize: widget.titleFontSize,
                          fontWeight: widget.titleFontWeight,
                        )),
                    SizedBox(
                      height: widget.titleSpacing,
                    ),
                  ],
                )
              : const Text(""),
          SizedBox(
            child: TextFormField(
              style: textStyle.copyWith(
                color: widget.readOnly ? Colors.grey : textColor,
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
              onChanged: widget.onChanged,
              maxLines: widget.maxLine,

              readOnly: widget.readOnly,
              obscureText: widget.passwordInput,
              keyboardType: widget.digitOnly
                  ? TextInputType.phone
                  : widget.maxLine == 1
                      ? TextInputType.text
                      : TextInputType.multiline,
              // textCapitalization:TextCapitalization.words,
              inputFormatters: widget.digitOnly
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : null, // Only numbers can be entered
              // textCapitalization: TextCapitalization.sentences,
              decoration: secondaryDecoration.copyWith(
                hintText: widget.hintText,
                hintStyle: textStyle.copyWith(
                  color: const Color(0xff818181),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                // prefix: widget.prefix ?? null,
                suffix: widget.suffix,
                fillColor: inputFieldBoderColorBg,
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              controller: widget.controller,
              validator: validateInput,
            ),
          ),
        ],
      ),
    );
  }

  String? validateInput(String? value) {
    if (value!.trim().isEmpty) {
      return '* required';
    }
    return null;
  }
}
