import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/calculator_bloc.dart';
import '../blocs/calculator_event.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final bool isOperator;
  final bool isFraction;

  const CalculatorButton({
    required this.text,
    this.isOperator = false,
    this.isFraction = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getButtonColors();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.backgroundColor,
            foregroundColor: colors.textColor,
            textStyle: TextStyle(
              fontSize: _getTextSize(),
              fontWeight: FontWeight.bold,
            ),
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          onPressed: () => _handlePress(context),
          child: Text(text),
        ),
      ),
    );
  }

  void _handlePress(BuildContext context) {
    final bloc = context.read<CalculatorBloc>();
    if (text == "C") {
      bloc.add(ClearEvent());
    } else if (["×", "-", "+", "÷"].contains(text)) {
      bloc.add(OperatorEvent(text));
    }
    // Add other event handlers
  }

  double _getTextSize() {
    if (isOperator) return 32;  // Increased size for operators
    if (isFraction) return 16;
    return 24;  // Default size for numbers
  }

  ({Color backgroundColor, Color textColor}) _getButtonColors() {
    if (isOperator) {
      return (
      backgroundColor: const Color(0xFFFF9F0A), // Orange for operators
      textColor: Colors.white
      );
    }
    if (isFraction) {
      return (
      backgroundColor: const Color(0xFF575454), // Gray for fractions
      textColor: Colors.white
      );
    }
    return (
    backgroundColor: Colors.grey[850]!, // Dark gray for numbers
    textColor: Colors.white
    );
  }
}