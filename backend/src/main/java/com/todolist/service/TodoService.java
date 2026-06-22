package com.todolist.service;

import com.todolist.model.Todo;
import com.todolist.repository.TodoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TodoService {
    
    private final TodoRepository todoRepository;
    
    public List<Todo> getAllTodos() {
        return todoRepository.findAllByOrderByCreatedAtDesc();
    }
    
    public Optional<Todo> getTodoById(Long id) {
        return todoRepository.findById(id);
    }
    
    public Todo createTodo(Todo todo) {
        return todoRepository.save(todo);
    }
    
    public Optional<Todo> updateTodo(Long id, Todo todoDetails) {
        return todoRepository.findById(id).map(todo -> {
            todo.setTitle(todoDetails.getTitle());
            todo.setDescription(todoDetails.getDescription());
            todo.setCompleted(todoDetails.isCompleted());
            return todoRepository.save(todo);
        });
    }
    
    public Optional<Todo> toggleComplete(Long id) {
        return todoRepository.findById(id).map(todo -> {
            todo.setCompleted(!todo.isCompleted());
            return todoRepository.save(todo);
        });
    }
    
    public boolean deleteTodo(Long id) {
        return todoRepository.findById(id).map(todo -> {
            todoRepository.delete(todo);
            return true;
        }).orElse(false);
    }
}
