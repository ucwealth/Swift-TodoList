//
//  ViewModel.swift
//  ToDoList
//
//  Created by Decagon on 25/05/2021.
//
import RealmSwift
import Foundation

// MARK: VIEW MODEL

class ViewModel {
    // swiftlint:disable:next force_try
    let realm = try! Realm()
    static let shared = ViewModel()
    
    func addTodo(category: TodoListItem) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }

    }
    
    func deleteTodo(category: TodoListItem) {
        do {
            try self.realm.write {
                self.realm.delete(category)
            }
        } catch {
            print(error)
        }
    }
    
    func updateTodo(todoItem newItem: String, category: TodoListItem) {
        do {
            try self.realm.write {
                category.todoItem = newItem
                self.realm.add(category)
            }
        } catch {
            print(error)
        }
    }
    
}
