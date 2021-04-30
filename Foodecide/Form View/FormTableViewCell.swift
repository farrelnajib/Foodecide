//
//  FormTableViewCell.swift
//  Foodecide
//
//  Created by Farrel Anshary on 29/04/21.
//

import UIKit

protocol InputFieldDelegate {
    func didChange(text: String, index: Int)
}

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
    
    var delegate: InputFieldDelegate?
    @IBOutlet weak var input: UITextField!
    
    var value = ""
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        input.delegate = self
    }
    
    func setup(name: String, keyboardType: UIKeyboardType, placeholder: String, index: Int) {
        title.text = name
        input.keyboardType = keyboardType
        input.placeholder = placeholder
        self.index = index
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        input.resignFirstResponder()
        return false
    }
    
    @IBAction func valueInputted(_ sender: UITextField) {
        guard let text = input.text else { return }
        value = text
        delegate?.didChange(text: value, index: index)
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
