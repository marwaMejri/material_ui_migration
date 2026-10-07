import 'package:flutter/material.dart';

/// Holds the locale the user picked, and nothing else.
///
/// A `ValueNotifier` on purpose: this project has no third-party dependency,
/// so the migration result cannot be blamed on a state management package.
class LocaleController extends ValueNotifier<Locale> {
  LocaleController(super.value);

  void select(Locale locale) {
    if (locale != value) {
      value = locale;
    }
  }
}

/// Exposes the [LocaleController] to the widget tree.
///
/// `InheritedNotifier` rebuilds its dependents when the notifier fires, which
/// is how switching the language at runtime reaches `MaterialApp.locale`.
class LocaleScope extends InheritedNotifier<LocaleController> {
  const LocaleScope({
    super.key,
    required LocaleController super.notifier,
    required super.child,
  });

  static LocaleController of(BuildContext context) {
    final LocaleScope? scope =
        context.dependOnInheritedWidgetOfExactType<LocaleScope>();
    assert(scope != null, 'No LocaleScope found above this context.');
    return scope!.notifier!;
  }
}
