//
//  MenuViewController.swift
//  Foodecide
//
//  Created by Farrel Anshary on 29/04/21.
//

import UIKit
import CoreData

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var foods: [Food]?
    @IBOutlet weak var menuTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menuTable.dataSource = self
        menuTable.delegate = self
        reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let foodArray = foods else { return 0 }
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foods![indexPath.row]
        let cell = menuTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        cell.setup(food: food)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            let alert = UIAlertController(title: "Delete", message: "Your data will be deleted permanently", preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                let foodToDelete = self.foods![indexPath.row]
                self.context.delete(foodToDelete)
                
                self.save()
                do {
                    self.foods = try self.context.fetch(Food.fetchRequest())
                    DispatchQueue.main.async {
                        self.menuTable.deleteRows(at: [indexPath], with: .automatic)
                    }
                } catch let error as NSError {
                    print("Error, \(error), \(error.userInfo)")
                }
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        
        let configurations = UISwipeActionsConfiguration(actions: [deleteAction])
        configurations.performsFirstActionWithFullSwipe = true
        return configurations
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let formViewController = navigationController.topViewController as! MenuFormViewController
        formViewController.delegate = self
        formViewController.context = context
        formViewController.newFood = nil
        
        if (segue.identifier == "editSegue") {
            let rowSelected = menuTable.indexPathForSelectedRow!.row
            formViewController.newFood = foods![rowSelected]
        }
        
    }
}

extension MenuViewController: FormModalDelegate {
    func reloadData() {
        do {
            self.foods = try context.fetch(Food.fetchRequest())
            DispatchQueue.main.async {
                self.menuTable.reloadData()
            }
        } catch let error as NSError {
            print("Error, \(error), \(error.userInfo)")
        }
    }
    
    func save() {
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Error, \(error), \(error.userInfo)")
        }
    }
}
