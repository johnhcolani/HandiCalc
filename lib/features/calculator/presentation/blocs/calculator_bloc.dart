import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fraction/fraction.dart';
import '../../domain/usecases/calculator_use_case.dart';
import '../../domain/usecases/convert_units_use_case.dart';
import '../../domain/usecases/format_fraction_use_case.dart';
import '../../domain/usecases/parse_fraction_use_case.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculateUseCase calculate;
  final ConvertUnitsUseCase convertUnits;
  final FormatFractionUseCase formatFraction;
  final ParseFractionUseCase parseFraction;

  String _expressionBuffer = '';
  String _displayBuffer = '0';

  CalculatorBloc({
    required this.calculate,
    required this.convertUnits,
    required this.formatFraction,
    required this.parseFraction,
  }) : super(CalculatorState(
    displayText: '0',
    expression: '',
    linearResult: '',
    squareResult: '',
  )) {
    on<ClearEvent>(_handleClear);
    on<DigitEvent>(_handleDigit);
    on<FractionEvent>(_handleFraction);
    on<OperatorEvent>(_handleOperator);
    on<ParenthesisEvent>(_handleParenthesis);
    on<EqualsEvent>(_handleEquals);
    on<NegateEvent>(_handleNegate);
    on<PercentEvent>(_handlePercent);
    on<BackspaceEvent>(_handleBackspace);
  }
  void _handleBackspace(BackspaceEvent event, Emitter<CalculatorState> emit) {
    if (_expressionBuffer.isNotEmpty) {
      // Remove the last character from both buffers
      _expressionBuffer = _expressionBuffer.substring(0, _expressionBuffer.length - 1);
      _displayBuffer = _displayBuffer.length > 1
          ? _displayBuffer.substring(0, _displayBuffer.length - 1)
          : '0';

      emit(state.copyWith(
        displayText: _displayBuffer,
        expression: _expressionBuffer,
      ));
    }
  }
  void _handleClear(ClearEvent event, Emitter<CalculatorState> emit) {
    _expressionBuffer = '';
    _displayBuffer = '0';
    emit(state.copyWith(
      displayText: '0',
      expression: '',
      linearResult: '',
      squareResult: '',
    ));
  }

  void _handleDigit(DigitEvent event, Emitter<CalculatorState> emit) {
    if (_displayBuffer == '0' || _expressionBuffer.endsWith(')')) {
      _displayBuffer = event.digit;
    } else {
      _displayBuffer += event.digit;
    }
    _expressionBuffer += event.digit;
    emit(state.copyWith(
      displayText: _displayBuffer,
      expression: _expressionBuffer,
      linearResult: state.linearResult,
      squareResult: state.squareResult,
    ));
  }

  void _handleFraction(FractionEvent event, Emitter<CalculatorState> emit) {
    String newFraction = event.fraction.replaceAll('"', '');
    String quotedFraction;

    // Check if the last part of the expression buffer is a whole number
    String possibleNumber = '';
    int i = _expressionBuffer.length - 1;

    // Skip trailing spaces
    while (i >= 0 && _expressionBuffer[i] == ' ') {
      i--;
    }

    // Extract the last contiguous digits
    while (i >= 0 && _expressionBuffer[i].contains(RegExp(r'[0-9]'))) {
      possibleNumber = _expressionBuffer[i] + possibleNumber;
      i--;
    }

    if (possibleNumber.isNotEmpty) {
      // Combine with the new fraction to form a mixed number
      String mixedNumber = '$possibleNumber $newFraction';
      _displayBuffer = mixedNumber;

      // Replace the extracted number with the mixed number in quotes
      int startIndex = i + 1;
      _expressionBuffer = _expressionBuffer.substring(0, startIndex) +
          '"$mixedNumber"'; // Ensure quotes are added here

      // Add space before the quoted mixed number if needed
      if (startIndex > 0 && _expressionBuffer[startIndex - 1] != ' ') {
        _expressionBuffer = _expressionBuffer.substring(0, startIndex) +
            ' ' +
            _expressionBuffer.substring(startIndex);
      }
    } else {
      _displayBuffer = newFraction;
      quotedFraction = '"$newFraction"'; // Always wrap new fractions in quotes
      if (_expressionBuffer.isEmpty || _expressionBuffer.endsWith(' ')) {
        _expressionBuffer += quotedFraction;
      } else {
        _expressionBuffer += ' $quotedFraction';
      }
    }

    emit(state.copyWith(
      displayText: _displayBuffer,
      expression: _expressionBuffer,
      linearResult: state.linearResult,
      squareResult: state.squareResult,
    ));
  }

  void _handleOperator(OperatorEvent event, Emitter<CalculatorState> emit) {
    // Add operator with spaces to ensure tokenization works
    _expressionBuffer += ' ${event.operator} ';
    _displayBuffer = event.operator;
    emit(state.copyWith(
      displayText: _displayBuffer,
      expression: _expressionBuffer,
      linearResult: state.linearResult,
      squareResult: state.squareResult,
    ));
  }

  void _handleParenthesis(ParenthesisEvent event, Emitter<CalculatorState> emit) {
    final parenthesis = event.isOpen ? '(' : ')';
    _expressionBuffer += ' $parenthesis ';
    _displayBuffer = parenthesis;
    emit(state.copyWith(
      displayText: _displayBuffer,
      expression: _expressionBuffer,
      linearResult: state.linearResult,
      squareResult: state.squareResult,
    ));
  }

  void _handleEquals(EqualsEvent event, Emitter<CalculatorState> emit) {
    try {
      final result = _evaluateExpression(_expressionBuffer);
      final formattedResult = formatFraction.execute(result);
      final linear = convertUnits.execute(result, false);
      final square = convertUnits.execute(result, true);

      emit(state.copyWith(
        displayText: formattedResult,
        expression: '$_expressionBuffer = $formattedResult',
        linearResult: linear,
        squareResult: square,
      ));
      _expressionBuffer = formattedResult;
      _displayBuffer = formattedResult;
    } catch (e) {
      print('Evaluation error: $e'); // Debug output
      emit(state.copyWith(
        displayText: 'Error',
        expression: _expressionBuffer,
        linearResult: state.linearResult,
        squareResult: state.squareResult,
      ));
    }
  }

  void _handleNegate(NegateEvent event, Emitter<CalculatorState> emit) {
    if (_displayBuffer.isNotEmpty && _displayBuffer != '0') {
      if (_displayBuffer.startsWith('-')) {
        _displayBuffer = _displayBuffer.substring(1);
        _expressionBuffer = _expressionBuffer.replaceRange(
            _expressionBuffer.lastIndexOf(' "-'), null, ' "');
      } else {
        _displayBuffer = '-$_displayBuffer';
        _expressionBuffer = _expressionBuffer.replaceRange(
            _expressionBuffer.length - _displayBuffer.length - 1, null, '"-$_displayBuffer"');
      }
      emit(state.copyWith(
        displayText: _displayBuffer,
        expression: _expressionBuffer,
        linearResult: state.linearResult,
        squareResult: state.squareResult,
      ));
    }
  }

  void _handlePercent(PercentEvent event, Emitter<CalculatorState> emit) {
    final currentValue = parseFraction.execute(_displayBuffer);
    final percentValue = currentValue / Fraction(100);
    _displayBuffer = formatFraction.execute(percentValue);
    _expressionBuffer += ' % ';
    emit(state.copyWith(
      displayText: _displayBuffer,
      expression: _expressionBuffer,
      linearResult: state.linearResult,
      squareResult: state.squareResult,
    ));
  }

  Fraction _evaluateExpression(String expression) {
    final tokens = _tokenize(expression);
    final List<Fraction> values = [];
    final List<String> operators = [];

    print('Tokens: $tokens'); // Debug: Print tokens to verify

    for (var token in tokens) {
      if (_isNumber(token)) {
        // Handle both quoted and unquoted tokens
        final cleanToken = token.replaceAll('"', '');
        values.add(parseFraction.execute(cleanToken));
      } else if (token == '(') {
        operators.add(token);
      } else if (token == ')') {
        while (operators.isNotEmpty && operators.last != '(') {
          _applyOperator(values, operators.removeLast());
        }
        if (operators.isEmpty) throw Exception('Mismatched parentheses');
        operators.removeLast(); // Remove '('
      } else if (_isOperator(token)) {
        while (operators.isNotEmpty &&
            operators.last != '(' &&
            _precedence(operators.last) >= _precedence(token)) {
          _applyOperator(values, operators.removeLast());
        }
        operators.add(token);
      } else {
        throw Exception('Invalid token: $token');
      }
    }

    while (operators.isNotEmpty) {
      if (operators.last == '(') throw Exception('Mismatched parentheses');
      _applyOperator(values, operators.removeLast());
    }

    if (values.length != 1) throw Exception('Invalid expression');
    return values.first;
  }

  List<String> _tokenize(String expression) {
    final List<String> tokens = [];
    String buffer = '';
    bool inQuotes = false;

    for (int i = 0; i < expression.length; i++) {
      final char = expression[i];
      if (char == '"') {
        if (inQuotes) {
          tokens.add('"$buffer"'); // Add the quoted token
          buffer = '';
        }
        inQuotes = !inQuotes;
      } else if (char == ' ' && !inQuotes) {
        if (buffer.isNotEmpty) {
          tokens.add(buffer);
          buffer = '';
        }
      } else {
        buffer += char;
      }
    }
    if (buffer.isNotEmpty) tokens.add(buffer);
    return tokens.where((t) => t.isNotEmpty).toList();
  }

  void _applyOperator(List<Fraction> values, String operator) {
    if (values.length < 2) throw Exception('Invalid expression');
    final b = values.removeLast();
    final a = values.removeLast();
    final result = calculate.execute(a, b, operator);
    values.add(result);
  }

  bool _isNumber(String token) =>
      token.startsWith('"') || // Quoted fractions/mixed numbers like "1/2" or "1 1/2"
          RegExp(r'^-?\d+(/\d+)?$').hasMatch(token) || // Matches "1/2", "-5/3"
          RegExp(r'^\d+$').hasMatch(token); // Matches digits like "4", "10", "45"

  bool _isOperator(String token) => ['+', '-', '×', '÷'].contains(token);

  int _precedence(String operator) => switch (operator) {
    '+' || '-' => 1,
    '×' || '÷' => 2,
    _ => 0,
  };
}