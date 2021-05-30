//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Decagon on 26/05/2021.
//
import UIKit
import RealmSwift

class TodoViewController: UIViewController, UITextViewDelegate {
        @IBOutlet var textViewField: UITextView!
        var todo: String?
        var textViewFieldText: String?
        var item = TodoListItem()
    var completionHandler: (() -> Void)?
    // ok again
    
        override func viewDidLoad() {
            super.viewDidLoad()
            textViewField.delegate = self
            textViewField.text = todo
            navigationItem.rightBarButtonItem =
                UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneEditingTodo))
            navigationItem.rightBarButtonItem?.tintColor = .white
        }
    
    @objc func doneEditingTodo() {
        if (textViewField.text != nil) && textViewField.text != " " &&  !textViewField.text.isEmpty {
            textViewFieldText = textViewField.text
            
        }
        ViewModel.shared.updateTodo(todoItem: (textViewFieldText ?? ""), category: item)
        completionHandler?()
        navigationController?.popViewController(animated: true)
        
    }
    
}
