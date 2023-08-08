import 'package:flutter/material.dart';

class SymbolButton extends StatelessWidget {
  final String symbol;
  final Color color;

  const SymbolButton(
      {super.key, required this.symbol, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13)
      ),
      child: Center(
        child: Text(
          symbol,
          style: const TextStyle(
              color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
