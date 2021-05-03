//
//  CompareViewController.swift
//  Foodecide
//
//  Created by Farrel Anshary on 03/05/21.
//

import UIKit

enum Position {
    case left
    case right
}

class CompareViewController: UIViewController {
    @IBOutlet weak var rightStackView: UIStackView!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var leftFoodLabel: UILabel!
    @IBOutlet weak var rightFoodLabel: UILabel!
    
    @IBOutlet weak var comparisonView: UIView!
    
    @IBOutlet weak var optionsBox: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var sizeView: UIView!
    @IBOutlet weak var oilContentView: UIView!
    
    @IBOutlet weak var leftPriceLabel: UILabel!
    @IBOutlet weak var leftPriceDetailLabel: UILabel!
    
    @IBOutlet weak var rightPriceLabel: UILabel!
    @IBOutlet weak var rightPriceDetailLabel: UILabel!
    
    @IBOutlet weak var leftSizeLabel: UILabel!
    @IBOutlet weak var leftSizeDetailLabel: UILabel!
    
    @IBOutlet weak var rightSizeLabel: UILabel!
    @IBOutlet weak var rightSizeDetailLabel: UILabel!
    
    @IBOutlet weak var leftOilLabel: UILabel!
    @IBOutlet weak var leftOilDetailLabel: UILabel!
    
    @IBOutlet weak var rightOilLabel: UILabel!
    @IBOutlet weak var rightOilDetailLabel: UILabel!
    
    var leftFood: Food?
    var rightFood: Food?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        leftStackView.isHidden = true
        rightStackView.isHidden = true
        comparisonView.isHidden = true
        
        optionsBox.layer.cornerRadius = 10
        sizeView.layer.cornerRadius = 10
        priceView.layer.cornerRadius = 10
        oilContentView.layer.cornerRadius = 10
        
        leftButton.layer.cornerRadius = 10
        rightButton.layer.cornerRadius = 10
    }

    @IBAction func clickLeftButton(_ sender: UIButton) {
        performSegue(withIdentifier: "chooseMenuSegue", sender: leftButton)
    }
    
    @IBAction func clickRightButton(_ sender: UIButton) {
        performSegue(withIdentifier: "chooseMenuSegue", sender: rightButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navbar = segue.destination as! UINavigationController
        let destination = navbar.topViewController as! ChooseMenuViewController
        destination.delegate = self
        
        if (sender as? UIButton == leftButton) {
            destination.whichPosition = Position.left
        } else {
            destination.whichPosition = Position.right
        }
    }
    
    @IBAction func removeLeftSelection(_ sender: UIButton) {
        leftFood = nil
        comparisonView.isHidden = true
        leftStackView.isHidden = true
        leftButton.isHidden = false
    }
    
    
    @IBAction func removeRightSelection(_ sender: UIButton) {
        rightFood = nil
        comparisonView.isHidden = true
        rightStackView.isHidden = true
        rightButton.isHidden = false
    }
    
    func compare(leftFood: Food?, rightFood: Food?) {
        guard leftFood != nil,
              rightFood != nil
        else {
            return
        }
        
        comparisonView.isHidden = false
    }
}

extension CompareViewController: ChooseMenuDelegate {
    func chooseMenu(foodChosen: Food, position: Position) {
        if (position == .left) {
            leftFood = foodChosen
            leftFoodLabel.text = leftFood?.name
            leftStackView.isHidden = false
            leftButton.isHidden = true
        } else {
            rightFood = foodChosen
            rightFoodLabel.text = rightFood?.name
            rightStackView.isHidden = false
            rightButton.isHidden = true
        }
        
        compare(leftFood: leftFood, rightFood: rightFood)
    }
}
