class WeeklyBookingData {
  Map<double, ChartData> days;

  WeeklyBookingData()
      : days = {
          0: ChartData(),
          1: ChartData(),
          2: ChartData(),
          3: ChartData(),
          4: ChartData(),
          5: ChartData(),
          6: ChartData(),
        };

  void updateBooking(double day, String status) {
    if (days.containsKey(day)) days[day]!.increment(status);
  }
}

class ChartData {
  double pending;
  double completed;
  double canceled;
  ChartData({this.pending = 0, this.completed = 0, this.canceled = 0});

  // ! Increment count based on booking status
  void increment(String status) {
    switch (status) {
      case 'Pending':
        pending++;
        break;
      case 'Completed':
        completed++;
        break;
      case 'Canceled':
        canceled++;
        break;
      default:
        break;
    }
  }
}
