import 'booking.dart';
import 'review.dart';

final class DoctorModel {
  final String id, name, speciality, email;
  final String? imageUrl, workingHours, address, phone, about;
  final int? patientsNumber, experience;
  final double? rating;

  final Map<String, dynamic> location;
  final List<Booking> bookings;
  final List<Review> reviews;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.speciality,
    required this.email,
    required this.location,
    this.patientsNumber,
    this.experience,
    this.rating,
    this.imageUrl,
    this.workingHours,
    this.address,
    this.phone,
    this.about,
    required this.bookings,
    required this.reviews,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      speciality: json['speciality'],
      email: json['email'],
      location: Map<String, dynamic>.from(json['location']),
      patientsNumber: json['patientsNumber'],
      experience: json['experience'],
      rating: json['rating']?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'],
      workingHours: json['workingHours'],
      address: json['address'],
      phone: json['phone'],
      about: json['about'],
      bookings: List<Booking>.from(json['bookings'].map((x) => Booking.fromJson(x))),
      reviews: List<Review>.from(json['reviews'].map((x) => Review.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'speciality': speciality,
      'email': email,
      'location': location,
      'patientsNumber': patientsNumber,
      'experience': experience,
      'rating': rating,
      'imageUrl': imageUrl,
      'workingHours': workingHours,
      'address': address,
      'phone': phone,
      'about': about,
      'bookings': bookings.map((x) => x.toJson()).toList(),
      'reviews': reviews.map((x) => x.toJson()).toList(),
    };
  }
}
