import 'package:material_ui_migration/core/ui.dart';

/// A titled block. Imports the barrel on purpose, not `package:flutter/material.dart`.
class Section extends StatelessWidget {
  const Section({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(title, style: textTheme.titleMedium),
        ),
        ...children,
        const SizedBox(height: 24),
      ],
    );
  }
}
