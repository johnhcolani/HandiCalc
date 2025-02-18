import 'package:fraction/fraction.dart';

class ConvertUnitsUseCase {
  String execute(Fraction inches) {
    final isNegative = inches.numerator < 0;
    final absoluteInches = Fraction(
      inches.numerator.abs(),
      inches.denominator,
    ).reduce();

    final totalInches = absoluteInches.toDouble().truncate();
    final feet = totalInches ~/ 12;
    final remainingInches = absoluteInches - Fraction(feet * 12);

    final sign = isNegative ? "-" : "";
    final feetStr = feet > 0 ? "$feet ft " : (isNegative ? "0 ft " : "");
    final inchesStr = "${_formatFraction(remainingInches)} in";

    return "$sign$feetStr$inchesStr";
  }

  String _formatFraction(Fraction fraction) {
    fraction = fraction.reduce();
    final integerPart = fraction.toDouble().truncate();
    final fractionalPart = fraction - Fraction(integerPart);

    return integerPart == 0 ?
    fraction.toString() :
    "$integerPart ${fractionalPart.toString()}";
  }
}