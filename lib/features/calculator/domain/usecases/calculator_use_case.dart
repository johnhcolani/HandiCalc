import 'package:fraction/fraction.dart';

class CalculateUseCase {
  Fraction execute(Fraction num1, Fraction num2, String operator) {
    final result = switch (operator) {
      "+" => num1 + num2,
      "-" => num1 - num2,
      "×" => num1 * num2,
      "÷" => num1 / num2,
      _ => Fraction(0),
    };
    return result.reduce(); // Ensure result is reduced
  }
}