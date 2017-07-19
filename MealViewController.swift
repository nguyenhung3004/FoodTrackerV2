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
    
    @IBOutlet weak var ratingControl: RatingControl!
    var segueStatus: String?
    var index: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        if segueStatus == "edit"{
            title = DataService.shared.meals[(index?.row)!].name
            textField.text = DataService.shared.meals[(index?.row)!].name
            image.image = DataService.shared.meals[(index?.row)!].image as? UIImage
            ratingControl.rating = Int(DataService.shared.meals[(index?.row)!].rating)
        }

    }
    
    @IBAction func saveButton(_ sender: Any) {
        let name = textField.text
        let image = self.image.image
        let rating = ratingControl.rating
        if segueStatus == "add"{
            DataService.shared.addMeal(name: name!, image: image!, rating: rating)
            dismiss(animated: true, completion: nil)
        }
        if segueStatus == "edit"{
            DataService.shared.updateMeal(name: name!, image: image!, rating: rating, index: index!)
            let _ = navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: Any) {
        let title = "Add Image"
        let message = "What would you like to do?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Pick Photo", style: .default, handler: pickPhoto))
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: takePhoto))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func pickPhoto(action: UIAlertAction) -> Void{
        unowned let weakself = self
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = weakself as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            weakself.present(imagePicker, animated: true, completion: nil)
        } else {}
    }
    
    func takePhoto(action: UIAlertAction) -> Void{
        unowned let weakself = self
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            weakself.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension MealViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        image.image = info[UIImagePickerControllerEditedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}

extension MealViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        title = textField.text
    }
}
