//
//  MenuFormViewController.swift
//  Foodecide
//
//  Created by Farrel Anshary on 29/04/21.
//

import UIKit
import CoreData

protocol FormModalDelegate {
    func reloadData()
    func save()
}

class MenuFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var context: NSManagedObjectContext? = nil
    var newFood: Food?
    var delegate: FormModalDelegate?
    
    @IBOutlet weak var formTable: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        formTable.delegate = self
        formTable.dataSource = self
        
        if newFood == nil {
            newFood = Food(context: self.context!)
            newFood?.size = 0
            newFood?.oilContent = 0
            
            saveButton.isEnabled = false
        }
        
        print(newFood)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0 || indexPath.row == 1) {
            let cell = formTable.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! InputTableViewCell
            cell.delegate = self
            
            if (indexPath.row == 0) {
                cell.setup(name: "Name", keyboardType: .default, placeholder: "Ex: Padang, Seblak", index: 0, value: newFood!.name)
            } else {
                cell.setup(name: "Price", keyboardType: .numberPad, placeholder: "Ex: 15000", index: 1, value: String(newFood!.price))
            }
            
            return cell
        }
        else {
            let cell = formTable.dequeueReusableCell(withIdentifier: "selectionCell", for: indexPath) as! SelectTableViewCell
            
            if (indexPath.row == 2) {
                cell.setup(name: "Size", index: indexPath.row - 2, selected: Int(newFood!.size))
            } else {
                cell.setup(name: "Oil Content", index: indexPath.row - 2, selected: Int(newFood!.oilContent))
            }
            
            return cell
        }
    }
    
    @IBAction func modalDismiss(sender: UIButton) {
        self.context?.delete(newFood!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(sender: UIButton) {
        delegate?.save()
        self.dismiss(animated: true, completion: delegate?.reloadData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selected = formTable.indexPathForSelectedRow!.row - 2
        
        let optionVC = segue.destination as! OptionsViewController
        optionVC.index = selected
        optionVC.parentController = self
        
        if (selected == 0) {
            optionVC.itemSelected = IndexPath(row: Int(newFood!.size), section: 0)
        } else {
            optionVC.itemSelected = IndexPath(row: Int(newFood!.oilContent), section: 0)
        }
    }
    
    func changeOption(index: Int, value: Int) {
        if (index == 0) {
            newFood!.size = Int64(value)
        } else {
            newFood!.oilContent = Int64(value)
        }
        
        formTable.reloadRows(at: [IndexPath(row: index + 2, section: 0)], with: .automatic)
    }
}

extension MenuFormViewController: InputFieldDelegate {
    func didChange(text: String, index: Int) {
        guard let food = newFood else { return }
        if (index == 0) {
            food.name = text
        } else {
            if let price = Int64(text) {
                food.price = price
            } else {
                food.price = 0
            }
        }
        
        saveButton.isEnabled = food.name != nil && food.name != "" && food.price != 0
    }
}
