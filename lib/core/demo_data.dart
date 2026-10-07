/// Fixed values so every screen and every test shows the same numbers.
///
/// Hard-coded on purpose: this project has no repository, no network and no
/// third-party dependency, so nothing but the migration itself can change the
/// result.
abstract final class DemoData {
  static const int residents = 42;
  static final DateTime lastSync = DateTime(2026, 10, 3);
}
