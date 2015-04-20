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
    @IBOutlet var detailsTextField: UIView!
    @IBOutlet weak var locationTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    var selectedImage = UIImage()
    
    
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
    
    @IBAction func onSelectPhotoButtonTapped(sender: UIButton) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.selectedImage = image
            
        })
    }
}
