//
//  PhotoViewController.swift
//  Snapchat
//
//  Created by Eduardo on 19/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate { //Inheritances required
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var desc: UITextField!
    //Object used to allow user to take photo or select from gallery
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self //This class manages photo selection
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum  //Select type of image selection
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Recover selected photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let recoveredImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image.image = recoveredImage
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
