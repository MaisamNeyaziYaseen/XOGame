import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task4/modules/xo_game/controller/game_controller.dart';

class SymbolButton extends ConsumerWidget {
  String symbol;
  Function onTap;
  Color color;

  SymbolButton(
      {required this.symbol, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          )),
      child: Text(
        symbol,
        style: TextStyle(
            color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold),
      ),
    );
  }
}
