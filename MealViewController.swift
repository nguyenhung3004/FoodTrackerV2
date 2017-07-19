//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Hung Nguyen on 7/19/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    var segueStatus: String?
    var index: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        if segueStatus == "edit"{
            title = DataService.shared.meals[(index?.row)!].name
        }
    
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let name = textField.text
        let image = self.image.image
        if segueStatus == "add"{
            DataService.shared.addMeal(name: name!, image: image!, rating: 0)
            dismiss(animated: true, completion: nil)
        }
        if segueStatus == "edit"{
            DataService.shared.updateMeal(name: name!, image: image!, rating: 0, index: index!)
            let _ = navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        let _ = navigationController?.popViewController(animated: true)
    }
}
