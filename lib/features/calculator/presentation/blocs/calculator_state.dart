class CalculatorState {
  final String displayText;
  final String expression;
  final String linearResult;
  final String squareResult;

  CalculatorState({
    required this.displayText,
    required this.expression,
    required this.linearResult,
    required this.squareResult,
  });

  CalculatorState copyWith({
    String? displayText,
    String? expression,
    String? linearResult,
    String? squareResult,
  }) {
    return CalculatorState(
      displayText: displayText ?? this.displayText,
      expression: expression ?? this.expression,
      linearResult: linearResult ?? this.linearResult,
      squareResult: squareResult ?? this.squareResult,
    );
  }
}