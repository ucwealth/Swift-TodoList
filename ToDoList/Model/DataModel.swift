//
//  DataModel.swift
//  ToDoList
//
//  Created by Decagon on 25/05/2021.
//
import  RealmSwift
import Foundation

class TodoListItem: Object {
    @objc dynamic var todoItem: String = ""
    @objc dynamic var completed = false
}
