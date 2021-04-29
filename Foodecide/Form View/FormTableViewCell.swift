//
//  FormTableViewCell.swift
//  Foodecide
//
//  Created by Farrel Anshary on 29/04/21.
//

import UIKit

class FormTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class InputTableViewCell: FormTableViewCell, UITextFieldDelegate {
    @IBOutlet weak var input: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        input.delegate = self
    }
    
    func setup(name: String, keyboardType: UIKeyboardType, placeholder: String) {
        title.text = name
        input.keyboardType = keyboardType
        input.placeholder = placeholder
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        input.resignFirstResponder()
        return false
    }
}

class SelectTableViewCell: FormTableViewCell {
    @IBOutlet weak var selectedLabel: UILabel!
    
    func setup(name: String, index: Int, selected: Int) {
        title.text = name
        if (index == 0) {
            selectedLabel.text = Constants.options[index][0][selected]
        } else {
            selectedLabel.text = Constants.options[index][0][selected]
        }
    }

}
