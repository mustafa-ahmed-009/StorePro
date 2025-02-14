// Extracted Widget: Table Cell
import 'package:flutter/material.dart';

class TableCellWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  const TableCellWidget({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}
