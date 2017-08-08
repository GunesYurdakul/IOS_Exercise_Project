//
//  ViewController.swift
//  GUNES
//
//  Created by Güneş Yurdakul on 07/08/2017.
//  Copyright © 2017 gunesyurdakul. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate=self
        mealNameLabel.text = NSLocalizedString("Meal Name", comment: "")
        nameTextField.placeholder = NSLocalizedString("enter", comment: "")
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK:UIDefault
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text=textField.text
    }
    //MARK:Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated:true, completion:nil)
    }
    @IBAction func setDeafultMealNameText(_ sender: UIButton) {
        mealNameLabel.text="Default Text"
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
}

