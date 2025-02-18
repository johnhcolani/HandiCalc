import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/calculator_bloc.dart';

class CalculatorButton extends StatelessWidget {
  final String text;

  const CalculatorButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handlePress(context),
      child: Text(text),
    );
  }

  void _handlePress(BuildContext context) {
    final bloc = context.read<CalculatorBloc>();
    // Determine event type based on text and add appropriate event
  }
}