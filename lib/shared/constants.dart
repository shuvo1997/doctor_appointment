import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2.0)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0)));

var borderRadius = BorderRadius.circular(10.0);
