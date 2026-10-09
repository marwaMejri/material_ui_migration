# material_ui_migration

A small Flutter app, migrated from the SDK's Material and Cupertino libraries to
the standalone [`material_ui`](https://pub.dev/packages/material_ui) and
[`cupertino_ui`](https://pub.dev/packages/cupertino_ui) packages, with every
step measured.

It is the companion repository of the article
**Can you migrate to `material_ui` yet?**

Tested with Flutter 3.47.6, Dart 3.13.5, `material_ui` 1.6.0 and
`cupertino_ui` 1.1.2.

## What the app contains, and why

The app has no third-party UI package, so the migration is the only thing that
can break it. Each piece below is there because the migration touches it.

| Piece | File | What it tests |
|---|---|---|
| Material and Cupertino widgets | `lib/features/` | the import rewrite done by `dart fix` |
| Translations from `.arb` files, and a language switcher | `lib/l10n/`, `lib/app/` | the localization delegates, in English and in French |
| A barrel file that `export`s both design libraries | `lib/core/ui.dart` | whether `dart fix` rewrites `export` directives |
| Widgets that take a `ColorScheme` or a `CupertinoThemeData` as an argument | `stat_card.dart`, `themed_badge.dart` | the type mismatch the compatibility bridge cannot fix |
| A file meant to be left behind on purpose | `lib/features/legacy/legacy_summary.dart` | what happens when one file stays on the old import |

## Tags

| Tag | State |
|---|---|
| `first-app-without-migration` | the app before the migration, on `package:flutter/material.dart` |
| `after-dart-fix` | right after `dart fix --apply --code=migrate_design_widgets`. **Does not compile**, on purpose: this is what the tool leaves behind |
| `after-localizations-fix` | after the one manual fix, the localization delegates |

`main` goes further: version constraints instead of `any`, the barrel exports
migrated by hand, and the measurement files.

## Measurements

Every command output quoted in the article is saved in `measurements/`.

| File | What it shows |
|---|---|
| `before-deps.txt`, `before-outdated.txt` | the dependency tree before the migration |
| `02-dryrun.txt` | `dart fix --dry-run`: 17 proposed fixes in 14 files |
| `03-apply.txt` | the same 17 fixes, applied |
| `04-dartfix.diff` | exactly what `dart fix` changed |
| `05-analyze-before-pubget.txt`, `07-analyze.txt` | the only error after the tool: `ambiguous_import` |
| `06-pubget.txt` | dependency resolution after the tool |
| `08-after-test.txt` | the ten tests, green after the manual fix |
| `10-dryrun-full.txt`, `14-dryrun-with-lints.txt` | the second `dart fix` pass: nothing to fix |
| `11-after-outdated.txt`, `12-after-deps.txt` | the dependency tree after the migration |
| `13-analyze-with-lints.txt` | `dart analyze` with `flutter_lints` enabled |
| `15-analyze-type-mismatch.txt` | one file left on the old import: `ColorScheme` can't be assigned to `ColorScheme` |
| `16-barrel-theme.txt` | a widget behind the unmigrated barrel paints with the default theme |
| `17-generated-delegates-test.txt` | the `gen-l10n` delegate list breaks the French tests |
| `18-bridge-barrel.txt` | with the compatibility bridge, the barrel widget gets the app's theme |
| `19-bridge-generated-delegates.txt` | with the bridge, the French tests still fail |
| `20-barrel-fixed.txt` | after migrating the barrel by hand, `Section` paints with the app's theme |

## Run it

```bash
flutter pub get
flutter gen-l10n
flutter test
```

`flutter gen-l10n` is only needed if `lib/l10n/app_localizations*.dart` is
missing. Those files are generated from `lib/l10n/*.arb`; never edit them by
hand.

## Reproduce the three failures

Each one breaks the migrated app on purpose. Undo it with
`git checkout -- <file>` when you are done.

**A file left on the old import** (compile error):

```bash
git checkout first-app-without-migration -- lib/features/legacy/legacy_summary.dart
dart analyze
```

**An `export` the tool skipped** (no error, wrong theme): put the two lines of
`lib/core/ui.dart` back on `package:flutter/cupertino.dart` and
`package:flutter/material.dart`, then run `flutter test test/barrel_theme_test.dart`.

**The `gen-l10n` delegate list** (French breaks): in `lib/app/app.dart`, replace
the delegate list with `AppLocalizations.localizationsDelegates`, then run
`flutter test`.