import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task4/modules/xo_game/controller/game_controller.dart';
import 'package:task4/modules/xo_game/utils/game_util.dart';

class XOBeachScreen extends ConsumerWidget {
  const XOBeachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF44A97),
        title: const Text(
          'XO Board',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 1, crossAxisSpacing: 1),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      ref.read(gameProvider).userRound(index, //on full board
                          () {
                        showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                                  title: Text(ref
                                      .watch(gameProvider)
                                      .getGameState
                                      .name),
                                ));
                      },
                          //invalid move
                          () => showDialog(
                              context: context,
                              builder: (context) => const SimpleDialog(
                                    title: Text("Invalid Move Index"),
                                  )));
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          ref.watch(gameProvider).showSymbol(index),
                          style:
                              ref.watch(gameProvider).showSymbol(index) == 'X'
                                  ? const TextStyle(
                                      color: Color(0xffF44A97), fontSize: 32,fontWeight: FontWeight.bold)
                                  : const TextStyle(
                                      color: Colors.black, fontSize: 32,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Container(
              //     height: 100,
              //     width: 200,
              //     decoration: BoxDecoration(
              //         color: const Color(0xffF44A97),
              //         borderRadius: BorderRadius.circular(13),
              //         boxShadow: [
              //           BoxShadow(
              //               color: Colors.grey.withOpacity(0.3),
              //               spreadRadius: 5,
              //               blurRadius: 5)
              //         ]),
              //     child: const Center(
              //         child: Text(
              //       'It\'s your turn',
              //       style: TextStyle(color: Colors.white, fontSize: 16),
              //     )))

              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffF44A97),
                    elevation: 10,
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                    fixedSize: const Size(200, 100)),
                child: const Text(
                  "Refresh",
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
