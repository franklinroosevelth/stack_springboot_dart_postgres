import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import 'edit_todo_dialog.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showEditDialog(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildCheckbox(context),
              const SizedBox(width: 16),
              Expanded(child: _buildContent(context)),
              _buildDeleteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<TodoProvider>().toggleComplete(todo.id!),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: todo.completed 
              ? Theme.of(context).colorScheme.primary 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: todo.completed 
                ? Theme.of(context).colorScheme.primary 
                : Colors.grey.shade400,
            width: 2,
          ),
        ),
        child: todo.completed
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : null,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed ? Colors.grey : Colors.black87,
          ),
        ),
        if (todo.description != null && todo.description!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            todo.description!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              decoration: todo.completed ? TextDecoration.lineThrough : null,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (todo.createdAt != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: Colors.grey.shade400),
              const SizedBox(width: 4),
              Text(
                DateFormat('dd/MM/yyyy HH:mm').format(todo.createdAt!),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete_outline, color: Colors.red.shade300),
      onPressed: () => _confirmDelete(context),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EditTodoDialog(todo: todo),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la tâche ?'),
        content: Text('Voulez-vous vraiment supprimer "${todo.title}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              context.read<TodoProvider>().deleteTodo(todo.id!);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
