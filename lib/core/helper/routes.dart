
import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:booking_clinics_doctor/features/auth/ui/views/onboarding_screen2.dart';
import 'package:booking_clinics_doctor/features/auth/ui/views/signin.dart';
import 'package:booking_clinics_doctor/features/auth/ui/views/signup.dart';
import 'package:flutter/material.dart';


// ! _____ App Routes Here (OnGenerate Approach for Example) _____ ! //
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.navRoute:
      //   return MaterialPageRoute(builder: (_) => const NavView());
      // case Routes.doctorDetailsRoute:
      //   return MaterialPageRoute(
      //     builder: (_) {
      //       final args = settings.arguments as Map<String, dynamic>;
      //       return BlocProvider<DoctorCubit>(
      //         create: (_) => DoctorCubit(getIt.get<FirebaseFirestoreService>())
      //           ..fetchFavorites(args["patientName"])
      //           ..fetchDoctorById(args["doctorId"]),
      //         child: DoctorDetailsView(
      //           doctorId: args['doctorId'],
      //           patientName: args['patientName'],
      //         ),
      //       );
      //     },
      //   );
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case Routes.signin:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      // case Routes.forgetPassword:
      //   return MaterialPageRoute(builder: (_) => const ForgetPassword());
      // case Routes.favoriteView:
      //   return MaterialPageRoute(builder: (_) => const FavoriteView());
      // case Routes.editYourProfile:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider<ProfileCubit>.value(
      //       value: context.read<ProfileCubit>(),
      //       child: const EditYourProfile(),
      //     ),
      //   );
      // case Routes.bookAppointmentRoute:
      //   return MaterialPageRoute(builder: (_) {
      //     final args = settings.arguments as Map<String, dynamic>;
      //     return BookAppointmentView(
      //       doctorId: args['doctorId'],
      //       doctorName: args['doctorName'],
      //       doctorSpeciality: args['doctorSpeciality'],
      //       doctorAddress: args['doctorAddress'],
      //       doctorImageUrl: args['doctorImageUrl'],
      //       patientName: args['patientName'],
      //     );
      //   });
      // case Routes.seeAll:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider<SeeAllCubit>(
      //       create: (_) => SeeAllCubit(getIt.get<SeeAllRepoImpl>()),
      //       child: SeeAllView(firstIndex: settings.arguments as int?),
      //     ),
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
