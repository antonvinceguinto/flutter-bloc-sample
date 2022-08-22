import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  const InfoText(
    this.label, {
    super.key,
    this.labelColor = Colors.white,
  });

  final String label;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: labelColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
