/// Barrel file for the design libraries.
///
/// Plenty of real apps keep one of these so feature files import a single
/// path instead of two. It is also a measurement: `dart fix --apply
/// --code=migrate_design_widgets` rewrites `import` directives, but an open
/// issue says it leaves `export` directives alone
/// (https://github.com/dart-lang/sdk/issues/63968).
///
/// `RefreshCallback` is declared in both libraries, so one of them has to
/// hide it. Whether the fix keeps this `hide` clause is part of what we
/// measure.
library;

export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/material.dart';
