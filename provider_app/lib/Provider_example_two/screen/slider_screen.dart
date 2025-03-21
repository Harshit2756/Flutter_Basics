// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/slider_provider.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  SliderScreenState createState() => SliderScreenState();
}

class SliderScreenState extends State<SliderScreen> {
  //* double opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    print("build");
    // final sliderProvider = Provider.of<SiderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Slider Example"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<SiderProvider>(builder: (context, sliderProvider, child) {
            print("Consumer");
            return Slider(
              min: 0.0,
              max: 1.0,
              //* value: opacity,
              value: sliderProvider.opacity,
              onChanged: (no) {
                print(no);
                //* opacity = no;
                //* setState(() {});
                sliderProvider.setOpacity(no);
              },
            );
          }),
          Consumer<SiderProvider>(builder: (context, sliderProvider, child) {
            print("Consumer");
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(
                        //*opacity,
                        sliderProvider.opacity,
                      ),
                    ),
                    child: Center(child: Text("Container 1")),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(
                        //*opacity,
                        sliderProvider.opacity,
                      ),
                    ),
                    child: Center(child: Text("Container 2")),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
