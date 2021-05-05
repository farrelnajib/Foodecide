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
    var isNewFood: Bool = false
    
    var foodName: String = ""
    var foodPrice: Int64 = 0
    var foodSize: Int64 = 0
    var foodOilContent: Int64 = 0
    
    @IBOutlet weak var formTable: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.title = "Edit Menu"
        self.navigationController?.navigationBar.shadowImage = UIImage()

        // Do any additional setup after loading the view.
        formTable.delegate = self
        formTable.dataSource = self
        
        if newFood == nil {
            isNewFood = true
            saveButton.isEnabled = false
            
            self.title = "New Menu"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0 || indexPath.row == 1) {
            let cell = formTable.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! InputTableViewCell
            cell.delegate = self
            
            if (indexPath.row == 0) {
                let name = newFood != nil ? newFood!.name : foodName
                cell.setup(name: "Name", keyboardType: .default, placeholder: "Ex: Padang, Seblak", index: 0, value: name)
            } else {
                let priceString = foodPrice > 0 ? String(foodPrice) : ""
                let price = newFood != nil ? String(newFood!.price) : priceString
                cell.setup(name: "Price", keyboardType: .numberPad, placeholder: "Ex: 15000", index: 1, value: price)
            }
            
            return cell
        }
        else {
            let cell = formTable.dequeueReusableCell(withIdentifier: "selectionCell", for: indexPath) as! SelectTableViewCell
            
            if (indexPath.row == 2) {
                let value = newFood != nil ? Int(newFood!.size) : Int(foodSize)
                cell.setup(name: "Size", index: indexPath.row - 2, selected: value)
            } else {
                let value = newFood != nil ? Int(newFood!.oilContent) : Int(foodOilContent)
                cell.setup(name: "Oil Content", index: indexPath.row - 2, selected: value)
            }
            
            return cell
        }
    }
    
    @IBAction func modalDismiss(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(sender: UIButton) {
        if isNewFood {
            newFood = Food(context: self.context!)
        }
        newFood?.name = foodName
        newFood?.price = foodPrice
        newFood?.size = foodSize
        newFood?.oilContent = foodOilContent
        
        delegate?.save()
        delegate?.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selected = formTable.indexPathForSelectedRow!.row - 2
        
        let optionVC = segue.destination as! OptionsViewController
        optionVC.index = selected
        optionVC.parentController = self
        
        if (selected == 0) {
            optionVC.itemSelected = IndexPath(row: Int(foodSize), section: 0)
        } else {
            optionVC.itemSelected = IndexPath(row: Int(foodOilContent), section: 0)
        }
    }
    
    func changeOption(index: Int, value: Int) {
        if (index == 0) {
            foodSize = Int64(value)
        } else {
            foodOilContent = Int64(value)
        }
        
        formTable.reloadRows(at: [IndexPath(row: index + 2, section: 0)], with: .automatic)
    }
}

extension MenuFormViewController: InputFieldDelegate {
    func didChange(text: String, index: Int) {
        if (index == 0) {
            foodName = text
        } else {
            if let price = Int64(text) {
                foodPrice = price
            } else {
                foodPrice = 0
            }
        }
        
        saveButton.isEnabled = foodName != "" && foodPrice != 0
    }
}
