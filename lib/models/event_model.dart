class Event {
  final String id;
  final String title;
  final String description;
  final String date;
  final String location;
  final String image;
  final String price;
  final bool isRegistered;
  final String category;
  final String time;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.image,
    required this.price,
    required this.isRegistered,
    required this.category,
    required this.time,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      location: json['location'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? "Free",
      isRegistered: json['isRegistered'] ?? false,
      category: json['category'] ?? "General",
      time: json['time'] ?? '',
    );
  }
}
