class SplashLogoResponsive {
  final double screenWidth;

  SplashLogoResponsive(this.screenWidth);

  double get imgWidth {
    if (screenWidth < 300) {
      return 120.0;
    } else if (screenWidth < 350) {
      return 250.0;
    } else {
      return 200.0;
    }
  }

  double get imgHeight {
    if (screenWidth < 300) {
      return 80.0;
    } else if (screenWidth < 350) {
      return 300.0;
    } else {
      return 200.0;
    }
  }
}
