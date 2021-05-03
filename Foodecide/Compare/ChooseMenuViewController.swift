//
//  ChooseMenuViewController.swift
//  Foodecide
//
//  Created by Farrel Anshary on 03/05/21.
//

import UIKit
import CoreData

protocol ChooseMenuDelegate {
    func chooseMenu(foodChosen: Food, position: Position)
}

class ChooseMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var foods = [Food]()
    var filteredData = [Food]()
    
    var whichPosition: Position?
    var delegate: ChooseMenuDelegate?

    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        
        menuTable.delegate = self
        menuTable.dataSource = self
        
        searchBar.delegate = self
        
        reloadData()
        filteredData = foods
    }
    
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = filteredData[indexPath.row]
        let cell = menuTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        cell.setup(food: food)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = filteredData[indexPath.row]
        delegate?.chooseMenu(foodChosen: food, position: whichPosition!)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? foods : foods.filter({ food in
            return food.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        menuTable.reloadData()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
