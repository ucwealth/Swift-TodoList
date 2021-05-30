//  ViewController.swift
//  ToDoList
//  Created by Decagon on 24/05/2021.

import RealmSwift
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var table: UITableView!
    var realm: Realm!
    var toDoList: Results<TodoListItem> {
            return realm.objects(TodoListItem.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // swiftlint:disable:next force_try
        realm = try! Realm()

        table.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
        table.delegate = self
        table.dataSource = self
    }
    
    // MARK: Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let item = toDoList[indexPath.row]
        cell.textLabel!.text = item.todoItem
        cell.accessoryType = item.completed == true ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = toDoList[indexPath.row]
        guard let todoVC = storyboard?.instantiateViewController(withIdentifier: "todo")
        as? TodoViewController else { return }
        todoVC.title = "Edit Item"
        todoVC.todo = item.todoItem
        todoVC.completionHandler = {[weak self] in
            self!.table.reloadData()
        }
        todoVC.item = item
        navigationController?.pushViewController(todoVC, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    // ok ok ok ok ok
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = toDoList[indexPath.row]
            ViewModel.shared.deleteTodo(category: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addButtonTapped() {
        let alertVC = UIAlertController(title: "Add To Do", message: "what do you want to do?", preferredStyle: .alert)
        alertVC.addTextField { _ in
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
            alertVC.addAction(cancelAction)
            
            let addAction = UIAlertAction.init(title: "Add", style: .default) { _ in
                let todoItemTextField = (alertVC.textFields?.first)! as UITextField
                
                let newToDoListItem = TodoListItem()
                newToDoListItem.todoItem = todoItemTextField.text!
                newToDoListItem.completed = false
                
                ViewModel.shared.addTodo(category: newToDoListItem)
                self.table.insertRows(at: [IndexPath.init(row: self.toDoList.count-1, section: 0)], with: .automatic)
            }
            
            alertVC.addAction(addAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
}
