import 'package:booking_clinics_doctor/core/constant/const_color.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/model/chart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../appointment/manager/appointment_cubit.dart';

class CustomBarChart extends StatelessWidget {
  final WeeklyBookingData weeklyData;
  const CustomBarChart({super.key, required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.0,
      child: BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (_, state) {
          return BarChart(
            swapAnimationDuration: const Duration(milliseconds: 300),
            BarChartData(
              minY: 0,
              maxY: state is AppointmentSuccess ? null : 10,
              titlesData: tilesData(),
              barGroups: _createBarGroups(state),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipPadding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.5.h,
                  ),
                  tooltipMargin: 1.w,
                  tooltipRoundedRadius: 4.w,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String status;
                    switch (rodIndex) {
                      case 0:
                        status = 'Pending';
                        break;
                      case 1:
                        status = 'Completed';
                        break;
                      case 2:
                        status = 'Canceled';
                        break;
                      default:
                        status = '';
                    }
                    return BarTooltipItem(
                      '$status: ${rod.toY.toInt()}',
                      TextStyle(
                        fontSize: 14.sp,
                        color: rod.gradient!.colors.first,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                  getTooltipColor: (val) {
                    return ConstColor.iconDark.color;
                  },
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              alignment: BarChartAlignment.spaceAround,
            ),
          );
        },
      ),
    );
  }

  Widget _getDayTitle(int index) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Text(days[index],
        style: const TextStyle(fontWeight: FontWeight.bold));
  }

  double _getMaxYValue() {
    // ! Find the maximum value from all booking counts to set the y-axis limit
    return weeklyData.days.values
            .expand((dayMap) => [
                  dayMap.pending,
                  dayMap.completed,
                  dayMap.canceled,
                ])
            .reduce((max, count) => count > max ? count : max)
            .toDouble() +
        2;
  }

  List<BarChartGroupData> _createBarGroups(AppointmentState state) {
    const List<double> days = [0, 1, 2, 3, 4, 5, 6];
    return days.asMap().entries.map((entry) {
      double day = entry.value;
      ChartData bookingCount = weeklyData.days[day] ?? ChartData();
      return BarChartGroupData(
        x: entry.key,
        barRods: state is AppointmentSuccess
            ? [
                BarChartRodData(
                  width: 2.w,
                  toY: bookingCount.pending,
                  gradient: blueToPurpleGradient,
                ),
                BarChartRodData(
                  width: 2.w,
                  toY: bookingCount.completed,
                  gradient: greenToTealGradient,
                ),
                BarChartRodData(
                  width: 2.w,
                  toY: bookingCount.canceled,
                  gradient: orangeToRedGradient,
                ),
              ]
            : [],
      );
    }).toList();
  }

  static FlTitlesData tilesData() {
    return FlTitlesData(
      topTitles: const AxisTitles(axisNameSize: 0),
      leftTitles: const AxisTitles(axisNameSize: 0),
      rightTitles: const AxisTitles(axisNameSize: 0),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            String text = "";
            switch (value.toInt()) {
              case 0:
                text = 'Sun';
              case 1:
                text = 'Mon';
              case 2:
                text = 'Tus';
              case 3:
                text = 'Wed';
              case 4:
                text = 'Thu';
              case 5:
                text = 'Fri';
              case 6:
                text = 'Sat';
              default:
                return const SizedBox.shrink();
            }
            return Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Text(text),
            );
          },
        ),
      ),
    );
  }

  final Gradient blueToPurpleGradient = const LinearGradient(
    colors: [
      Color(0xFF42A5F5), // Light Blue
      Color(0xFF7B1FA2), // Deep Purple
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  final Gradient greenToTealGradient = const LinearGradient(
    colors: [
      Color(0xFF66BB6A), // Medium Green
      Color(0xFF26A69A), // Teal
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  final Gradient orangeToRedGradient = const LinearGradient(
    colors: [
      Color(0xFFFFA726), // Orange
      Color(0xFFEF5350), // Red
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
