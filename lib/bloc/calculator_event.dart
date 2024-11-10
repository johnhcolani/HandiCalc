part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();
}
class ButtonPressed extends CalculatorEvent{
  final String buttonText;

  const ButtonPressed(this.buttonText);

  @override

  List<Object?> get props => [buttonText];
}

class ClearPressed extends CalculatorEvent{
  @override

  List<Object?> get props => [];

}