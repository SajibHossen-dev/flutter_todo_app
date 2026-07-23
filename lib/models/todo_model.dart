class TodoModel {

 String title;
 bool isCompleted;

  TodoModel({
    
    required this.title,
     required this.isCompleted});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      
      title: json['title'] ?? '',
       isCompleted: json['isCompleted'] ??false);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'isCompleted': isCompleted};
  }
}
