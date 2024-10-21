import 'package:booking_clinics_doctor/core/constant/const_string.dart';
import 'package:booking_clinics_doctor/core/helper/service_locator.dart';
import 'package:booking_clinics_doctor/features/auth/ui/views/onboarding_screen2.dart';
import 'package:booking_clinics_doctor/features/auth/ui/views/signin.dart';
import 'package:booking_clinics_doctor/features/auth/ui/views/signup.dart';
import 'package:booking_clinics_doctor/features/chats/ui/chat_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/chat_model.dart';
import '../../data/services/remote/firebase_firestore.dart';
import '../../features/auth/ui/views/forget_password.dart';
import '../../features/booking/cubit/doc_details_cubit.dart';
import '../../features/booking/ui/doctor_details.dart';
import '../../features/chats/cubit/chat_details_cubit.dart';
import '../../features/home/ui/view/nav_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.navRoute:
        return MaterialPageRoute(builder: (_) => const NavView());
      case Routes.doctorDetailsRoute:
        return MaterialPageRoute(
          builder: (_) {
            final args = settings.arguments as Map<String, dynamic>;
            return BlocProvider<DoctorCubit>(
              create: (_) => DoctorCubit(getIt.get<FirebaseFirestoreService>())
                ..fetchDoctorById(args["doctorId"]),
              child: DoctorDetailsView(
                doctorId: args['doctorId'],
                doctorName: args['doctorName'],
              ),
            );
          },
        );
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case Routes.signin:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case Routes.chatDetailsRoute:
        final chatModel = settings.arguments as ChatModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ChatDetailCubit(
              FirebaseFirestore.instance,
              chatModel.chatId,
            )..listenToMessages(),
            child: ChatDetailScreen(
              chatId: chatModel.chatId,
              chatPartnerName: chatModel.chatPartnerName,
              chatPartnerId: chatModel.chatPartnerId,
            ),
          ),
        );
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
