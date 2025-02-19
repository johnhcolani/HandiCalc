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

  Fraction _currentInput = Fraction(0);
  Fraction? _result;
  String _operator = '';
  String _expressionBuffer = '';
  int wholeNumberInput = 0;
  Fraction fractionalInput = Fraction(0);
  bool _isNewNumber = true;

  CalculatorBloc({
    required this.calculate,
    required this.convertUnits,
    required this.formatFraction,
    required this.parseFraction,
  }) : super(CalculatorState(
    displayText: '0',
    expression: '',
    inchResult: '',
    feetInchResult: '',
  )) {
    on<ClearEvent>(_onClear);
    on<NegateEvent>(_onNegate);
    on<OperatorEvent>(_onOperator);
    on<EqualsEvent>(_onEquals);
    on<DigitEvent>(_onDigit);
    on<FractionEvent>(_onFraction);
    on<PercentEvent>(_onPercent);
  }

  void _onClear(ClearEvent event, Emitter<CalculatorState> emit) {
    _expressionBuffer = '';
    _currentInput = Fraction(0);
    _result = null;
    _operator = '';
    wholeNumberInput = 0;
    fractionalInput = Fraction(0);
    _isNewNumber = true;

    emit(state.copyWith(
      displayText: '0',
      expression: '',
      inchResult: '',
      feetInchResult: '',
    ));
  }

  void _onNegate(NegateEvent event, Emitter<CalculatorState> emit) {
    _currentInput = _currentInput * Fraction(-1);
    _updateDisplay(emit);
  }

  void _onOperator(OperatorEvent event, Emitter<CalculatorState> emit) {
    if (_result == null) {
      _result = _currentInput;
      _expressionBuffer = formatFraction.execute(_currentInput);
    } else if (_operator.isNotEmpty) {
      _result = calculate.execute(_result!, _currentInput, _operator);
      _expressionBuffer +='${formatFraction.execute(_currentInput)}';
    }

    _operator = event.operator;
    _expressionBuffer += ' $_operator';
    emit(state.copyWith(
      expression: _expressionBuffer,
    ));
    _resetInput();
  }

  void _onEquals(EqualsEvent event, Emitter<CalculatorState> emit) {
    if (_result != null && _operator.isNotEmpty) {
      _result = calculate.execute(_result!, _currentInput, _operator);

      emit(state.copyWith(
        expression: '$_expressionBuffer ${formatFraction.execute(_currentInput)} = ${formatFraction.execute(_result!)}',
        displayText: formatFraction.execute(_result!),
        inchResult: "...",
        feetInchResult: "...",
      ));

      // Reset buffers
      _expressionBuffer = '';
      _result = null;
      _operator = '';
      _isNewNumber = true;
    }
  }
  void _onDigit(DigitEvent event, Emitter<CalculatorState> emit) {
    if (_isNewNumber) {
      wholeNumberInput = 0;
      fractionalInput = Fraction(0);
      _isNewNumber = false;
    }

    wholeNumberInput = wholeNumberInput * 10 + int.parse(event.digit);
    _currentInput = Fraction(wholeNumberInput) + fractionalInput;
    _updateDisplay(emit);
  }

  void _onFraction(FractionEvent event, Emitter<CalculatorState> emit) {
    fractionalInput = parseFraction.execute(event.fraction);
    _currentInput = Fraction(wholeNumberInput) + fractionalInput;
    _updateDisplay(emit);
    _isNewNumber = false;
  }

  void _onPercent(PercentEvent event, Emitter<CalculatorState> emit) {
    _currentInput = _currentInput / Fraction(100);
    _updateDisplay(emit);
    _isNewNumber = true;
  }

  void _updateDisplay(Emitter<CalculatorState> emit) {
    emit(state.copyWith(
      displayText: formatFraction.execute(_currentInput),
    ));
  }

  void _updateExpression(Emitter<CalculatorState> emit) {
    emit(state.copyWith(
      expression: "${formatFraction.execute(_result!)} $_operator",
    ));
  }

  void _resetInput() {
    _currentInput = Fraction(0);
    wholeNumberInput = 0;
    fractionalInput = Fraction(0);
    _isNewNumber = true;
  //  displayText = '0';
  }
}