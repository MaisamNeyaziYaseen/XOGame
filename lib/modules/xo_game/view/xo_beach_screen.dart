import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task4/modules/xo_game/controller/game_controller.dart';
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
                      ref.read(gameProvider).move(index);

                      if (ref.watch(gameProvider).gameResultStatus != null) {
                        showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                                  title: Text(ref
                                      .watch(gameProvider)
                                      .gameResultStatus!),
                                ));
                      }
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          ref.watch(gameProvider).showSymbol(index),
                          style: TextStyle(color: Colors.red, fontSize: 32),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Text('It\'s your turn')
            ],
          ),
        ),
      ),
    );
  }
}