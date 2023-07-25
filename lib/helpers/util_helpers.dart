import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:elib/helpers/colors.dart';
import 'package:intl/intl.dart';

var formatter = NumberFormat.decimalPattern('en_us');
const secondaryDecoration = InputDecoration(
    contentPadding: EdgeInsets.all(20.0),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: inputFieldBoderColor, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(2))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: inputFieldBoderColor, width: 0.4),
        borderRadius: BorderRadius.all(Radius.circular(2))),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: inputFieldBoderColor, width: 0.4),
        borderRadius: BorderRadius.all(Radius.circular(2))),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: inputFieldBoderColor, width: 0.4),
        borderRadius: BorderRadius.all(Radius.circular(2))),
    filled: true,

    // fillColor: Color.fromRGBO(196, 196, 196, 0.1),
    fillColor: inputFieldBoderColor,
    hintStyle: TextStyle(color: Colors.black));

const secondaryDecorationForSearch = InputDecoration(
    contentPadding: EdgeInsets.only(top: 5),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    filled: true,

    // fillColor: Color.fromRGBO(196, 196, 196, 0.1),
    fillColor: Colors.transparent,
    hintStyle: TextStyle(color: Colors.black));
// const baseUrl = 'https://elib.elib.com';
FirebaseFirestore firestore = FirebaseFirestore.instance;
