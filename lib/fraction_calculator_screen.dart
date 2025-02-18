import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class FractionCalculatorScreen1 extends StatefulWidget {
  const FractionCalculatorScreen1({super.key});

  @override
  _FractionCalculatorScreenState createState() =>
      _FractionCalculatorScreenState();
}

class _FractionCalculatorScreenState extends State<FractionCalculatorScreen1> {
  String displayText = '0';
  String expression = '';
  String inchResult = '';
  String feetInchResult = '';
  String _operator = '';
  Fraction? _result;
  Fraction _currentInput = Fraction(0);
  int wholeNumberInput = 0;
  Fraction fractionalInput = Fraction(0);
  bool _isNewNumber = true;

  final Color operandColor = const Color(0xFFFF9F0A);
  final Color operandTextColor = Colors.white;
  final Color fractionColor = const Color(0xFF575454);
  final Color fractionTextColor = Colors.white;
  final Color defaultColor = Colors.grey[850]!;
  final Color defaultTextColor = Colors.white;
  final Color backgroundColor = Color(0xFF191818FF);

  bool _isVisible = false;

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "%") {
        _currentInput = _currentInput / Fraction(100);
        displayText = formatFractionAsMixed(_currentInput);
        _isNewNumber = true;
      } else if (buttonText == "C") {
        resetCalculator();
      } else if (buttonText == "±") {
        _currentInput = _currentInput * Fraction(-1);
        displayText = formatFractionAsMixed(_currentInput);
      } else if (["÷", "×", "-", "+"].contains(buttonText)) {
        handleOperator(buttonText);
      } else if (buttonText == "=") {
        handleEquals();
      } else if (buttonText.contains("/")) {
        handleFraction(buttonText);
      } else {
        handleDigit(buttonText);
      }
    });
  }

  void resetCalculator() {
    displayText = '0';
    expression = '';
    inchResult = '';
    feetInchResult = '';
    _result = null;
    _currentInput = Fraction(0);
    _operator = '';
    wholeNumberInput = 0;
    fractionalInput = Fraction(0);
    _isNewNumber = true;
  }

  void handleOperator(String buttonText) {
    if (_result == null) {
      _result = _currentInput;
    } else if (_operator.isNotEmpty) {
      _result = calculateResult(_result!, _currentInput, _operator);
    }
    _operator = buttonText;
    expression = "${formatFractionAsMixed(_result!)} $buttonText";
    _currentInput = Fraction(0);
    wholeNumberInput = 0;
    fractionalInput = Fraction(0);
    displayText = '0';
    _isNewNumber = true;
  }

  void handleEquals() {
    if (_result != null && _operator.isNotEmpty) {
      _result = calculateResult(_result!, _currentInput, _operator);
      displayText = formatFractionAsMixed(_result!);
      inchResult = "${formatFractionAsMixed(_result!)} inches";
      feetInchResult = convertToFeetAndInches(_result!);
      expression =
          "$expression ${formatFractionAsMixed(_currentInput)} = ${formatFractionAsMixed(_result!)}";
    }
    _operator = '';
    _isNewNumber = true;
  }

  void handleFraction(String buttonText) {
    fractionalInput = parseFraction(buttonText);
    _currentInput = Fraction(wholeNumberInput) + fractionalInput;
    displayText = formatFractionAsMixed(_currentInput);
    _isNewNumber = false;
  }

  void handleDigit(String buttonText) {
    if (_isNewNumber) {
      wholeNumberInput = 0;
      fractionalInput = Fraction(0);
      _currentInput = Fraction(0);
      _isNewNumber = false;
    }
    wholeNumberInput = wholeNumberInput * 10 + int.parse(buttonText);
    _currentInput = Fraction(wholeNumberInput) + fractionalInput;
    displayText = formatFractionAsMixed(_currentInput);
  }

  Fraction parseFraction(String input) => Fraction.fromString(input);

  Fraction calculateResult(Fraction num1, Fraction num2, String operator) {
    switch (operator) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "×":
        return num1 * num2;
      case "÷":
        return num1 / num2;
      default:
        return Fraction(0);
    }
  }

  String convertToFeetAndInches(Fraction inches) {
    bool isNegative = inches.numerator < 0;
    // Manually compute absolute value
    inches = Fraction(inches.numerator.abs(), inches.denominator);

    int totalInches = inches.toDouble().truncate();
    int feet = totalInches ~/ 12;
    Fraction remainingInches = inches - Fraction(feet * 12);

    String sign = isNegative ? "-" : "";
    String feetStr = feet > 0 ? "$feet ft " : "";
    String inchesStr = "${formatFractionAsMixed(remainingInches)} in";

    return "$sign$feetStr$inchesStr";
  }

  String formatFractionAsMixed(Fraction fraction) {
    fraction = fraction.reduce();
    bool isNegative = fraction.numerator < 0;

    // Manually compute absolute value
    if (isNegative) {
      fraction = Fraction(fraction.numerator.abs(), fraction.denominator);
    }

    int integerPart = fraction.toDouble().truncate();
    Fraction fractionalPart = fraction - Fraction(integerPart);

    if (fractionalPart.numerator == 0) {
      return isNegative ? "-$integerPart" : "$integerPart";
    }

    return integerPart == 0
        ? (isNegative ? "-$fraction" : "$fraction")
        : (isNegative
            ? "-$integerPart ${fractionalPart.toString()}"
            : "$integerPart ${fractionalPart.toString()}");
  }

  Widget buildButton(String text,
      {Color color = Colors.grey,
      Color textColor = Colors.white,
      double textSize = 24,
      bool isOval = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            border: GradientBoxBorder(
                width: 2,
                gradient: LinearGradient(
                    colors: [Colors.blue.shade300, Colors.purple.shade300])),
            borderRadius: BorderRadius.circular(24),
            color: color,
            // borderRadius: BorderRadius.circular(isOval ? 42 : 32),
          ),
          child: ElevatedButton(
            onPressed: () => onButtonPressed(text),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: isOval
                  ? const EdgeInsets.symmetric(horizontal: 40, vertical: 23)
                  : const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(isOval ? 32 : 24)),
              elevation: 2,
            ),
            child: Text(text,
                style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
          ),
        ),
      ),
    );
  }

  Widget buildFractionRow(List<String> fractions) {
    return Row(
      children: fractions
          .map((fraction) => buildButton(fraction,
              color: fractionColor, textColor: fractionTextColor, textSize: 16))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191818FF),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Handy Calculator',
            style: TextStyle(
              color: Colors.grey.shade300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.white,)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                //gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),

                border: GradientBoxBorder(
                    width: 2,
                    gradient: LinearGradient(colors: [
                      Colors.blue.shade300,
                      Colors.purple.shade300
                    ])),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(expression,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[300])),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(displayText,
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
            child: Row(
              children: [
                Expanded(
                    child: buildResultContainer("in", inchResult, Colors.grey)),
                const SizedBox(width: 8),
                Expanded(
                    child: buildResultContainer(
                        "ft", feetInchResult, Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Column(
              children: [
                Row(children: [
                  buildButton("C",
                      color: operandColor, textColor: operandTextColor),
                  buildButton("±",
                      color: operandColor, textColor: operandTextColor),
                  buildButton("%",
                      color: operandColor, textColor: operandTextColor),
                  buildButton("÷",
                      color: operandColor, textColor: operandTextColor),
                ]),
                Row(children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("×",
                      color: operandColor, textColor: operandTextColor)
                ]),
                Row(children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-",
                      color: operandColor, textColor: operandTextColor)
                ]),
                Row(children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+",
                      color: operandColor, textColor: operandTextColor)
                ]),
                Row(children: [
                  buildButton("0"),
                  buildButton("1/2"),
                  buildButton("=",
                      color: operandColor,
                      textColor: operandTextColor,
                      isOval: false)
                ]),
                buildFractionRow(["1/8", "3/8", "5/8", "7/8"]),
                buildFractionRow(["1/16", "3/16", "5/16", "7/16"]),
                buildFractionRow(["9/16", "11/16", "13/16", "15/16"]),
              ],
            ),
          ),
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    //gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                    border: GradientBoxBorder(
                      width: 2,
                      gradient: LinearGradient(
                          colors: [operandColor, Colors.blue.shade300],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                      child: Text('Ad would be here',
                          style: TextStyle(color: Colors.white))),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildResultContainer(String label, String result, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF191818FF),
        border: Border.all(color: Colors.grey.withOpacity(0.8), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),
            Text(result,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
          ],
        ),
      ),
    );
  }
}
