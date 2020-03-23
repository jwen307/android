import 'package:flutter/material.dart';

const textInputDecoration =  InputDecoration(
  fillColor: Colors.white,
  filled: true,
  //When field is enabled
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white,width:2.0)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width:2.0)
  ),
);