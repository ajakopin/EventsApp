//
//  CreateEventViewController.swift
//  EventsApp
//
//  Created by ajakopin on 4/16/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    var selectedImage = UIImage?()
    var location = CLLocation?()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCamera()
    }
    
    func setUpCamera()
    {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
        
    }
    
    func createNewEvent()
    {
        let newEvent = Event?()
        newEvent!.host = kProfile
        newEvent!.details = detailsTextField.text
        newEvent!.title = titleTextField.text
        newEvent!.eventPicFile = PFFile(data: UIImagePNGRepresentation(selectedImage))
        newEvent!.location = PFGeoPoint(location: location)
        newEvent!.saveInBackgroundWithBlock(nil)
    }
    
    
    func geocodeLocationWithBlock(located : (succeeded : Bool, error : NSError!) -> Void)
    {
        var geocode = CLGeocoder()
        geocode.geocodeAddressString(locationTextField.text, completionHandler: { (placemarks, error) -> Void in
            if error != nil
            {
                showAlertWithError(error, self)
            }
            else
            {
                let locations : [CLPlacemark] = placemarks as! [CLPlacemark]
                self.location = locations.first?.location
                located(succeeded: true, error: nil)
            }
            
        })
    }
    
    @IBAction func onDoneButtonTapped(sender: UIBarButtonItem) {
        if titleTextField.text == "" || detailsTextField.text == "" || locationTextField.text == "" || selectedImage == nil
        {
            showAlert("Please fill out all required fields", nil, self)
        }
        else
        {
            dismissViewControllerAnimated(true, completion: { () -> Void in
                self.createNewEvent()
            })
        }
    }
    
    @IBAction func onCancelButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSelectPhotoButtonTapped(sender: UIButton) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.selectedImage = image
            
        })
    }
}