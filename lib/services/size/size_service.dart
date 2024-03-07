class SizeService {
  SizeService._();

  static SizeService _instance = SizeService._();

  factory SizeService() => _instance;

  double screenWidth = 0;
  double screenHeight = 0;
  double iconSize = 24;
  double fontSize = 12;
  double heightUnit = 0;
  double widthUnit = 0;

  /* void setScreenSize(double width, double height) {
    screenWidth = width;
    screenHeight = height;
  } */

  void load({required double logicalWidth, required double logicalHeight}) {
    screenWidth = logicalWidth;
    screenHeight = logicalHeight;
    heightUnit = logicalHeight / 16;
    widthUnit = logicalWidth / 16;

    if (logicalWidth > 500) {
      if (logicalHeight > 1000) {
        fontSize = 20;
      } else if (logicalHeight > 800) {
        fontSize = 18;
      } else if (logicalHeight > 600) {
        fontSize = 16;
      } else if (logicalHeight > 400) {
        fontSize = 14;
      } else if (logicalHeight > 300) {
        fontSize = 12;
      } else {
        fontSize = 10;
      }
    } else if (logicalWidth > 400) {
      if (logicalHeight > 1000) {
        fontSize = 18;
      } else if (logicalHeight > 800) {
        fontSize = 16;
      } else if (logicalHeight > 600) {
        fontSize = 14;
      } else if (logicalHeight > 400) {
        fontSize = 12;
      } else if (logicalHeight > 300) {
        fontSize = 10;
      } else {
        fontSize = 8;
      }
    } else if (logicalWidth > 300) {
      if (logicalHeight > 1000) {
        fontSize = 14;
      } else if (logicalHeight > 800) {
        fontSize = 12;
      } else if (logicalHeight > 600) {
        fontSize = 11;
      } else if (logicalHeight > 400) {
        fontSize = 10;
      } else if (logicalHeight > 300) {
        fontSize = 10;
      } else {
        fontSize = 6;
      }
    } else if (logicalWidth > 300) {
      if (logicalHeight > 1000) {
        fontSize = 13;
      } else if (logicalHeight > 800) {
        fontSize = 12;
      } else if (logicalHeight > 600) {
        fontSize = 11;
      } else if (logicalHeight > 400) {
        fontSize = 10;
      } else if (logicalHeight > 300) {
        fontSize = 10;
      } else {
        fontSize = 6;
      }
    } else {
      fontSize = 18;
    }
    iconSize = fontSize * 2;
  }
}
