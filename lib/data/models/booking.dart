class Booking {
  String id,
      name,
      date,
      time,
      address,
      imageUrl,
      specialty,
      personId,
      bookingStatus;

  Booking({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.address,
    required this.imageUrl,
    required this.specialty,
    required this.personId,
    required this.bookingStatus,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      time: json['time'],
      address: json['address'],
      imageUrl: json['image_url'],
      specialty: json['specialty'],
      personId: json["person_id"],
      bookingStatus: json["booking_status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'time': time,
      'address': address,
      'image_url': imageUrl,
      'specialty': specialty,
      'person_id': personId,
      'booking_status': bookingStatus,
    };
  }
}
