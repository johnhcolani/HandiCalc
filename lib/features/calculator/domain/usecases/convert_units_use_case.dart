import 'package:fraction/fraction.dart';

class ConvertUnitsUseCase {
  String execute(Fraction inches) {
    try {
      final isNegative = inches.numerator < 0;
      final absolute = Fraction(inches.numerator.abs(), inches.denominator).reduce();

      final totalInches = absolute.toDouble();
      final feet = (totalInches / 12).truncate();
      final remainingInches = absolute - Fraction(feet * 12);

      final feetStr = feet > 0 ? "$feet ft " : "";
      final inchesStr = "${_formatFraction(remainingInches)} in";

      return "${isNegative ? "-" : ""}$feetStr$inchesStr";
    } catch (e) {
      return "0 in";
    }
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