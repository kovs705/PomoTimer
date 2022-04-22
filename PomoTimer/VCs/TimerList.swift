//
//  TimerList.swift
//  PomoTimer
//
//  Created by Kovs on 19.04.2022.
//

import UIKit
import CoreData

class TimerList: UITableViewController {
    
    @IBOutlet var timerTableView: UITableView!
    var timers: [NSManagedObject] = []
    
    let timerCellIdentifier = "timerCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightAddButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(self.addTimer))
        self.navigationItem.rightBarButtonItem = rightAddButton
        self.navigationController?.navigationBar.prefersLargeTitles = true
        timerTableView.dataSource = self
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest      = NSFetchRequest<NSManagedObject>(entityName: "Timer")
        
        do {
            timers = try viewContext.fetch(fetchRequest)
            print("\(timers.count) timers added already")
            timerTableView.reloadData()
        } catch let error as NSError {
            print("Couldn't fetch timers, \(error), \(error.userInfo)")
        }
        
        // timerTableView.reloadData()
        
        // timerTableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    @objc func addTimer() {
        let alert = UIAlertController(title: "New Note", message: "Enter a name for the note", preferredStyle: .alert)
        
        // save button
        let saveNoteButton = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard
                let textField = alert.textFields?.first,
                let timerToSave = textField.text
            else {
                print("Note has not been saved")
                return
            }
            // save action:
            self.saveTimer(name: timerToSave)
            
        }
        // cancel button
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveNoteButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
    
    func saveTimer(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let viewContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Timer", in: viewContext)!
        
        let timer = NSManagedObject(entity: entity, insertInto: viewContext)
        
        timer.setValue(25, forKey: "minute")
        timer.setValue(0, forKey: "seconds")
        timer.setValue(false, forKey: "isMarked")
        timer.setValue("", forKey: "note")
        timer.setValue(1, forKey: "intervals")
        
        if name == "" || name.isEmpty {
            acceptAttention()
            return
        } else {
            timer.setValue(name, forKey: "name")
        }
        
        do {
            timers.insert(timer, at: 0)
            print("Successfully added")
            try viewContext.save()
            
            timerTableView.reloadData()
        } catch let error as NSError {
            print("Couldn't save the timer: \(error), \(error.userInfo)")
        }
    }
    
    func acceptAttention() {
        let attentionAlert = UIAlertController(title: "Enter note name", message: "Type something in field", preferredStyle: .alert)
        
        let acceptButton = UIAlertAction(title: "OK", style: .default) { (action) in
            self.addTimer()
        }
        
        attentionAlert.addAction(acceptButton)
        present(attentionAlert, animated: true)
    }
    

    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return timers.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let timer = self.timers[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: timerCellIdentifier, for: indexPath) as! TimerCell

        cell.setName(timerName: timer.value(forKey: "name") as! String)
        cell.setStar(isMarkedBool: timer.value(forKey: "isMarked") as! Bool)
        
        cell.translatesAutoresizingMaskIntoConstraints = false

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
