

import 'package:booking_clinics_doctor/data/models/booking.dart';
import 'package:booking_clinics_doctor/data/models/favorite.dart';

class Patient {
  final String uid, name, email, phone, birthDate, profileImg;
  final List<Booking> bookings;
  final List<Favorite> favorites;

  const Patient({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.profileImg,
    required this.bookings,
    required this.favorites,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      birthDate: json["birth_date"],
      profileImg: json["profile_image"],
      bookings: List<Booking>.from(json["bookings"].map((x) => Booking.fromJson(x))),
      favorites: List<Favorite>.from(json["favorites"].map((x) => Favorite.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "birth_date": birthDate,
      "profile_image": profileImg,
      "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
      "favorites": List<dynamic>.from(favorites.map((x) => x.toJson())),
    };
  }
}
