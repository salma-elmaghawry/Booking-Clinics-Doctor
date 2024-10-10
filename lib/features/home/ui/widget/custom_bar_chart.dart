import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:booking_clinics_doctor/core/constant/const_color.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: 22,
          borderData: FlBorderData(show: false),
          titlesData: tilesData(),
          gridData: const FlGridData(show: false),
          barGroups: List.generate(
            7,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  width: 3.5.w,
                  toY: 8 + index * 2,
                  color: ConstColor.primary.color,
                ),
                BarChartRodData(
                  width: 3.5.w,
                  toY: 20 - index * 2,
                  color: ConstColor.blue.color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
