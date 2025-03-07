import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../blocs/calculator_bloc.dart';
import '../blocs/calculator_event.dart';

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
        padding:  EdgeInsets.all(2.w),
        child: Container(
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              width: 1.r,
              gradient: LinearGradient(colors: [
                Colors.blue.shade300,
                Colors.purple.shade300
              ]),
            ),
            borderRadius: BorderRadius.circular(16.r),
            color: colors.backgroundColor,
          ),
          child: ElevatedButton(
            onPressed: () => _handlePress(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.backgroundColor,
              padding: _getPadding(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
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
    } else if (["÷", "×", "-", "+"].contains(text)) { // Removed "⌫" from here
      bloc.add(OperatorEvent(text));
    } else if (text == "⌫") { // Added separate case for backspace
      bloc.add(BackspaceEvent());
    } else if (text == "=") {
      bloc.add(EqualsEvent());
    } else if (text == "(") {
      bloc.add(ParenthesisEvent(true));
    } else if (text == ")") {
      bloc.add(ParenthesisEvent(false));
    } else if (text.contains("/")) {
      bloc.add(FractionEvent('"${text}"'));
    } else {
      bloc.add(DigitEvent(text));
    }
  }

  ({Color backgroundColor, Color textColor}) _getButtonColors(BuildContext context) {
    if (isOperator || ["×", "-", "+", "÷"].contains(text)) { // Removed "⌫"
      return (
      backgroundColor: const Color(0xFFFF9F0A),
      textColor: Colors.white
      );
    }
// Add a separate case for "⌫" if needed
    if (text == "⌫") {
      return (
      backgroundColor: const Color(0xFFFF3B30), // Red color for backspace
      textColor: Colors.white
      );
    }
    return (
    backgroundColor: Colors.grey[850]!,
    textColor: Colors.white
    );
  }

  double _getTextSize() {
    if (["×", "-", "+", "÷","="].contains(text)) {
      return 24.sp; // Make these specific operators even bigger
    } else if (isFraction) {
      return 14.sp;
    }
    return 16.sp;
  }

  EdgeInsets _getPadding() => isFraction
      ?  EdgeInsets.symmetric(vertical: 8.h)
      :  EdgeInsets.all(10.w);
}