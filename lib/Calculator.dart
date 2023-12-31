import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import '../Calculator.dart';

void main() => runApp(const CalPage());

class CalPage extends StatelessWidget {
  const CalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SimpleCalculator'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(25.0),
          child: SizedBox(
            width: double.infinity,
            child: CalcButton(),
          ),
        ),
      ),
    );
  }
}

class CalcButton extends StatefulWidget {
  const CalcButton({Key? key}) : super(key: key);

  @override
  CalcButtonState createState() => CalcButtonState();
}

class CalcButtonState extends State<CalcButton> {
  double? _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    var calc = SimpleCalculator(
      value: _currentValue!,
      hideExpression: false,
      hideSurroundingBorder: true,
      autofocus: true,
      onChanged: (key, value, expression) {
        setState(() {
          _currentValue = value ?? 0;
        });
        if (kDebugMode) {
          print('$key\t$value\t$expression');
        }
      },
      onTappedDisplay: (value, details) {
        if (kDebugMode) {
          print('$value\t${details.globalPosition}');
        }
      },
      theme: const CalculatorThemeData(
        borderColor: Colors.black,
        borderWidth: 0,
        displayColor: Colors.black,
        displayStyle: TextStyle(fontSize: 80, color: Colors.white),
        expressionColor: Colors.black,
        expressionStyle: TextStyle(fontSize: 20, color: Colors.white),
        operatorColor: Colors.black,
        operatorStyle: TextStyle(fontSize: 30, color: Colors.white),
        commandColor: Colors.black,
        commandStyle: TextStyle(fontSize: 30, color: Colors.white),
        numColor: Colors.black,
        numStyle: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
    return OutlinedButton(
      child: Text(_currentValue.toString()),
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 5, child: calc);
            });
      },
    );
  }
}
