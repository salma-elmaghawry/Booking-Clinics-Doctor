import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:booking_clinics_doctor/core/helper/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'core/helper/observer.dart';
import 'core/helper/service_locator.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'data/services/remote/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'features/profile/manager/theme_manager/theme_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // ! _____ App Setup & Initialization _____ ! //
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  Bloc.observer = Observer();
  // ! _____ Prevent Device Orientation _____ ! //
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  bool isUserLoggedIn = await FirebaseAuthService().isLoggedIn();
  // ! _____
  runApp(BookingClinics(isUserLoggedIn: isUserLoggedIn));
}

class BookingClinics extends StatelessWidget {
  const BookingClinics({super.key, required this.isUserLoggedIn});

  final bool isUserLoggedIn;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (_, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()..loadTheme()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode?>(
            builder: (context, themeMode) {
              if (themeMode == null) return const SizedBox.shrink();
              return MaterialApp(
                builder: (_, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: const TextScaler.linear(1.125),
                    ),
                    child: child!,
                  );
                },
                theme: lightTheme(),
                darkTheme: darkTheme(),
                themeMode: themeMode,
                title: 'Hagzy-Dashboard',
                debugShowCheckedModeBanner: false,
                initialRoute:
                    isUserLoggedIn ? Routes.navRoute : Routes.onboarding,
                onGenerateRoute: AppRouter.generateRoute,
              );
            },
          ),
        );
      },
    );
  }
}
