import 'package:equatable/equatable.dart';
import 'package:fraction/fraction.dart';

class CalculatorState extends Equatable {
  final String displayText;
  final String expression;
  final String inchResult;
  final String feetInchResult;

  const CalculatorState({
    required this.displayText,
    required this.expression,
    required this.inchResult,
    required this.feetInchResult,
  });

  CalculatorState copyWith({
    String? displayText,
    String? expression,
    String? inchResult,
    String? feetInchResult,
  }) {
    return CalculatorState(
      displayText: displayText ?? this.displayText,
      expression: expression ?? this.expression,
      inchResult: inchResult ?? this.inchResult,
      feetInchResult: feetInchResult ?? this.feetInchResult,
    );
  }

  @override
  List<Object?> get props => [displayText, expression, inchResult, feetInchResult];
}

const initialCalculatorState = CalculatorState(
  displayText: '0',
  expression: '',
  inchResult: '',
  feetInchResult: '',
);
