class CalculatorState {
  final String displayText;
  final String expression;
  final String inchResult;
  final String feetInchResult;

  CalculatorState({
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
}