import 'package:booking_clinics_doctor/core/common/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/const_color.dart';
import '../../../data/services/remote/firebase_auth.dart';
import 'widgets/booking_appbar.dart';
import 'widgets/build_booking_card.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _patientsCollection = 'patients';

  Future<List<Map<String, dynamic>>> fetchBookings(String status) async {
    try {
      String? patientId = await FirebaseAuthService().getUid();

      final patientRef = _firestore.collection(_patientsCollection).doc(patientId);
      final docSnapshot = await patientRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null && data['bookings'] != null) {
          final bookingsJson = List<Map<String, dynamic>>.from(data['bookings']);
          // Filter bookings by status
          return bookingsJson.where((booking) => booking['bookingStatus'] == status).toList();
        }
      }
      return [];
    } catch (e) {
      print('Error fetching bookings: $e');
      throw Exception('Failed to fetch bookings');
    }
  }
}

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final BookingService _bookingService = BookingService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookingAppBar(tabController: _tabController),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildBookingsTab(context, 'Pending'),
          buildBookingsTab(context, 'Completed'),
          buildBookingsTab(context, 'Canceled'), 
        ],
      ),
    );
  }

  Widget buildBookingsTab(BuildContext context, String status) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _bookingService.fetchBookings(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading bookings'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No bookings available'));
        }

       // final bookings = snapshot.data!;
        final bookings = [];

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 90),
          itemCount: bookings.length,
          separatorBuilder: (_, __) => const SizedBox(height: 6),
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return buildBookingCard(
              context,
              date: booking['date'],
              time: booking['time'],
              doctorName: booking['docName'],
              specialization: booking['docSpeciality'],
              clinic: booking['docAddress'],
              imageUrl: booking['docImageUrl'],
              buttons: _buildActionButtons(status),
            );
          },
        );
      },
    );
  }

  // Build action buttons dynamically based on status
  Widget _buildActionButtons(String status) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    if (status == 'Pending') {
      return Row(
        children: [
          const Expanded(
            child: CustomButton(
              text: 'Cancel',
              color: MyColors.gray,
              textSize: 13,
              padding: EdgeInsets.all(12),
              textColor: MyColors.dark2,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: CustomButton(
              text: 'Reschedule',
              color: isDark ? MyColors.primary : MyColors.dark,
              textSize: 13,
              padding: const EdgeInsets.all(12),
              textColor: isDark ? MyColors.dark: Colors.white,
            ),
          ),
        ],
      );
    } else if (status == 'Completed') {
      return Row(
        children: [
          const Expanded(
            child: CustomButton(
              text: 'Re-Book',
              color: MyColors.gray,
              textSize: 13,
              padding: EdgeInsets.all(12),
              textColor: MyColors.dark2,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: CustomButton(
              text: 'Add Review',
              color: isDark ? MyColors.primary : MyColors.dark,
              textSize: 13,
              padding: const EdgeInsets.all(12),
              textColor: isDark ? MyColors.dark: Colors.white,
            ),
          ),
        ],
      );
    } else if (status == 'Canceled') {
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Re-Book',
              color: isDark ? MyColors.primary : MyColors.dark,
              textSize: 13,
              padding: const EdgeInsets.all(15),
              textColor: isDark ? MyColors.dark: Colors.white,
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
