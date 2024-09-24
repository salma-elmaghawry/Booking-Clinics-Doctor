import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'booking_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  BookAppointmentCubit() : super(BookAppointmentInitial());

  DateTime _selectedDate = DateTime.now();
  String? _selectedHour;

  List<String> get hours => [
    "09.00 AM",
    "09.30 AM",
    "10.00 AM",
    "10.30 AM",
    "11.00 AM",
    "11.30 AM",
    "3.00 PM",
    "3.30 PM",
    "4.00 PM",
    "4.30 PM",
    "5.00 PM",
    "5.30 PM",
  ];

  void selectDate(DateTime date) {
    _selectedDate = date;
    emit(DateSelectedState(date));
  }

  void selectHour(String hour) {
    _selectedHour = hour;
    emit(HourSelectedState(_selectedDate, hour));
  }

  DateTime get selectedDate => _selectedDate;
  String? get selectedHour => _selectedHour;

  // Method to get the formatted date
  String getFormattedDate() {
    return DateFormat('yyyy-MM-dd').format(_selectedDate);
  }
}