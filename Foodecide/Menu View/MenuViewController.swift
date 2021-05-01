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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let foodArray = foods else { return 0 }
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foods![indexPath.row]
        let cell = menuTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        cell.name.text = food.name
        cell.detail.text = "\(food.price), \(Constants.options[0][0][Int(food.size)]), \(Constants.options[1][0][Int(food.oilContent)])"
        
        return cell
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
