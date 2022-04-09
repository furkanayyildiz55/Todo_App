import 'package:flutter/rendering.dart';
import 'package:todo_app/models/task_model.dart';

abstract class LocalStorage {
  Future<void> addTask({required Task task});
  Future<void> getTask({required String id});
  Future<List<Task>> getAllTask();
  Future<bool> deleteTask({required Task task});
  Future<bool> updateTask({required Task task});
}

class HiveLocalStroage extends LocalStorage {
  @override
  Future<void> addTask({required Task task}) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTask({required Task task}) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTask() {
    // TODO: implement getAllTask
    throw UnimplementedError();
  }

  @override
  Future<void> getTask({required String id}) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<bool> updateTask({required Task task}) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
