import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:handi_calc/features/splash_feature/presentation/screens/splash_screen.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'features/calculator/domain/usecases/calculator_use_case.dart';
import 'features/calculator/domain/usecases/convert_units_use_case.dart';
import 'features/calculator/domain/usecases/format_fraction_use_case.dart';
import 'features/calculator/domain/usecases/parse_fraction_use_case.dart';
import 'features/calculator/presentation/blocs/calculator_bloc.dart';
import 'features/splash_feature/presentation/bloc/splash_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SplashBloc()),
            BlocProvider(
              create: (context) => CalculatorBloc(
                calculate: CalculatorUseCase(),
                convertUnits: ConvertUnitsUseCase(),
                formatFraction: FormatFractionUseCase(),
                parseFraction: ParseFractionUseCase(),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Calculator',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
