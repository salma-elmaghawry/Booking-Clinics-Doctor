import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:booking_clinics_doctor/core/helper/service_locator.dart';
import 'package:booking_clinics_doctor/features/chats/ui/chats_view.dart';
import 'package:booking_clinics_doctor/features/map/data/repo/location_repo/location_repo_imp.dart';
import 'package:booking_clinics_doctor/features/map/data/repo/map_repo/map_impl.dart';
import 'package:booking_clinics_doctor/features/map/data/repo/routes_repo/routes_impl.dart';
import 'package:booking_clinics_doctor/features/map/ui/manager/map_cubit.dart';
import 'package:booking_clinics_doctor/features/map/ui/view/map_view.dart';
import 'package:booking_clinics_doctor/features/profile/ui/view/profile_view.dart';
import 'package:booking_clinics_doctor/features/see_all/data/see_all_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import '../../../../data/services/remote/firebase_auth.dart';
import '../../../appointment/manager/appointment_cubit.dart';
import '../../../appointment/view/appointment_view.dart';
import '../../../profile/ui/profile_manager/profile_cubit.dart';
import '../../../see_all/ui/manager/see_all_cubit.dart';
import '../../../see_all/ui/view/see_all_view.dart';

class NavView extends StatefulWidget {
  const NavView({super.key});

  @override
  State<NavView> createState() => _NavViewState();
}

class _NavViewState extends State<NavView> {
  int _index = 0;
  static final List<Widget> _pages = [
    // All Doctors
    BlocProvider<SeeAllCubit>(
      create: (_) => SeeAllCubit(
        getIt.get<SeeAllRepoImpl>(),
      )..invokeAllDoctors(),
      child: const SeeAllView(),
    ),
    // Map
    BlocProvider(
      create: (_) => MapCubit(
        mapRepo: getIt.get<MapImpl>(),
        routesRepo: getIt.get<RoutesImpl>(),
        locationRepo: getIt.get<LocationImpl>(),
      )..predectPlaces(),
      child: const MapView(),
    ),
    // Appointment
    BlocProvider<AppointmentCubit>(
      create: (_) => AppointmentCubit(getIt.get<FirebaseAuthService>()),
      child: const AppointmentView(),
    ),
    // Chat
    const ChatListScreen(),
    // Profile
    BlocProvider<ProfileCubit>(
      create: (_) => ProfileCubit()..getUserData(),
      child: const ProfileView(),
    ),
  ];
  static const List<IconData> _icons = [
    Iconsax.home,
    Iconsax.location4,
    Iconsax.calendar_1,
    Iconsax.messages,
    Iconsax.user4,
  ];
  static const List<IconData> _iconsFill = [
    Iconsax.home1,
    Iconsax.location5,
    Iconsax.calendar5,
    Iconsax.messages_15,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: _index == 1,
      resizeToAvoidBottomInset: false,
      body: _pages[_index],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(4.w),
        child: BottomAppBar(
          height: 7.5.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int index = 0; index < _pages.length; index++) ...[
                IconButton(
                  onPressed: () {
                    setState(() => _index = index);
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: _index == index &&
                            MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                        ? ConstColor.primary.color
                        : _index == index
                            ? ConstColor.secondary.color
                            : Colors.transparent,
                  ),
                  icon: Icon(
                    index == _index ? _iconsFill[index] : _icons[index],
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? _index == index
                            ? ConstColor.dark.color
                            : ConstColor.secondary.color
                        : ConstColor.dark.color,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
