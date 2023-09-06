
class Event {

  Event({
    required this.title,
    this.id,
    this.location,
    this.startDate,
    this.endDate,
    this.description,
    this.userId,
    this.isRecurring
  });

  String title;
  int? id;
  String? location;
  String? startDate;
  String? endDate;
  String? description;
  bool? isRecurring;
  int? userId ;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"],
    title: json["title"].toString(),
    location: json["location"].toString(),
    startDate: json["start_date"].toString(),
    endDate: json["end_date"].toString(),
    description:  json["description"].toString(),
   // userId: json["user_id"].toInt(),
    userId: 1,
    isRecurring: json["repeat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title" : title,
    "location" : location,
    "description" : description,
    "start_date": startDate,
    "end_date": endDate,
    "user_id": userId,
    "is_recurring" : isRecurring,
  };
}

