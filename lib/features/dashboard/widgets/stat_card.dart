import 'package:material_ui/material_ui.dart';

/// Takes a Material type as a constructor argument.
///
/// This is the shape the compatibility bridge cannot repair. The bridge
/// injects theme data *through the context*, so a widget calling
/// `Theme.of(context)` keeps working. A widget that receives a `ColorScheme`
/// as an argument does not go through the context at all — the type has to
/// match at compile time.
///
/// The migration guide names this case:
/// "the compatibility bridge cannot resolve type mismatches when a dependency
/// exposes, accepts, or returns in-framework SDK types in its public API
/// signatures".
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.scheme,
    required this.label,
    required this.value,
  });

  final ColorScheme scheme;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: scheme.surfaceContainerHighest,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
