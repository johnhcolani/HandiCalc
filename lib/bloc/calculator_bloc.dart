import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fraction/fraction.dart';
import 'calculator_state.dart';
part 'calculator_event.dart';





class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  Fraction _currentInput = Fraction(0);
  Fraction? _result;
  String _operator = '';
  int wholeNumberInput = 0;
  Fraction fractionalInput = Fraction(0);

  CalculatorBloc() : super(initialCalculatorState) {
    on<ButtonPressed>(_onButtonPressed);
    on<ClearPressed>(_onClearPressed);
  }

  void _onButtonPressed(ButtonPressed event, Emitter<CalculatorState> emit) {
    String buttonText = event.buttonText;

    if (buttonText == "C") {
      // Reset everything
      emit(initialCalculatorState);
      _result = null; // Reset the result of the previous calculation
      _currentInput = Fraction(0); // Reset current input
      _operator = ''; // Clear the operator
      wholeNumberInput = 0; // Reset whole number input
      fractionalInput = Fraction(0); // Reset fractional input
      return;
    }

    if (buttonText == "=") {
      if (_result != null && _operator.isNotEmpty) {
        _result = calculateResult(_result!, _currentInput, _operator);
        emit(state.copyWith(
          displayText: formatFractionAsMixed(_result!),
          inchResult: "${formatFractionAsMixed(_result!)} inches",
          feetInchResult: convertToFeetAndInches(_result!),
          expression: "${state.expression} ${formatFractionAsMixed(_currentInput)} = ${formatFractionAsMixed(_result!)}",
        ));
      }

      // Clear `_operator` but keep `_result` to allow continued calculations
      _operator = '';
      _currentInput = Fraction(0);
      wholeNumberInput = 0;
      fractionalInput = Fraction(0);

      // Do NOT reset `_result` here; it will be used for the next calculation.
      return;
    }

    if (["+", "-", "×", "÷"].contains(buttonText)) {
      if (_currentInput == Fraction(0) && _result != null) {
        // If `_currentInput` is 0 (e.g., immediately after `=`), start with `_result`
        _currentInput = _result!;
      }

      if (_result == null) {
        _result = _currentInput; // Use the current input if no prior result
      } else if (_operator.isNotEmpty) {
        _result = calculateResult(_result!, _currentInput, _operator); // Perform calculation
      }
      _operator = buttonText; // Set the new operator

      emit(state.copyWith(
        expression: "${formatFractionAsMixed(_result!)} $buttonText",
        displayText: '0',
      ));

      // Reset current input after using it
      _currentInput = Fraction(0);
      wholeNumberInput = 0;
      fractionalInput = Fraction(0);

      return;
    }

    // Handle Fractional Input (e.g., "1/2")
    if (buttonText.contains("/")) {
      fractionalInput = parseFraction(buttonText);
      _currentInput = Fraction(wholeNumberInput) + fractionalInput;

      emit(state.copyWith(
        displayText: formatFractionAsMixed(_currentInput),
      ));
      return;
    }

    // Handle Whole Number Input (e.g., "1", "2", etc.)
    if (RegExp(r'^\d+$').hasMatch(buttonText)) {
      wholeNumberInput = int.parse(state.displayText == '0' ? buttonText : state.displayText + buttonText);
      _currentInput = Fraction(wholeNumberInput) + fractionalInput;

      emit(state.copyWith(
        displayText: formatFractionAsMixed(_currentInput),
      ));
      return;
    }

    // Handle Decimal Point Input (Optional, if you want decimals)
    if (buttonText == ".") {
      emit(state.copyWith(
        displayText: "${state.displayText}.",
      ));
      return;
    }
  }






  void _onClearPressed(ClearPressed event, Emitter<CalculatorState> emit) {
    emit(initialCalculatorState);
  }

  Fraction calculateResult(Fraction num1, Fraction num2, String operator) {
    switch (operator) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "×":
        return num1 * num2;
      case "÷":
        return num1 / num2;
      default:
        return Fraction(0);
    }
  }

  String convertToFeetAndInches(Fraction inches) {
    int totalInches = inches.toDouble().truncate();
    int feet = totalInches ~/ 12;
    Fraction remainingInches = inches - Fraction(feet * 12, 1);
    return "$feet ft ${formatFractionAsMixed(remainingInches)} in";
  }

  String formatFractionAsMixed(Fraction fraction) {
    fraction = fraction.reduce();
    int integerPart = fraction.toDouble().truncate();
    Fraction fractionalPart = fraction - Fraction(integerPart, 1);
    if (fractionalPart.numerator == 0) {
      return "$integerPart";
    }
    return integerPart == 0 ? fraction.toString() : "$integerPart ${fractionalPart.toString()}";
  }

  Fraction parseFraction(String input) {
    try {
      if (input.contains("/")) {
        return Fraction.fromString(input);
      } else {
        return Fraction.fromDouble(double.parse(input));
      }
    } catch (e) {
      return Fraction(0);
    }
  }
}
