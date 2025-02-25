import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../blocs/calculator_bloc.dart';
import '../blocs/calculator_event.dart';
import '../blocs/calculator_state.dart';
import '../widgets/app_info_overlay.dart';
import '../widgets/calculator_button.dart';

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
            style: TextStyle(color: Colors.grey.shade300,fontSize: 16.sp),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white,size: 18.dm,),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const AppInfoOverlay(),
            barrierColor: Colors.transparent,
          ),

        ),
      ),
      body: BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth = constraints.maxWidth > 600 ? constraints.maxWidth * 0.8 : constraints.maxWidth;

              double maxHeight = constraints.maxHeight; // Get screen height
              return Center(
                child: Container(
                  width: maxWidth,
                  height: maxHeight, // Ensure it doesn't overflow
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  child: Column(
                    children: [
                      _buildDisplaySection(context, state,constraints),
                      _buildResultContainers(state),
                      _buildScrollableCalculatorButtons(context),
                      // _buildAdBanner(),
                    ],
                  ),
                ),
              );
            });
        },
      ),
    );
  }

  Widget _buildDisplaySection(BuildContext context, CalculatorState state, BoxConstraints constraints) {
    return Padding(
      padding: EdgeInsets.all(6.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withValues(red: 0.2, blue: 1, green: 1, alpha: 0.1),
          border: GradientBoxBorder(
            width: 1.dm,
            gradient: LinearGradient(colors: [
              Colors.blue.shade300,
              Colors.purple.shade300
            ]),
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              child: Text(
                state.expression,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 600 ? 18.sp : 22.sp, // Smaller on tablets
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[300],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Text(
                state.displayText,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 600 ? 24.sp : 28.sp, // Scale for large screens
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildResultContainers(CalculatorState state) {
    return Padding(
<<<<<<< HEAD
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
=======
      padding:  EdgeInsets.all(6.w),
>>>>>>> 5d0b52088e276fa6009c1ec4c7c4d8178e0eeb63
      child: Row(
        children: [
          Expanded(child: _buildResultContainer("ft", state.linearResult, Colors.white)),
          SizedBox(width: 4.r),
          Expanded(child: _buildResultContainer("sq ft", state.squareResult, Color(0xFFC7ADD5))),
        ],
      ),
    );
  }

  Widget _buildResultContainer(String label, String result, Color textColor) {
    return Padding(
      padding: EdgeInsets.all(6.w),
      child: Container(
        decoration: BoxDecoration(
<<<<<<< HEAD
          color: Colors.blue.withOpacity(0.1),
=======
          color: Colors.blue.withValues(red: .01, blue: 2, green: 1, alpha: 0.1),
>>>>>>> 5d0b52088e276fa6009c1ec4c7c4d8178e0eeb63
          border: Border.all(color: Colors.grey, width: 2.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
<<<<<<< HEAD
              Text(label, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
=======
              Text(label, style: TextStyle(color: Colors.white, fontSize: 14.sp)), // Scaled text
>>>>>>> 5d0b52088e276fa6009c1ec4c7c4d8178e0eeb63
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 18.sp, // Bigger on larger screens
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildScrollableCalculatorButtons(BuildContext context) {
    return SizedBox(
      height: 0.6.sh, // Max 60% of screen height to prevent overflow
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOperatorRow(["C", "±", "%", "÷"]),
            _buildNumberRow(["7", "8", "9", "×"]),
            _buildNumberRow(["4", "5", "6", "-"]),
            _buildNumberRow(["1", "2", "3", "+"]),
            _buildBottomRow(),
            _buildFractionRow(["1/4", "3/4"]),
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


}

