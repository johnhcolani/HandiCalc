import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/calculator_bloc.dart';
import 'bloc/calculator_state.dart';


class FractionCalculatorScreen extends StatelessWidget {
  const FractionCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculatorBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Fraction Calculator',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        body: BlocBuilder<CalculatorBloc, CalculatorState>(
          builder: (context, state) {
            final bloc = context.read<CalculatorBloc>();

            return Column(
              children: [
                // Display Expression and Current Input
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: Text(
                            state.expression,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Text(
                            state.displayText,
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Inch and Feet Results
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: buildResultContainer("in", state.inchResult, Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: buildResultContainer("ft", state.feetInchResult, Colors.white),
                      ),
                    ],
                  ),
                ),

                // Buttons for Calculator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: Column(
                    children: [
                      buildButtonRow(context, bloc, ["C", "±", "%", "÷"], operand: true),
                      buildButtonRow(context, bloc, ["7", "8", "9", "×"]),
                      buildButtonRow(context, bloc, ["4", "5", "6", "-"]),
                      buildButtonRow(context, bloc, ["1", "2", "3", "+"]),
                      buildButtonRow(context, bloc, ["0", ".", "1/2", "="], operand: true),
                      buildFractionRow(context, bloc, ["1/8", "3/8", "5/8", "7/8"]),
                      buildFractionRow(context, bloc, ["1/16", "3/16", "5/16", "7/16"]),
                      buildFractionRow(context, bloc, ["9/16", "11/16", "13/16", "15/16"]),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Helper method to build rows of buttons
  Widget buildButtonRow(BuildContext context, CalculatorBloc bloc, List<String> texts, {bool operand = false}) {
    final operandColor = const Color(0xFFFF9F0A);
    final operandTextColor = Colors.white;

    return Row(
      children: texts.map((text) {
        return buildButton(
          text,
          color: operand ? operandColor : Colors.grey[850]!,
          textColor: operand ? operandTextColor : Colors.white,
          onPressed: () {
            if (text == "C") {
              bloc.add(ClearPressed());
            } else {
              bloc.add(ButtonPressed(text));
            }
          },
        );
      }).toList(),
    );
  }

  // Helper method to build rows of fraction buttons
  Widget buildFractionRow(BuildContext context, CalculatorBloc bloc, List<String> fractions) {
    return Row(
      children: fractions.map((fraction) {
        return buildButton(
          fraction,
          color: const Color(0xFF333333),
          textColor: Colors.white,
          onPressed: () => bloc.add(ButtonPressed(fraction)),
        );
      }).toList(),
    );
  }

  // Helper method to build a single button
  Widget buildButton(String text, {required Color color, required Color textColor, required VoidCallback onPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(32),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 2,
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build result containers
  Widget buildResultContainer(String label, String result, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),
            Text(result, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
          ],
        ),
      ),
    );
  }
}
