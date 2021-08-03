//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Wolfpack Digital on 03.08.2021.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController
{
    
    var todo: ToDo?
    
    var todos = [ToDo]()

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePickerView: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
  
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
           
        if let todo = todo
        {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else
        {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
   }

    func updateDueDateLabel(date: Date)
    {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }

    func updateSaveButtonState()
    {
        let shouldEnableSaveButton = titleTextField.text?.isEmpty ==
           false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    
    
    @IBAction func textEditingChanged(_ sender: UITextField)
    {
        updateSaveButtonState()
    }
    
    
    @IBAction func returnPressed(_ sender: UITextField)
    {
        sender.resignFirstResponder()
    }
 
    @IBAction func isCompleteButtonTapped(_ sender: UIButton)
    {
        isCompleteButton.isSelected.toggle()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker)
    {
        updateDueDateLabel(date: sender.date)
    }
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController?
    {
        guard let cell = sender as? UITableViewCell, let indexPath =
               tableView.indexPath(for: cell) else
            {
                return nil
            }
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailController = ToDoDetailTableViewController(coder: coder)
        detailController?.todo = todos[indexPath.row]
        
        return detailController
    }
    
    
    override func tableView(_ tableView: UITableView,
       heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath
        {
            case datePickerIndexPath where isDatePickerHidden == true:
                return 0
            case notesIndexPath:
                return 200
            default:
                return UITableView.automaticDimension
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
       indexPath: IndexPath)
    {
        if indexPath == dateLabelIndexPath
        {
            isDatePickerHidden.toggle()
            dueDateLabel.textColor = .black
            updateDueDateLabel(date: dueDatePickerView.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
    
        guard segue.identifier == "saveUnwind" else { return }
    
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete,
           dueDate: dueDate, notes: notes)
        
    }

}
