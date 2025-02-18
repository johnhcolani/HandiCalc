import 'package:fraction/fraction.dart';

class FormatFractionUseCase {
  String execute(Fraction fraction) {
    // First reduce the fraction
    final reduced = fraction.reduce();

    // Manual absolute value implementation
    final isNegative = reduced.numerator < 0;
    final absolute = Fraction(
        reduced.numerator.abs(),
        reduced.denominator
    );

    final integerPart = absolute.toDouble().truncate();
    final fractionalPart = absolute - Fraction(integerPart);

    if (fractionalPart.numerator == 0) {
      return _addSign(isNegative, integerPart.toString());
    }

    return integerPart == 0
        ? _addSign(isNegative, absolute.toString())
        : _addSign(isNegative, "$integerPart ${fractionalPart.toString()}");
  }

  String _addSign(bool isNegative, String value) =>
      isNegative ? "-$value" : value;
}