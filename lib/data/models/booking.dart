class Booking {
  int isAccepted; // -1, 0, 1
  String id,
      name,
      date,
      time,
      address,
      imageUrl,
      specialty,
      personId,
      bookingId,
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
    required this.bookingId,
    required this.isAccepted,
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
      bookingId: json["booking_id"],
      isAccepted: json["is_accepted"],
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
      'booking_id': bookingId,
      'is_accepted': isAccepted,
      'booking_status': bookingStatus,
    };
  }
}
