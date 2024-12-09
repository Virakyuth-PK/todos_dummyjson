import 'package:todo_dummy/model/todo_model.dart';

class LimitSkipModel {
  final List<TodoModel>? todos;
  final int? limit;
  final int? skip;
  final int? total;

  LimitSkipModel(
      {required this.limit,
      required this.skip,
      required this.total,
      required this.todos});
  factory LimitSkipModel.fromJson(Map<String, dynamic> json) {
    return LimitSkipModel(
      limit: json['limit'],
      skip: json['skip'],
      total: json['total'],
      todos: (json['todos'] as List<dynamic>?)
          ?.map((item) => TodoModel.fromJson(item))
          .toList(),
    );
  }
}
