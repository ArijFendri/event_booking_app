class Event {
  final int id;
  final String title;
  final String date;
  final String location;
  final double price;
  final String category;
  final String image;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.price,
    required this.category,
    required this.image,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      location: json['location'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'location': location,
      'price': price,
      'category': category,
      'image': image,
    };
  }
}
