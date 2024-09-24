import 'package:sizer/sizer.dart';
import '../widget/see_all_tab.dart';
import '../manager/see_all_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/loading_indicator.dart';
import 'package:booking_clinics_doctor/core/constant/extension.dart';

class SeeAllView extends StatefulWidget {
  final int? firstIndex;
  const SeeAllView({this.firstIndex = 0, super.key});

  @override
  State<SeeAllView> createState() => _SeeAllViewState();
}

class _SeeAllViewState extends State<SeeAllView> with TickerProviderStateMixin {
  late final TabController _tabController;
  static const List<String> _specialty = [
    "All",
    "cardiologist",
    "Dentistry",
    "Dermatology",
    "Pediatrics",
    "Orthopedics",
    "Neurology",
    "Psychiatry",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: _specialty.length,
      initialIndex: widget.firstIndex ?? 0,
    );
    _onChangeTap();
    _tabController.addListener(() async {
      await _onChangeTap();
    });
  }

  Future<void> _onChangeTap() async {
    _tabController.index == 0
        ? await context.read<SeeAllCubit>().invokeAllDoctors()
        : await context
            .read<SeeAllCubit>()
            .invokeBySpecialty(_specialty[_tabController.index]);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController
      ..removeListener(() {})
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _specialty.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 7.h,
          title: Text("All Doctors", style: context.bold18),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            onTap: (val) {},
            isScrollable: true,
            controller: _tabController,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 1.h),
            tabs: List.generate(
              _specialty.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Tab(text: _specialty[index], height: 5.h),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: List.generate(
            _specialty.length,
            (index) {
              return BlocBuilder<SeeAllCubit, SeeAllState>(
                builder: (context, state) {
                  if (state is SeeAllSuccess) {
                    if (state.doctors.isEmpty) {
                      return Center(
                        child: Text(
                          "No doctors found",
                          style: context.semi16,
                        ),
                      );
                    } else {
                      return SeeAllTab(state.doctors);
                    }
                  } else if (state is SeeAllFailure) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return const LoadingIndicator();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

