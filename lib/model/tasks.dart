class Task {
  final String id;
  final String title;
  final String description;
  final String dateDue;
  final String date;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dateDue,
    required this.date,
  });

  //from json
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      dateDue: json['dateDue'] ?? '',
      date: json['date'],
    );
  }

  //from map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['_id'],
      title: map['title'],
      description: map['description'],
      dateDue: map['dateDue'],
      date: map['date'],
    );
  }
}
