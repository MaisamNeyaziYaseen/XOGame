import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task4/modules/xo_game/controller/game_controller.dart';
class XOBeachScreen extends ConsumerWidget {
  const XOBeachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffF44A97),
          title: const Text(
            'XO Board',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(onPressed: (){
            ref.read(gameProvider).reinitialize();
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back,color: Colors.white)),
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
                                children: [
                                  ref.watch(gameProvider).draw != 0?
                                  Image.asset("assets/images/ic_draw.png", height: 150, width: 150)
                                  :Image.asset("assets/images/ic_winner.png", height: 150, width: 150),
                                  Text(ref
                                      .watch(gameProvider)
                                      .gameResultStatus!
                                      .tr(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey
                                    ),
                                  )
                                ],
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
                            style: ref.watch(gameProvider).showSymbol(index) == 'X'
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
                ElevatedButton(
                  onPressed: () {
                    ref.read(gameProvider).reinitialize();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF44A97),
                      elevation: 10,
                      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                      fixedSize: const Size(200, 100)),
                  child:  Text(
                    "Refresh".tr(),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (context.locale == const Locale('en')) {
                        context.setLocale(const Locale('ar'));
                      } else {
                        context.setLocale(const Locale('en'));
                      }
                    },
                    icon: const Icon(
                      Icons.language,
                      color: Colors.blue,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
