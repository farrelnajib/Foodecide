//
//  OptionsViewController.swift
//  Foodecide
//
//  Created by Farrel Anshary on 29/04/21.
//

import UIKit

class OptionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var optionsTable: UITableView!
    
    var parentController: MenuFormViewController?
    var index: Int?
    var itemSelected = IndexPath(row: 0, section: 0)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        optionsTable.dataSource = self
        optionsTable.delegate = self
        
        self.navigationItem.title = Constants.navTitles[index!]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = optionsTable.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionTableViewCell
        cell.name.text = Constants.options[index!][0][indexPath.row]
        cell.detail.text = Constants.options[index!][1][indexPath.row]
        
        if indexPath == itemSelected {
            cell.accessoryType = .checkmark
            cell.isSelected = true
        } else {
            cell.accessoryType = .none
            cell.isSelected = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.itemSelected = indexPath
        parentController?.changeOption(index: index!, value: indexPath.row)
        tableView.reloadData()
    }
}
