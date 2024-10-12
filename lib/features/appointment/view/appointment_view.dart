import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../manager/appointment_cubit.dart';
import '../widgets/booking_tab.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const List<String> _status = ["Pending", "Completed", "Canceled"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<AppointmentCubit>();
    return DefaultTabController(
      length: _status.length,
      child: Scaffold(
        // extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My Bookings'),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _tabController,
            padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 1.h),
            tabs: List.generate(
              _status.length,
              (index) => Tab(text: _status[index]),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: List.generate(
            _status.length,
            (index) => BookingTab(
              status: _status[index],
              bookings: index == 0
                  ? read.pending
                  : index == 1
                      ? read.completed
                      : read.canceled,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
