// ignore_for_file: prefer_constructors_over_static_methods

class ResponsibilityConstants {
  ResponsibilityConstants._init();
  static ResponsibilityConstants? _instace;
  static ResponsibilityConstants get instance {
    if (_instace != null) {
      return _instace!;
    }

    _instace = ResponsibilityConstants._init();
    return _instace!;
  }

  final smallScreenSize = 300;
  final mediumScreenSize = 600;
  final largeScreenSize = 900;
}
