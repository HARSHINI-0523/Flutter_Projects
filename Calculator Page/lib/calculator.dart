import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷" ||
        buttonText == "%") {
      // If we are pressing an operand, store the first number and operand
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0"; // Reset for the next number
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "×") {
        _output = (num1 * num2).toString();
      } else if (operand == "÷") {
        if (num2 != 0) {
          _output = (num1 / num2).toString();
        } else {
          _output = 'Error'; // Prevent division by zero
        }
      } else if (operand == "%") {
        _output = (num1 % num2).toString(); // Modulus calculation
      }

      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      // If we press a number or other character, append it
      if (_output == "0") {
        _output = buttonText; // Replace the 0 if it's the first digit pressed
      } else {
        _output = _output + buttonText; // Continue appending
      }
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2).replaceAll(".00", "");
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20.0),
          shape: CircleBorder(),
          backgroundColor: color,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 30.0, color: Colors.white),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton("AC", Colors.grey),
                    buildButton("÷", Colors.orange),
                    buildButton("%", Colors.orange), // Modulus operator
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton("7", Colors.teal),
                    buildButton("8", Colors.teal),
                    buildButton("9", Colors.teal),
                    buildButton("×", Colors.orange),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton("4", Colors.teal),
                    buildButton("5", Colors.teal),
                    buildButton("6", Colors.teal),
                    buildButton("-", Colors.orange),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton("1", Colors.teal),
                    buildButton("2", Colors.teal),
                    buildButton("3", Colors.teal),
                    buildButton("+", Colors.orange),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton("0", Colors.teal),
                    buildButton(".", Colors.teal),
                    buildButton("=", Colors.orange),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
