//
//  ViewController.swift
//  FoodTracker
//
//  Created by mbeesley on 7/31/17.
//  Copyright © 2017 mbeesley. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set the vc as the textfield delegate
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
    
    @IBAction func selectImageFromPhotoGallery(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard in case it is still open from text input
        nameTextField.resignFirstResponder()
        
        // UIImagePickerControlelr is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        //imagePickerController.sourceType = .camera // use this line if you want the user to be able to take a picture
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }

    
    //MARK: UITextFieldDelegate functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    
    //MARK: UIImagePickerControllerDelegate functions
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // the user canceled so we need to dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // the info dictionary may contain multiple respresentations of the image. you want to use the original
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // set the photo image view to the selected image
        photoImageView.image = selectedImage
        
        // get rid of the picker you are done with it
        dismiss(animated: true, completion: nil)
    }

}

