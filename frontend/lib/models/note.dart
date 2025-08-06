class Note {
  String? id;
  String? userId;
  String? title;
  String? content;
  DateTime? dateAdded;

  Note({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.dateAdded,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'], // MongoDB usa _id
      userId: json['userId'],
      title: json['title'],
      content: json['content'],
      dateAdded: json['dateAdded'] != null
          ? DateTime.tryParse(json['dateAdded'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'userId': userId,
      'title': title,
      'content': content,
      'dateAdded': dateAdded?.toIso8601String(),
    };

    if (id != null) {
      data['_id'] = id;
    }

    return data;
  }
}
