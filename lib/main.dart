import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _currentNumber = "";
  String _operation = "";
  double _num1 = 0;
  double _num2 = 0;

  // Custom Colors
  final Color operatorColor = Color(0xFF6200EE);
  final Color functionColor = Color(0xFF03DAC6);
  final Color numberColor = Color(0xFFBB86FC);
  final Color textColor = Colors.black;
  final Color displayBgColor = Color(0xFFE0E0E0);

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentNumber = "";
        _operation = "";
        _num1 = 0;
        _num2 = 0;
      } else if (buttonText == "(" || buttonText == ")") {
        _currentNumber += buttonText;
        _output = _currentNumber;
      } else if (buttonText == "+" || buttonText == "-" || 
                 buttonText == "×" || buttonText == "÷") {
        _num1 = double.parse(_output);
        _operation = buttonText;
        _currentNumber = _output + buttonText;
        _output = _currentNumber;
      } else if (buttonText == "=") {
        String numStr = _output;
        if (_operation.isNotEmpty) {
          _num2 = double.parse(_output.split(_operation).last);
          switch (_operation) {
            case "+":
              _output = (_num1 + _num2).toString();
              break;
            case "-":
              _output = (_num1 - _num2).toString();
              break;
            case "×":
              _output = (_num1 * _num2).toString();
              break;
            case "÷":
              _output = (_num1 / _num2).toString();
              break;
          }
        }
        _currentNumber = _output;
      } else {
        if (_currentNumber == "0") _currentNumber = "";
        _currentNumber += buttonText;
        _output = _currentNumber;
      }
    });
  }

  Widget buildButton(String buttonText, {Color? bgColor, double? buttonWidth}) {
    return Container(
      width: buttonWidth ?? MediaQuery.of(context).size.width / 4,
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor ?? numberColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.all(24.0),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: displayBgColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("C", bgColor: functionColor),
                    buildButton("(", bgColor: functionColor),
                    buildButton(")", bgColor: functionColor),
                    buildButton("÷", bgColor: operatorColor),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("×", bgColor: operatorColor),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("-", bgColor: operatorColor),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("+", bgColor: operatorColor),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("0", buttonWidth: MediaQuery.of(context).size.width / 2),
                    buildButton("."),
                    buildButton("=", bgColor: operatorColor),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}