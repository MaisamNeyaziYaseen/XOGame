import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task4/modules/xo_game/controller/game_controller.dart';
import 'package:task4/modules/xo_game/widgets/symbol_button.dart';
import 'xo_beach_screen.dart';
import 'package:intl/locale.dart';

class GetStarted extends ConsumerWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 150, width: 150),
              Text(
                "Choose which symbol do you want to play with".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.watch(gameProvider).setUserSymbol("X");
                      ref.read(gameProvider).xSelected(
                          !ref.watch(gameProvider).getXSelected);
                      if (ref.watch(gameProvider).getOSelected) {
                        ref.read(gameProvider).oSelected(false);
                      }
                    },
                    child: SymbolButton(
                      symbol: "X",
                      color: ref.watch(gameProvider).getXSelected
                          ? const Color(0xffF44A97)
                          : Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.watch(gameProvider).setUserSymbol("O");
                      ref.read(gameProvider).oSelected(
                          !ref.watch(gameProvider).getOSelected);
                      if (ref.watch(gameProvider).getXSelected) {
                        ref.read(gameProvider).xSelected(false);
                      }
                    },
                    child: SymbolButton(
                      symbol: "O",
                      color: ref.watch(gameProvider).getOSelected
                          ? const Color(0xffF44A97)
                          : Colors.grey,
                    ),
                  )
                ],
              ),
              if (ref.watch(gameProvider).getOSelected ||
                  ref.watch(gameProvider).getXSelected)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const XOBeachScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF44A97),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      fixedSize: const Size(double.maxFinite, 50)),
                  child: Text(
                    "Play now".tr(),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
