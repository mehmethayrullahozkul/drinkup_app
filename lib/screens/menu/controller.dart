class MenuController {
  static MenuController instance = MenuController();

  final double _targetWaterIntake = 2000;
  final double _currentWaterIntake = 0;
  final double _leftWaterIntake = 2000;
  final double _waterProgress = 0.0;

  MenuController._internal();

  static final MenuController _singleton = MenuController._internal();

  factory MenuController() {
    return _singleton;
  }
  double get targetWaterIntake => _targetWaterIntake;
  final Duration animDuration = const Duration(milliseconds: 250);
  bool _isMenuOpen = false;
  bool get isMenuOpen => _isMenuOpen;

  void toggle() => _isMenuOpen = !_isMenuOpen;
  void close() => _isMenuOpen = false;
  void open() => _isMenuOpen = true;
}
