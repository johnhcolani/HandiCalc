abstract class CalculatorEvent {}
class ClearEvent extends CalculatorEvent {}
class NegateEvent extends CalculatorEvent {}
class OperatorEvent extends CalculatorEvent {
  final String operator;
  OperatorEvent(this.operator);
}
class EqualsEvent extends CalculatorEvent {}
class DigitEvent extends CalculatorEvent {
  final String digit;
  DigitEvent(this.digit);
}
class FractionEvent extends CalculatorEvent {
  final String fraction;
  FractionEvent(this.fraction);
}
class PercentEvent extends CalculatorEvent {}
