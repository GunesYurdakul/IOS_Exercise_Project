
//
//  MealViewController.swift
//  GUNES
//
//  Created by Güneş Yurdakul on 07/08/2017.
//  Copyright © 2017 gunesyurdakul. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController,  UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:Properties
    var meal: Meal?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate=self
        if let meal=meal{
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        else{
            navigationItem.title = NSLocalizedString ("New Meal", comment: "")
        }
        nameTextField.placeholder = NSLocalizedString("enter", comment: "")
        upateSaveButtonState()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK:UIDefault
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        upateSaveButtonState()
        navigationItem.title = nameTextField.text
        
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, cancelling",log: OSLog.default,type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        meal=Meal(name:name,photo:photo,rating:rating)
    }
    
    //MARK:Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode{
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The view is not in a navigation controller")
        }
    }
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated:true, completion:nil)
    }
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        else{
                fatalError("Expected a dictionary containing image, but was provided the following:\(info)")
        }
        
        photoImageView.image = selectedImage
        
        //dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    private func upateSaveButtonState(){
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

