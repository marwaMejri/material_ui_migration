import 'package:cupertino_ui/cupertino_ui.dart';

/// The Cupertino counterpart of [StatCard]: a Cupertino type in a constructor.
///
/// Same reason it is here. `cupertino_ui` ships its own
/// `CupertinoUiCompatibilityBridge`, with the same limitation.
class ThemedBadge extends StatelessWidget {
  const ThemedBadge({super.key, required this.theme, required this.label});

  final CupertinoThemeData theme;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: CupertinoColors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
