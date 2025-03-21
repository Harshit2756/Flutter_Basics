import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});
  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPage();
}

//~ we have created new class _CurrencyConverterMaterialPage which extends the State class because we want to change the state of the widget and State doesn't have a const constructor as the Stateful widget so its mutable.
class _CurrencyConverterMaterialPage extends State<CurrencyConverterMaterialPage> {
  // // ~ initState is a method which is called when the stateful widget is inserted into the widget tree.
  // // ~ It is called only once before the build method is called.
  // // ~ we use it to add values coming from varibles (future,stream,etc)
  // @override
  // void initState() {
  //   super.initState();
  //   debugPrint('object');
  // }

  double result = 0;
  // ~ TextEditingController is a class which is used to control the text field.
  // ~ we use it to get the value from the text field.
  final TextEditingController inputUSDController = TextEditingController();


  @override
  void dispose() {
    // ~ dispose is a method which is called when the stateful widget is removed from the widget tree.
    // ~ we use it to dispose the controllers so that it doesn't take any memory after the widget is removed.
    inputUSDController.dispose();
    // ~ super.dispose() is used to call the dispose method of the parent class i.e State class.
    super.dispose();
  }


  @override
  // ~ BuildContext is a class which provides the location of the widget in the widget tree.
  // ~ When a widget is extended with a stateless widget or stateful widget.
  Widget build(BuildContext context) {
    
    // / textFieldBorder is a variable which is used to add border to the text field in the code below.
    final textFieldBorder = OutlineInputBorder(
      // ~ Color(0xAARRGGBB)
      borderSide: const BorderSide(
        color: Colors.black,
        width: 2,
        style: BorderStyle.solid,
        // ~ where the boder should be inside, outside , center of the widget.
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      borderRadius: BorderRadius.circular(10),
    );
    // ~ Scaffold is a widget which provides a framework to implement the basic material design layout of the app.
    return Scaffold(
      backgroundColor: Colors.green,

      // ~ AppBar is a widget which is used to add app bar to the app.
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Currency Converter',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      // ~ ColoredBox is a widget which is used to add color to the widget.
      // ~ we use color property to add color to the widget.
      //~ And 'Color' to add rgb color and 'Colors' to add deflaut colors by flutter.
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // * Text
              Text(
                'INR ${result != 0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // ~ Padding(in place of Container) is a widget which is used to add padding to the widget.
              // ~ Container is a widget which is used to add padding,margin,alignment,etc to the widget.
              // ~ we can use any of the above widget to add padding to the widget as it doesn't affect the performance.
              TextField(
                // ~ controller is a property of TextField widget which is used to control the text field.
                // ~ we use it to get the value from the text field.
                controller: inputUSDController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter amount in USD.',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(
                    Icons.monetization_on_outlined,
                  ),
                  prefixIconColor: Colors.black,
                  filled: true,
                  fillColor: Colors.white,
                  // / we have created a variable 'textFieldBorder' and assigned it to the border property.
                  focusedBorder: textFieldBorder,
                  enabledBorder: textFieldBorder,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  // signed: false,
                ),
              ),

              // ~ SizedBox is a widget which is used to add space between the widgets.
              const SizedBox(
                height: 10,
              ),
              // * Buttons
              // 1. ElevatedButton (RaisedButton) : has a shadow.
              // 2. TextButton (FlatButton) : appears like a text .

              ElevatedButton(
                onPressed: () {
                  //  debug mode: it is used to check the errors in the code.
                  // . flutter run --debug only works on emulators not on real devices.
                  // . we use kdebugMode to check whether the app is in debug mode or not.
                  // releas mode: it is used to run the app without any errors i.e in production.
                  // . flutter run --release only works on real devices not on emulators.
                  // . we use kreleaseMode to check whether the app is in release mode or not.
                  // profile mode: it is used to check the performance of the app i.e in production with error.
                  // . flutter run --profile only works on real devices not on emulators.
                  // . we use kprofileMode to check whether the app is in profile mode or not.
                  // if (kdebugMode) {
                  //   print(
                  //       "on pressed visible in debug mode only with if statement");
                  // }
                  // debugPrint("on pressed visible in debug mode only");

                  // ~ setState is a method which is used to rebuild the widget.
                  // ~ we use it when we want to change the state of the widget.
                  // ~ It tells the widget tree or the element tree that the state of the widget has changed and it should be rebuilt.
                  setState(() {
                    result = double.parse(inputUSDController.text) * 81;
                  });
                },
                // ~ we can use ButtonStyle to add style to the button or we can use styleFrom().
                // style:  ButtonStyle(
                //   backgroundColor: const MaterialStatePropertyAll(Colors.black),
                //   foregroundColor: const MaterialStatePropertyAll(Colors.white),
                //   minimumSize: const  MaterialStatePropertyAll(
                //     Size(double.infinity, 50),
                //   ),
                //   shape: MaterialStatePropertyAll(
                //     RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //   ),
                // ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Icon(Icons.currency_rupee),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// class CurrencyConverterMaterialPagee extends StatelessWidget {

// }
