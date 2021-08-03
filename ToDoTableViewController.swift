//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Wolfpack Digital on 03.08.2021.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate
{
    func checkmarkTapped(sender: ToDoCellTableViewCell)
    {
        if let indexPath = tableView.indexPath(for: sender)
        {
            var todo = todos[indexPath.row]
            todo.isComplete.toggle()
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
    

    
    var todos = [ToDo]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem

        if let savedToDos = ToDo.loadToDos()
        {
                todos = savedToDos
        } else
        {
                todos = ToDo.loadSampleToDos()
        }
    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue)
    {
        guard segue.identifier == "saveUnwind" else { return }
            let sourceViewController = segue.source as!
               ToDoDetailTableViewController
        
        if let todo = sourceViewController.todo
        {
                if let indexOfExistingToDo = todos.firstIndex(of: todo)
                {
                    todos[indexOfExistingToDo] = todo
                    tableView.reloadRows(at: [IndexPath(row:
                       indexOfExistingToDo, section: 0)], with: .automatic)
                } else
                {
                    let newIndexPath = IndexPath(row: todos.count, section: 0)
                    todos.append(todo)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        ToDo.saveToDos(todos)
    }
    
    
        
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier:
           "ToDoCellIdentifier", for: indexPath) as! ToDoCellTableViewCell
        
        let todo = todos[indexPath.row]
        cell.titleLabel?.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt
       indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit
       editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
