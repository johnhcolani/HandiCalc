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
        padding:  EdgeInsets.all(3.w),
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

  double _getTextSize() => isFraction ? 10.sp : 10.sp;

  EdgeInsets _getPadding() => isFraction
      ?  EdgeInsets.symmetric(vertical: 8.h)
      :  EdgeInsets.all(10.w);
}