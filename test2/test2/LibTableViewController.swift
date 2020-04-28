//
//  LibTableViewController.swift
//  test2
//
//  Created by  Виталий on 13.04.2020.
//  Copyright © 2020 Bulavin. All rights reserved.
//

import UIKit

class LibTableViewController: UITableViewController {
    
   // var objects: [Model] = [
    //    emoji(emoji: "🩰", name: "kick1", description: "about", like: false),
    //    emoji(emoji: "🎟", name: "kick2", description: "about2", like: false),
    //    emoji(emoji: "🚓", name: "kick3", description: "about3", like: true)
    //]
    
    var objects: [Model] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        
        // описание таблицы
        self.title = "Library Mobile"
        //добавление кнопки edit слева
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue ) {
        guard segue.identifier == "saveSegue" else {return}
        let sourceVC = segue.source as! NewLabelTableViewController
        let emoji = sourceVC.insideEmoji
        
// логика редактирования или добавления нового объекта
       if let selectedIndexPath = tableView.indexPathForSelectedRow {
        //objects[selectedIndexPath.row] = emoji
        tableView.reloadRows(at: [selectedIndexPath], with: .fade)
      } else {
            let newIndexPath =  IndexPath(row: objects.count, section: 0)
          //  objects.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editE" else { return   }
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navigaionVC = segue.destination as! UINavigationController
        let newEmojiVC = navigaionVC.topViewController as! NewLabelTableViewController
        //newEmojiVC.insideEmoji = emoji
        newEmojiVC.title = "Edit"
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojicell", for: indexPath) as! EmTableViewCell
        let object = objects[indexPath.row]
       // cell.set(object: object)
        return cell
    }
    
    // параметр добавление кнопки удаление при нажатие Edit
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //удаление из таблицы
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   
    //разрешение на перемещение ячейки
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         return true
    }
    // код перемещения ячейки
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedLabel =  objects.remove(at:sourceIndexPath.row)
        objects.insert(movedLabel, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at:[indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen // цвет кнопки
       // action.image = UIImage(systemName: "checkmark.cicle" )
        return action
    }
}

//private func saveCell(withTitle lb1: String) {
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    let context = appDelegate.persis
//}


// MARK: - Core Data stack

var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }



