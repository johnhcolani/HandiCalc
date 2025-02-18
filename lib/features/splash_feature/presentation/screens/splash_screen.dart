import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handi_calc/features/splash_feature/presentation/bloc/splash_bloc.dart';
import 'package:handi_calc/features/splash_feature/presentation/bloc/splash_event.dart';

import '../../../../fraction_calculator_screen.dart';
import '../../../calculator/presentation/screens/fraction_calculator_screen.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SplashBloc>().add(StartSplash());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if(state is SplashCompleted){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FractionCalculatorScreen()));
        }else{
          CircularProgressIndicator();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFF191818FF),
        body: Center(
          child: SizedBox(
              width: 300,
              child: Image.asset('assets/images/Splash.gif',fit: BoxFit.cover,)),
        ),
      ),
    );
  }
}
