//
//  MenuTableViewCell.swift
//  Foodecide
//
//  Created by Farrel Anshary on 29/04/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceView: UIView!
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeView: UIView!
    
    @IBOutlet weak var oilContentLabel: UILabel!
    @IBOutlet weak var oilContentView: UIView!
    
    let purple = UIColor(red: 1/255, green: 25/255, blue: 79/255, alpha: 1)
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(food: Food) {
        name.text = food.name
        
        priceLabel.text = String(food.price)
        priceLabel.frame.size = priceLabel.intrinsicContentSize
        priceView.layer.cornerRadius = priceView.bounds.size.height / 4
        if (food.price <= 15000) {
            priceView.backgroundColor = UIColor.systemGreen
            priceLabel.textColor = purple
        } else if (food.price > 45000) {
            priceView.backgroundColor = UIColor.systemRed
            priceLabel.textColor = UIColor.white
        } else {
            priceView.backgroundColor = UIColor.systemOrange
            priceLabel.textColor = purple
        }
        
        sizeLabel.text = Constants.options[0][0][Int(food.size)]
        sizeLabel.frame.size = sizeLabel.intrinsicContentSize
        sizeView.layer.cornerRadius = sizeView.bounds.size.height / 4
        if (food.size == 0) {
            sizeView.backgroundColor = UIColor.systemRed
            sizeLabel.textColor = UIColor.white
        } else if (food.size == 1) {
            sizeView.backgroundColor = UIColor.systemOrange
            sizeLabel.textColor = purple
        } else {
            sizeView.backgroundColor = UIColor.systemGreen
            sizeLabel.textColor = purple
        }
        
        oilContentLabel.text = Constants.options[1][0][Int(food.oilContent)]
        oilContentLabel.frame.size = oilContentLabel.intrinsicContentSize
        oilContentView.layer.cornerRadius = oilContentView.bounds.size.height / 4
        if (food.oilContent == 2) {
            oilContentView.backgroundColor = UIColor.systemRed
            oilContentLabel.textColor = UIColor.white
        } else if (food.oilContent == 1) {
            oilContentView.backgroundColor = UIColor.systemOrange
            oilContentLabel.textColor = purple
        } else {
            oilContentView.backgroundColor = UIColor.systemGreen
            oilContentLabel.textColor = purple
        }
    }
}
