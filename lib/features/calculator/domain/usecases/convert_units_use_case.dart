import 'package:fraction/fraction.dart';

class ConvertUnitsUseCase {
  String execute(Fraction inches, bool isSquare) {
    if (isSquare) {
      final totalSqIn = inches.toDouble();
      final wholeSqFt = (totalSqIn / 144).floor();
      final remainderSqIn = totalSqIn % 144;

      // Correctly compute decimal part using 144
      final decimalPart = remainderSqIn / 144;

      // Format to 3 decimal places
      final formattedDecimal = decimalPart.toStringAsFixed(3);

      return "$wholeSqFt.${formattedDecimal.split('.')[1]} sq ft";
    } else {
      // Existing linear conversion
      final totalInches = inches;
      final wholeFeet = (totalInches / Fraction(12)).toDouble().truncate();
      final remainderInches = totalInches - Fraction(wholeFeet * 12);

      return "${wholeFeet.toInt()} ft ${formatFraction(remainderInches)} in";
    }
  }

  String formatFraction(Fraction fraction) {
    fraction = fraction.reduce();
    final integerPart = fraction.toDouble().truncate();
    final fractionalPart = fraction - Fraction(integerPart);

    return integerPart == 0
        ? fraction.toString()
        : "$integerPart ${fractionalPart.toString()}";
  }
}