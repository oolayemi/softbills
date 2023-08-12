import 'package:flutter/material.dart';

///Custom class for scaling text sizes, margins and everything that needs to be responsive across different screens
//use this class for dimensions
class SizeConfig{

  static double yMargin(BuildContext context, double height){
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait) {
      //print(MediaQuery.of(context).size.height.toString());
      //print(MediaQuery.of(context).size.width.toString());
      double screenHeight =  MediaQuery.of(context).size.height/ 100;
      return height * screenHeight;
    } else {
      double screenHeight =  MediaQuery.of(context).size.width/ 100;
      return height * screenHeight;
    }
  }
  static double xMargin(BuildContext context, double width){
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait) {
      double screenHeight =  MediaQuery.of(context).size.width/ 100;
      return width * screenHeight;
    } else {
      double screenHeight =  MediaQuery.of(context).size.height/ 100;
      return width * screenHeight;
    }
  }

  static double textSize(BuildContext context, double textSize){
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait) {
      double screenHeight =  MediaQuery.of(context).size.height/ 100;
      return textSize * screenHeight;
    } else {
      double screenHeight =  MediaQuery.of(context).size.width/ 100;
      return textSize * screenHeight;
    }
  }

  static double getYSize(BuildContext context, double size) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait) {
      return size / (MediaQuery.of(context).size.height/ 100);
    } else {
      return size / (MediaQuery.of(context).size.width/ 100);
    }
  }

  static double getXSize(BuildContext context, double size) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait) {
      return size / (MediaQuery.of(context).size.width/ 100);
    } else {
      return size / (MediaQuery.of(context).size.height/ 100);
    }
  }

}