import 'package:flutter/material.dart';

class XOBeachScreen extends StatelessWidget {
  const XOBeachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 1,crossAxisSpacing: 1),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey.withOpacity(0.3),
                    child: const Center(
                      child: Text('X', style: TextStyle(
                        color: Colors.red,
                        fontSize: 32
                      ),),
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
