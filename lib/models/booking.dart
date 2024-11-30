class Booking {
  final String id;
  final String userId;
  final int eventId;
  final int ticketCount;
  final DateTime bookingDate;

  Booking({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.ticketCount,
    required this.bookingDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      eventId: int.tryParse(json['eventId'].toString()) ?? 0, 
      ticketCount: int.tryParse(json['ticketCount'].toString()) ?? 0, 
      bookingDate: DateTime.parse(json['bookingDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'eventId': eventId,
      'ticketCount': ticketCount,
      'bookingDate': bookingDate.toIso8601String(),
    };
  }
}
