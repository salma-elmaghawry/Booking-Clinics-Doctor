import 'package:booking_clinics_doctor/core/common/loading_indicator.dart';
import 'package:booking_clinics_doctor/features/appointment/manager/appointment_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/constant/const_color.dart';

class CustomLineChart extends StatelessWidget {
  const CustomLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<AppointmentCubit>();

    return AspectRatio(
      aspectRatio: 2,
      child: BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (_, state) {
          if (state is AppointmentSuccess) {
            return LineChart(
              LineChartData(
                minX: 0,
                minY: 0,
                maxX: 6,
                maxY: 15,
                gridData: _gridData(),
                borderData: _borderData(),
                titlesData: _titlesData(),
                // clipData: const FlClipData.all(),
                lineBarsData: [
                  LineChartBarData(
                    barWidth: 1.w,
                    isCurved: true,
                    // curveSmoothness: 0.25,
                    isStrokeCapRound: true,
                    // isStrokeJoinRound: true,
                    preventCurveOverShooting: true,
                    color: ConstColor.primary.color,
                    belowBarData: BarAreaData(
                      show: true,
                      color: ConstColor.primary.color.withOpacity(0.3),
                    ),
                    spots: List.generate(
                      read.pendingCoord.length,
                      (index) {
                        return FlSpot(
                          read.pendingCoord.keys.toList()[index],
                          read.pendingCoord.values.toList()[index],
                        );
                      },
                    ),
                  ),
                  LineChartBarData(
                    barWidth: 1.w,
                    isCurved: true,
                    // curveSmoothness: 0.25,
                    isStrokeCapRound: true,
                    // isStrokeJoinRound: true,
                    preventCurveOverShooting: true,
                    color: ConstColor.primary.color,
                    belowBarData: BarAreaData(
                      show: true,
                      color: ConstColor.primary.color.withOpacity(0.3),
                    ),
                    spots: List.generate(
                      read.canceledCoord.length,
                      (index) {
                        return FlSpot(
                          read.canceledCoord.keys.toList()[index],
                          read.canceledCoord.values.toList()[index],
                        );
                      },
                    ),
                  ),
                  LineChartBarData(
                    barWidth: 1.w,
                    isCurved: true,
                    // curveSmoothness: 0.25,
                    isStrokeCapRound: true,
                    // isStrokeJoinRound: true,
                    preventCurveOverShooting: true,
                    color: ConstColor.primary.color,
                    belowBarData: BarAreaData(
                      show: true,
                      color: ConstColor.primary.color.withOpacity(0.3),
                    ),
                    spots: List.generate(
                      read.completedCoord.length,
                      (index) {
                        return FlSpot(
                          read.completedCoord.keys.toList()[index],
                          read.completedCoord.values.toList()[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const LoadingIndicator();
          }
        },
      ),
    );
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      topTitles: const AxisTitles(axisNameSize: 0),
      rightTitles: const AxisTitles(axisNameSize: 0),
      leftTitles: const AxisTitles(axisNameSize: 0),
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

  FlBorderData _borderData() {
    return FlBorderData(
      show: false,
      border: Border(
        bottom: BorderSide(
          color: ConstColor.primary.color.withOpacity(0.2),
        ),
      ),
    );
  }

  FlGridData _gridData() {
    return FlGridData(
      drawVerticalLine: false,
      drawHorizontalLine: true,
      getDrawingHorizontalLine: (val) {
        return FlLine(
          strokeWidth: 0.25.w,
          color: ConstColor.icon.color,
        );
      },
    );
  }
}
