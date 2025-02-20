import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../blocs/calculator_bloc.dart';
import '../blocs/calculator_event.dart';
import '../blocs/calculator_state.dart';
import '../widgets/app_info_overlay.dart';

class FractionCalculatorScreen extends StatelessWidget {
  const FractionCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191818),
      appBar: AppBar(
        backgroundColor: Color(0xFF191818),
        title: Center(
          child: Text(
            'Fraction Flow',
            style: TextStyle(color: Colors.grey.shade300),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: () => showDialog(
    context: context,
    builder: (context) => const AppInfoOverlay(),
    barrierColor: Colors.transparent,
            ),
          
        ),
      ),
      body: BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildDisplaySection(context, state),
              _buildResultContainers(state),
              _buildCalculatorButtons(context),
             // _buildAdBanner(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDisplaySection(BuildContext context, CalculatorState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          border: GradientBoxBorder(
            width: 2,
            gradient: LinearGradient(colors: [
              Colors.blue.shade300,
              Colors.purple.shade300
            ]),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(state.expression,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300])),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(state.displayText,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultContainers(CalculatorState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Row(
        children: [
          Expanded(child: _buildResultContainer("in", state.inchResult, Color(
              0xFFC7ADD5))),
          const SizedBox(width: 8),
          Expanded(child: _buildResultContainer("ft", state.feetInchResult, Colors.white)),
        ],
      ),
    );
  }

  Widget _buildResultContainer(String label, String result, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),

            // Auto-scale font to fit within the container
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown, // Scale text down if it overflows
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorButtons(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Column(
          children: [
            _buildOperatorRow(["C", "±", "%", "÷"]),
            _buildNumberRow(["7", "8", "9", "×"]),
            _buildNumberRow(["4", "5", "6", "-"]),
            _buildNumberRow(["1", "2", "3", "+"]),
            _buildBottomRow(),
            _buildFractionRow(["1/8", "3/8", "5/8", "7/8"]),
            _buildFractionRow(["1/16", "3/16", "5/16", "7/16"]),
            _buildFractionRow(["9/16", "11/16", "13/16", "15/16"]),
          ],
        ),
      ),
    );
  }

  Widget _buildOperatorRow(List<String> buttons) {
    return Row(
      children: buttons.map((text) => CalculatorButton(
        text: text,
        isOperator: true,
      )).toList(),
    );
  }

  Widget _buildNumberRow(List<String> buttons) {
    return Row(
      children: buttons.map((text) => CalculatorButton(text: text)).toList(),
    );
  }

  Widget _buildBottomRow() {
    return const Row(
      children: [
        CalculatorButton(text: "0"),
        CalculatorButton(text: "1/2"),
        CalculatorButton(text: "=", isOperator: true),
      ],
    );
  }

  Widget _buildFractionRow(List<String> fractions) {
    return Row(
      children: fractions.map((text) => CalculatorButton(
        text: text,
        isFraction: true,
      )).toList(),
    );
  }

  Widget _buildAdBanner() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              width: 2,
              gradient: LinearGradient(
                  colors: [Colors.orange, Colors.blue.shade300],
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
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final bool isOperator;
  final bool isFraction;

  const CalculatorButton({
    super.key,
    required this.text,
    this.isOperator = false,
    this.isFraction = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getButtonColors(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              width: 2,
              gradient: LinearGradient(colors: [
                Colors.blue.shade300,
                Colors.purple.shade300
              ]),
            ),
            borderRadius: BorderRadius.circular(24),
            color: colors.backgroundColor,
          ),
          child: ElevatedButton(
            onPressed: () => _handlePress(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.backgroundColor,
              padding: _getPadding(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              elevation: 2,
            ),
            child: Text(text,
                style: TextStyle(
                    fontSize: _getTextSize(),
                    fontWeight: FontWeight.bold,
                    color: colors.textColor)),
          ),
        ),
      ),
    );
  }

  void _handlePress(BuildContext context) {
    final bloc = context.read<CalculatorBloc>();

    if (text == "C") {
      bloc.add(ClearEvent());
    } else if (text == "±") {
      bloc.add(NegateEvent());
    } else if (text == "%") {
      bloc.add(PercentEvent());
    } else if (["÷", "×", "-", "+"].contains(text)) {
      bloc.add(OperatorEvent(text));
    } else if (text == "=") {
      bloc.add(EqualsEvent());
    } else if (text.contains("/")) {
      bloc.add(FractionEvent(text));
    } else {
      bloc.add(DigitEvent(text));
    }
  }

  ({Color backgroundColor, Color textColor}) _getButtonColors(BuildContext context) {
    if (isOperator || ["×", "-", "+", "÷"].contains(text)) {
      return (
      backgroundColor: const Color(0xFFFF9F0A),
      textColor: Colors.white
      );
    }
    if (isFraction) {
      return (
      backgroundColor: const Color(0xFF575454),
      textColor: Colors.white
      );
    }
    return (
    backgroundColor: Colors.grey[850]!,
    textColor: Colors.white
    );
  }

  double _getTextSize() => isFraction ? 16 : 24;

  EdgeInsets _getPadding() => isFraction
      ? const EdgeInsets.symmetric(vertical: 12)
      : const EdgeInsets.all(14);
}