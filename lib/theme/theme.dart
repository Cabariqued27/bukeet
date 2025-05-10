import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTheme extends GetxController {
  var primary = const Color(0xff88B9A1).obs;
  var secondary = const Color(0xffF9EEC6).obs;
  var bordermedPrimary = const Color.fromARGB(255, 255, 195, 223).obs;
  var bordermedSecondary = const Color.fromARGB(255, 255, 248, 215).obs;
  var borderPrimary = const Color.fromARGB(255, 255, 217, 235).obs;
  var borderSecondary = const Color.fromARGB(255, 255, 250, 228).obs;
  var backgroundProfile = const Color.fromARGB(109, 255, 255, 255).obs;
  var transparentPink = const Color.fromARGB(80, 253, 201, 205).obs;
  var transparentYellow = const Color.fromARGB(80, 249, 238, 198).obs;
  var background = const Color(0xffFFFFFF).obs;
  var onBackground = const Color(0xffFAFAFA).obs;
  var datePickerIconColor = const Color(0xffA0A0A0).obs;
  var mustHaveColorText = const Color(0xff959595).obs;
  var text = const Color(0xff3C4247).obs;
  var textStarted = const Color(0xff090909).withOpacity(0.51).obs;
  var whiteText = const Color(0xffFFFFFF).obs;
  var onText = const Color(0xffD7D7DB).obs;
  var black = const Color(0xff000000).obs;
  var disable = const Color(0xffFAFAFA).obs;
  var gray = const Color(0xff7A7A7A).obs;
  var lineGraphProfile = const Color(0xffDFDFE1).withOpacity(0.4).obs;
  var secondGray = const Color(0xff5E5E5E).obs;
  var grayAccent = const Color(0xffEAEAEA).obs;
  var streakDay = const Color(0xffD6849C).obs;
  var pinkAccent = const Color(0xffFFEDF6).obs;
  var surface = const Color(0xffF2F2F2).obs;
  var dotMockSlider = const Color(0xffC2B8D2).obs;
  var tYellow = const Color(0xffF9EEC6).withOpacity(0.01).obs;
  var tGreen = const Color(0xffAEDAC2).withOpacity(0.01).obs;
  var tPink = const Color(0xffFFA9D3).withOpacity(0.01).obs;
  var white = const Color.fromARGB(255, 255, 255, 255).obs;
  var transparent = const Color.fromARGB(0, 122, 122, 122).obs;
  var numberDayColor = const Color(0xffF982BC).obs;
  var itemBorder = const Color(0xffE6E6E6).obs;
  var weekDayColor = const Color(0xff3C3C43).withOpacity(0.3).obs;
  var profileColorTitles = const Color(0xff000000).withOpacity(0.3).obs;
  var congratulationDisableGraph =
      const Color(0xff000000).withOpacity(0.62).obs;
  var valueBattery = const Color(0xff3C3C43).withOpacity(0.6).obs;
  var weekendDayColor = const Color(0xff3C3C43).withOpacity(0.1).obs;
  var deviceItemTextColor = const Color(0xff565656).obs;
  var refreshColor = const Color(0xff4E856C).obs;
  var refreshBackground = const Color(0xffCFE7D8).obs;
  var notyourDevice = const Color(0xff6E6E6E).obs;
  var grayDark = const Color(0xff363636).obs;
  var preSessionColorTextRefresh = const Color(0xff5B967B).obs;
  var rightArrorExploreColor = const Color(0xffF6C3C7).obs;

  var purpleMin = const Color(0xff917FB5).obs;
  var greenMin = const Color(0xff5AAFA9).obs;
  var blueMin = const Color(0xff679CD2).obs;

  var greenSolid = const Color(0xff6BD194).obs;
  var yellowSolid = const Color(0xffDB9D36).obs;
  var redSolid = const Color(0xffD86D81).obs;
  var purpleSolid = const Color(0xffA07ED9).obs;
  var blueSolid = const Color(0xff529CD9).obs;

  var exploreRefresh = const Color(0xff88B9A1).obs;
  var exploreEnergy = const Color(0xffCA7181).obs;
  var exploreFocus = const Color(0xffDC9B4C).obs;

  var exerciseDay = const Color(0xffFAF3E8).obs;

  var sessionWithOutDevice = const Color(0xff999999).obs;

  var codeInputBorder = const LinearGradient(
    colors: [Color(0xffF9EEC6), Color(0xffFDC9CD), Color(0xffFFA9D3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ).obs;

  var circlesPair = const LinearGradient(
    colors: [Color(0xffF9EEC6), Color(0xffFDC9CD), Color(0xffFFA9D3)],
  ).obs;

  var softPurple = const Color(0xffE6DEF3).obs;
  var borderSoftPurple = const Color(0xff917FB5).obs;
  var backgroundDeviceSetting = const Color(0xffF4F4F4).obs;
  var gradientPair = const Color(0xffFDC9CD).obs;

  var relaxedGradient = const LinearGradient(
    colors: [
      Color(0xff529CD9),
      Color.fromARGB(255, 222, 226, 239),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ).obs;

  var balancedGradient = const LinearGradient(
    colors: [
      Color(0xff6BD194),
      Color.fromARGB(255, 222, 239, 226),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ).obs;

  var centeredGradient = const LinearGradient(
    colors: [
      Color(0xffB7C1E5),
      Color(0xffB29ACC),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ).obs;

  var toogleGradient = const LinearGradient(
    colors: [
      Color(0xffF9EEC6),
      Color.fromARGB(255, 255, 215, 215),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ).obs;

  var repeatExerciseGradient = const LinearGradient(
    colors: [
      Color(0xff363636),
      Color(0xff363636),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ).obs;

  var whiteGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 255, 255, 255),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ).obs;

  var purpleGradient = const LinearGradient(
    colors: [
      Color(0xffE6DEF3),
      Color(0xffE6DEF3),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ).obs;

  var refreshGradient = const LinearGradient(
    colors: [
      Color(0xffE3F2EB),
      Color(0xffB3DAC3),
      Color(0xff7FAF95),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ).obs;

  var refreshGradientMenu = const LinearGradient(
    colors: [
      Color(0xff7FAF95),
    ],
    stops: [1],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ).obs;

  var disableGradient = const LinearGradient(
    colors: [
      Color.fromARGB(109, 255, 255, 255),
      Color.fromARGB(109, 255, 255, 255),
      Color.fromARGB(109, 255, 255, 255),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ).obs;

  var refreshCongratulationColor = const LinearGradient(
    colors: [
      Color(0xffCFE7D8),
      Color(0xffCFE7D8),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ).obs;

  var refreshBackgroundExplore = const LinearGradient(
    colors: [
      Color(0xff88BAA2),
      Color(0xff98D6D2),
    ],
    stops: [
      0.2,
      0.8,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ).obs;
  var balanceBackgroundExplore = const LinearGradient(
    colors: [
      Color(0xffA4C1DF),
      Color(0xff8EBDD7),
    ],
    stops: [
      0.2,
      0.8,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ).obs;
  var relaxBackgroundExplore = const LinearGradient(
    colors: [
      Color(0xffC1BAD4),
      Color(0xff8EBDD7),
    ],
    stops: [
      0.2,
      0.8,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ).obs;

  var focusBackgroundExplore = const LinearGradient(
    colors: [
      Color(0xffE8D591),
      Color(0xffFDC9CD),
    ],
    stops: [
      0.2,
      0.8,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ).obs;
  var centeredBackgroundExplore = const LinearGradient(
    colors: [
      Color(0xffB7C1E5),
      Color(0xffB29ACC),
    ],
    stops: [
      0.2,
      0.8,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ).obs;
  var whiteBackgroundExplore = const LinearGradient(
    colors: [
      Color.fromARGB(0, 255, 255, 255),
      Color.fromARGB(255, 255, 255, 255),
    ],
    stops: [
      0.2,
      0.8,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ).obs;
}
