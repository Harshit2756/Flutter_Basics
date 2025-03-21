import 'package:flutter/cupertino.dart';

// ~ stfl is used to access the statefull widget snippet

class CurrencyConverterCupertinoPage extends StatefulWidget {
  const CurrencyConverterCupertinoPage({super.key});

  @override
  State<CurrencyConverterCupertinoPage> createState() =>
      _CurrencyConverterCupertinoPageState();
}

class _CurrencyConverterCupertinoPageState
    extends State<CurrencyConverterCupertinoPage> {
  double result = 0;
  final TextEditingController inputUSD = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.activeGreen,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.activeGreen,
        middle: Text(
          'Currency Converter',
        ),
      ),
      child: Center(
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
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // ~ Padding(in place of Container) is a widget which is used to add padding to the widget.
              // ~ Container is a widget which is used to add padding,margin,alignment,etc to the widget.
              // ~ we can use any of the above widget to add padding to the widget as it doesn't affect the performance.
              CupertinoTextField(
                // ~ controller is a property of TextField widget which is used to control the text field.
                // ~ we use it to get the value from the text field.
                controller: inputUSD,
                style: const TextStyle(
                  color: CupertinoColors.black,
                ),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                placeholder: 'Enter amount in USD.',
                prefix: const Icon(CupertinoIcons.money_dollar_circle),

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

              CupertinoButton(
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
                    result = double.parse(inputUSD.text) * 81;
                  });
                },
                color: CupertinoColors.black,
                child: const Text('Convert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
