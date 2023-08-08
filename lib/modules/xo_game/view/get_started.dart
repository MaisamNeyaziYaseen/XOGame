import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task4/modules/xo_game/controller/game_controller.dart';
import 'package:task4/modules/xo_game/widgets/symbol_button.dart';

import 'ox_beach_screen.dart';

class GetStarted extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              "Get Started",
              style: TextStyle(fontSize: 30, color: Color(0xffA3CDD8)),
            ),
          ),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 3)
                  ],
                ),
                child: Column(
                  children: [
                    const Text("Choose wich symbol do you want to play with"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SymbolButton(
                          symbol: "X",
                          color: ref.watch(gameProvider).getisXSelected
                              ? Colors.yellow
                              : Color(0xffA3CDD8),
                          onTap: () {
                            ref.watch(gameProvider).setUserSymbol("X");
                            ref.read(gameProvider).setisXSelected(
                                !ref.watch(gameProvider).getisXSelected);
                            if (ref.watch(gameProvider).getisOSelected) {
                              ref.read(gameProvider).setisOSelected(false);
                            }
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SymbolButton(
                          symbol: "O",
                          color: ref.watch(gameProvider).getisOSelected
                              ? Colors.yellow
                              : Color(0xffA3CDD8),
                          onTap: () {
                            ref.watch(gameProvider).setUserSymbol("O");
                            ref.read(gameProvider).setisOSelected(
                                !ref.watch(gameProvider).getisOSelected);
                            if (ref.watch(gameProvider).getisXSelected) {
                              ref.read(gameProvider).setisXSelected(false);
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (ref.watch(gameProvider).getisOSelected ||
                  ref.watch(gameProvider).getisXSelected)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const XOBeachScreen()));
                  },
                  child: Text(
                    "Start The Game",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffA3CDD8),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
