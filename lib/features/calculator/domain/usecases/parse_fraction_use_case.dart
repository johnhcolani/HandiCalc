import 'package:fraction/fraction.dart';

class ParseFractionUseCase {
  Fraction execute(String input) {
    final negative = input.startsWith('-');
    final absoluteInput = negative ? input.substring(1) : input;

    final fraction = _parseAbsoluteValue(absoluteInput).reduce();

    return negative ? fraction * Fraction(-1) : fraction;
  }

  Fraction _parseAbsoluteValue(String input) {
    if (input.contains(' ')) {
      return _parseMixedNumber(input);
    }
    return Fraction.fromString(input);
  }

  Fraction _parseMixedNumber(String input) {
    final parts = input.split(' ');
    final whole = int.parse(parts[0]);
    final fraction = Fraction.fromString(parts[1]);
    return Fraction(whole) + fraction;
  }
}