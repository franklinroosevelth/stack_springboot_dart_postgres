import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/api_service.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  bool _isLoading = false;
  String? _error;

  List<Todo> get todos => _todos;
  List<Todo> get pendingTodos => _todos.where((t) => !t.completed).toList();
  List<Todo> get completedTodos => _todos.where((t) => t.completed).toList();
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTodos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _todos = await ApiService.getTodos();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addTodo(String title, String? description) async {
    try {
      final todo = Todo(title: title, description: description);
      final created = await ApiService.createTodo(todo);
      _todos.insert(0, created);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTodo(Todo todo) async {
    try {
      final updated = await ApiService.updateTodo(todo);
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = updated;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> toggleComplete(int id) async {
    try {
      final updated = await ApiService.toggleComplete(id);
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        _todos[index] = updated;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await ApiService.deleteTodo(id);
      _todos.removeWhere((t) => t.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
