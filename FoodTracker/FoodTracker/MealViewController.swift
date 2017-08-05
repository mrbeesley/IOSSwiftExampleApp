//
//  MealViewController.swift
//  FoodTracker
//
//  Created by mbeesley on 7/31/17.
//  Copyright © 2017 mbeesley. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set the vc as the textfield delegate
        nameTextField.delegate = self
        
        // set up views if editing an existing meal
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // enable the save button only if the text field has a valid meal name
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // this property is either passed in through navigation or constructed as a new meal
    var meal: Meal?
    
    
    //MARK: Navigation
    
    // this method lets you configure a view controller before its presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // set the meal to be passed to MealTableViewController after the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentedViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationControler = navigationController {
            owningNavigationControler.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller")
        }
    }
    
    
    //MARK: Actions
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // disable the save button while they are editing the text
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = nameTextField.text
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
    
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // disable the save button while the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}

