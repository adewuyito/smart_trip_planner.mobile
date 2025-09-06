class Itinerary {
  final String title;
  final String startDate;
  final String endDate;
  final List<Day> days;

  Itinerary({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.days,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'days': days.map((day) => day.toJson()).toList(),
      };

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        title: json['title'] as String,
        startDate: json['startDate'] as String,
        endDate: json['endDate'] as String,
        days: (json['days'] as List<dynamic>)
            .map((d) => Day.fromJson(d as Map<String, dynamic>))
            .toList(),
      );
}

class Day {
  final String date;
  final String summary;
  final List<Activity> items;

  Day({required this.date, required this.summary, required this.items});

  Map<String, dynamic> toJson() => {
        'date': date,
        'summary': summary,
        'items': items.map((item) => item.toJson()).toList(),
      };

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        date: json['date'] as String,
        summary: json['summary'] as String,
        items: (json['items'] as List<dynamic>)
            .map((i) => Activity.fromJson(i as Map<String, dynamic>))
            .toList(),
      );
}

class Activity {
  final String time;
  final String activity;
  final String location;

  Activity({required this.time, required this.activity, required this.location});

  Map<String, dynamic> toJson() => {
        'time': time,
        'activity': activity,
        'location': location,
      };

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        time: json['time'] as String,
        activity: json['activity'] as String,
        location: json['location'] as String,
      );
}