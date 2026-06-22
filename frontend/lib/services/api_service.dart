import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class ApiService {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://72.61.163.213:8081/api/todos';
    }
    return 'http://10.0.2.2:8081/api/todos';
  }

  static Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Todo.fromJson(json)).toList();
    }
    throw Exception('Erreur lors du chargement des todos');
  }

  static Future<Todo> createTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );
    if (response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body));
    }
    throw Exception('Erreur lors de la création du todo');
  }

  static Future<Todo> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${todo.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );
    if (response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body));
    }
    throw Exception('Erreur lors de la mise à jour du todo');
  }

  static Future<Todo> toggleComplete(int id) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/$id/toggle'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body));
    }
    throw Exception('Erreur lors du toggle du todo');
  }

  static Future<void> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Erreur lors de la suppression du todo');
    }
  }
}
