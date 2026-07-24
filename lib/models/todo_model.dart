class TodoModel {
  String id;
  String title;
  bool isCompleted;

  TodoModel({required this.id,required this.title, required this.isCompleted});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id : json['_id'] ??'',
      title: json['title'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id' : id,'title': title, 'isCompleted': isCompleted};
  }
}
